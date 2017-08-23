# It is important to import app from api instead of config!!!
# If it is needed to import from config, use the below lines,
#   instead of 'from api import app'!
#
# from config import app
# from api import api
#
import os

from flask import render_template, request, abort, url_for, json
from sqlalchemy import exists
from pydub import AudioSegment

from api import app
from config import FLASK_DEBUG, uploaded_images, db, uploaded_files
from image_operations import create_thumbnail, sensitive_resize_and_overwrite, add_caption, concat_images
from models import Image, Content, File

# Resize options must be the same with clients
IMAGE_SIZE ={'size-1': {'w': 180, 'h': 240},
             'size-2': {'w': 375, 'h': 500},
             'size-3': {'w': 768, 'h': 1024}}

@app.route('/')
def index():
    return render_template('index.html', body='Hello!!!')

# Editor, it gets userid and postid as parameter.
@app.route('/edit/')
def editor():
    userid = request.args.get('userid')
    id = request.args.get('id')
    delete_url = url_for('api.contents_content_item', id=id)
    if userid and id:
        preview_url = '/docs/' + '?userid=' + str(userid) + '&id=' + str(id)
        url = url_for('api.contents_content_list') + str(id)
        return render_template('editor.html', id=id, authorid=userid, url=url, preview_url=preview_url, delete_url=delete_url)
    abort(400, 'userid or id parameters are missing.')

# Project list page, it gets userid and postid as parameter.
# If there is only userid, it shows list of projects that belongs to user.
# If there are both parameters, it shows related project in HTML.
@app.route('/docs/')
def doc():
    userid = request.args.get('userid')
    id = request.args.get('id')
    if not userid:
        abort(400, 'userid parameter is missing.')
    preview_url = '/docs/' + '?userid=' + str(userid) + '&id='
    api_url = url_for('api.contents_content_list')
    if id:
        url = api_url + str(id)
        edit_url = '/edit/' + '?userid=' + str(userid) + '&id=' + str(id)
        delete_url = url_for('api.contents_content_item', id=id)
        return render_template('doc.html', url=url, edit_url=edit_url, delete_url=delete_url, authorid=userid)
    url = api_url + '?userid=' + str(userid)
    return render_template('list.html', url=url, base_url=preview_url, authorid=userid)

# Rout to serve publicly avaible projects.
@app.route('/projects/<int:id>/')
def public_docs(id):
    doc = db.session.query(db.exists().where(Content.postid == id)).scalar()
    if doc and Content.query.filter(Content.postid == id).one().status:
        url = url_for('api.contents_content_item', id=id)
        return render_template('public_project.html', url=url)
    abort(404)


@app.route('/imageupload/', methods=['POST'])
def imageupload():
    photo = request.files.get('files[]')
    postid = request.form.get('id')
    size = request.form.get('size')
    filename = uploaded_images.save(photo)
    source_folder = app.config['UPLOADED_IMAGES_DEST'] + '/'
    if size:
        dimensions = IMAGE_SIZE[size]
        sensitive_resize_and_overwrite(source_folder+filename, dimensions['w'], dimensions['h'])
    create_thumbnail(source_folder, filename, source_folder+'thumbnails')
    image = Image(imagepath=uploaded_images.url(filename), postid=postid, thumbpath=uploaded_images.url('thumbnails/'+filename))
    db.session.add(image)
    db.session.commit()
    response = {'imageid': image.imageid,
                'imagepath': image.imagepath,
                'notes': image.notes,
                'thumbpath': image.thumbpath}
    return json.jsonify(response), 200


@app.route('/addcaption/')
def addcaption():
    imageid = request.args.get('imageid')
    caption_text = request.args.get('ctext')

    source_folder = app.config['UPLOADED_IMAGES_DEST'] + '/'
    image = Image.query.filter(Image.imageid == imageid).one()
    imagepath = image.imagepath.split('/')
    imagename = imagepath[-1]
    status, filename = add_caption(source_folder+imagename, caption_text, source_folder)
    create_thumbnail(source_folder, filename, source_folder+'thumbnails')
    new_image = Image(imagepath=uploaded_images.url(filename), postid=image.postid, thumbpath=uploaded_images.url('thumbnails/'+filename))
    db.session.add(new_image)
    db.session.commit()
    response = {'imageid': new_image.imageid,
                'imagepath': new_image.imagepath,
                'notes': new_image.notes,
                'thumbpath': new_image.thumbpath}
    return json.jsonify(response), 200


@app.route('/concat/')
def concatimages():
    imageid_list = json.loads(request.args.get('images'))

    image_list = []
    postid = 0
    source_folder = app.config['UPLOADED_IMAGES_DEST'] + '/'

    # Create lists of image paths for concat_images function from DB.
    for row in imageid_list:
        r = []
        for imgid in row:
            #Get image
            image = Image.query.filter(Image.imageid == int(imgid)).one()
            #Post id is needed for new image
            postid = image.postid
            #Get image name from URL
            imagepath = image.imagepath.split('/')
            imagename = imagepath[-1]
            r.append(source_folder+imagename)
        # r might be empty list so, this control is needed.
        if r:
            image_list.append(r)

    status, filename = concat_images(image_list, source_folder)
    # Save image  with thimbnail and send details from DB.
    if status:
        create_thumbnail(source_folder, filename, source_folder + 'thumbnails')
        new_image = Image(imagepath=uploaded_images.url(filename), postid=postid,
                          thumbpath=uploaded_images.url('thumbnails/' + filename))
        db.session.add(new_image)
        db.session.commit()
        response = {'imageid': new_image.imageid,
                    'imagepath': new_image.imagepath,
                    'notes': new_image.notes,
                    'thumbpath': new_image.thumbpath}
        return json.jsonify(response), 200
    abort(500)


@app.route('/fileupload/', methods=['POST'])
def fileupload():
    u_file = request.files.get('files[]')
    postid = request.form.get('id')
    filename = uploaded_files.save(u_file)
    file_ = File(filepath=uploaded_files.url(filename))
    db.session.add(file_)
    related_post = Content.query.filter(Content.postid == postid).one()
    related_post.files.append(file_)
    db.session.commit()
    response = {'fileid': file_.fileid,
                'filepath': file_.filepath}
    return json.jsonify(response), 200


@app.route('/voiceupload/', methods=['POST'])
def voiceupload():
    u_file = request.files.get('files[]')
    postid = request.form.get('id')
    imageid = request.form.get('imageid')
    filename = uploaded_files.save(u_file)
    # Convert it to mp3.
    filename_splitted = filename.split('.')
    if len(filename_splitted) > 1 and filename_splitted[1] != 'mp3':
        audio_file = AudioSegment.from_file(app.config['UPLOADED_FILES_DEST']+'/'+filename)
        mp3_file = audio_file.export(app.config['UPLOADED_FILES_DEST']+'/'+filename_splitted[0]+'.mp3', format="mp3")
        new_file_name = mp3_file.name
        os.remove(app.config['UPLOADED_FILES_DEST'] + '/' + filename)
    if(new_file_name):
        file_ = File(filepath=uploaded_files.url(filename_splitted[0]+'.'+'mp3'))
    else:
        file_ = File(filepath=uploaded_files.url(filename))
    db.session.add(file_)
    related_post = Content.query.filter(Content.postid == postid).one()
    related_post.files.append(file_)
    related_image = Image.query.filter(Image.imageid == imageid).one()
    related_image.voiceid = file_.fileid
    db.session.commit()
    response = {'fileid': file_.fileid,
                'filepath': file_.filepath}
    return json.jsonify(response), 200


### Mobile Pages ###
@app.route('/mobile/docs/')
def mobile_project_list():
    userid = request.args.get('userid')
    if not userid:
        abort(400, 'userid parameter is missing.')
    api_url = url_for('api.contents_content_list')
    edit_url = '/mobile/edit/?id='
    img_edit_url = '/mobile/image/'
    img_upload_url = '/mobile/imageupload/'
    return render_template('mobile/mobile-list.html', userid=userid, projectEditUrl=edit_url, imgEditUrl=img_edit_url, imgUploadUrl=img_upload_url)


@app.route('/mobile/edit/')
def mobile_editor():
    userid = request.args.get('userid')
    id = request.args.get('id')
    #delete_url = url_for('api.contents_content_item', id=id)
    if userid and id:
        #preview_url = '/docs/' + '?userid=' + str(userid) + '&id=' + str(id)
        #url = url_for('api.contents_content_list') + str(id)
        return render_template('mobile/mobile-edit.html')
    abort(400, 'userid or id parameters are missing.')


@app.route('/mobile/image/')
def mobile_image_details():
    id = request.args.get('id')
    return render_template('mobile/mobile-edit-img.html')


@app.route('/mobile/imageupload/')
def mobile_image_upload_page():
    id = request.args.get('id')
    return render_template('mobile/mobile-upload-image.html')


if __name__ == '__main__':
    app.run(debug=FLASK_DEBUG)

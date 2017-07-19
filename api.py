import os

from flask import Blueprint, request, json
from flask_restplus import Api, fields, Resource, reqparse, abort
from sqlalchemy import exists
from sqlalchemy.orm.exc import NoResultFound

from config import app, db, FLASK_DEBUG
from models import User, Content, File, Image

# Create tables.
db.create_all()

# Initialize Api object for RestPlus and Swagger.
api = Api(version='1.0', title='FabLab Documentation Tool API',
          description='Documentation tool for Fablab.')

# Create blueprint.
blueprint = Blueprint('api', __name__, url_prefix='/api')
api.init_app(blueprint)

######## Namespaces ########
ns_users = api.namespace('users', description='Simple user operations.')
ns_content = api.namespace('contents', description='Content operations.')
ns_images = api.namespace('images', description='Image operations.')
ns_files = api.namespace('files', description='File operations.')

######## Serializers ########
user = api.model('User', {
    'id': fields.Integer(attribute='userid',readOnly=True, description='The unique identifier of user'),
    'username': fields.String(required=True, description='Username of the user')
})

file_basic = api.model('BasicFile', {
    'id': fields.Integer(attribute='fileid', readOnly=True, description='The unique identifier of content'),
    'filepath': fields.String(description='Filepath of the file')
})

image_basic = api.model('ImageBasic', {
    'id': fields.Integer(attribute='imageid', readOnly=True, description='The unique identifier of content'),
    'imagepath': fields.String(description='Path of the image'),
    'thumbpath': fields.String(description='Path of the thumbnail'),
    'notes': fields.String(description='User notes')
})

content = api.model('Content', {
    'id': fields.Integer(attribute='postid', readOnly=True, description='The unique identifier of content'),
    'authorid': fields.Integer(required=True, description='ID of author'),
    'createtime': fields.DateTime(description='Timestamp in UNIX format'),
    'content': fields.String(description='Content body'),
    'status': fields.Boolean(description='Public status of content'),
    'title': fields.String(description='Title of the project'),
    'author': fields.Nested(user, attribute='user'),
    'files': fields.List(fields.Nested(file_basic)),
    'images': fields.List(fields.Nested(image_basic))
})

content_create = api.model('ContentCreate', {
    'authorid': fields.Integer(required=True, description='ID of author'),
    'createtime': fields.DateTime(description='Timestamp in UNIX format'),
    'content': fields.String(description='Content body'),
    'status': fields.Boolean(description='Public status of content'),
    'title': fields.String(description='Title of the project')
})

content_update = api.model('ContentUpdate', {
    'createtime': fields.DateTime(description='Timestamp in UNIX format'),
    'content': fields.String(description='Content body'),
    'status': fields.Boolean(description='Public status of content'),
    'title': fields.String(description='Title of the project')
})

image_update = api.model('ImageUpdate', {
    'notes': fields.String(description='User notes')
})

## TODO restplus can return uri
files = api.inherit('File', file_basic, {
    'posts': fields.List(fields.Nested(content))
})
# files = api.model('File', {
#     'id': fields.Integer(attribute='fileid', readOnly=True, description='The unique identifier of content'),
#     'filepath': fields.String(description='Filepath of the file'),
#     'posts': fields.List(fields.Nested(content))
# })

# image = api.model('Image', {
#     'id': fields.Integer(attribute='imageid', readOnly=True, description='The unique identifier of content'),
#     'imagepath': fields.String(description='Path of the image'),
#     'post': fields.Nested(content)
# })

image = api.inherit('Image', image_basic, {
    'post': fields.Nested(content)
})

pagination = api.model('A page of results', {
    'page': fields.Integer(description='Number of this page of results'),
    'pages': fields.Integer(description='Total number of pages of results'),
    'per_page': fields.Integer(description='Number of items per page of results'),
    'total': fields.Integer(description='Total number of results'),
})

content_list = api.inherit('List of Posts', pagination, {
    'items': fields.List(fields.Nested(content))
})

image_list = api.inherit('List of Images', pagination, {
    'items': fields.List(fields.Nested(image))
})

file_list = api.inherit('List of Files', pagination, {
    'items': fields.List(fields.Nested(files))
})

######## Parsers ########
pagination_arguments = reqparse.RequestParser()
pagination_arguments.add_argument('page', type=int, required=False, default=1, help='Page number')
pagination_arguments.add_argument('per_page', type=int, required=False, choices=[2, 10, 20, 30, 40, 50],
                                  default=10, help='Results per page')

user_arguments = reqparse.RequestParser()
user_arguments.add_argument('userid', type=int, required=False, help='ID of user')

content_arguments = reqparse.RequestParser()
content_arguments.add_argument('postid', type=int, required=False, help='ID of post')

# image_arguments = reqparse.RequestParser()
# image_arguments.add_argument('op', type=str, required=False, choices=['caption', 'vconcat', 'hconcat'],
#                              help='Operation that will be applied on image.')
# image_arguments.add_argument('caption_text')

######## Error handlers ########


# Define default error message for 500.
@api.errorhandler
def default_error_handler(e):
    message = 'An unhandled exception occurred.'

    if not FLASK_DEBUG:
        return {'message': message}, 500


# Define default error message for 404.
@api.errorhandler(NoResultFound)
def database_not_found_error_handler(e):
    return {'message': 'A database result was required but none was found.'}, 404


######## Resources ########

## User resource
@ns_users.route('/<int:id>')
@api.param('id', 'Unique ID of user.')
@api.response(404, 'User not found.')
class UserItem(Resource):

    @api.marshal_with(user)
    def get(self, id):
        """
        Returns user for the related id.
        """
        return User.query.filter(User.userid == id).one()


## Content resource
@ns_content.route('/<int:id>')
@api.param('id', 'Unique ID of Post.')
@api.response(404, 'Post not found.')
class ContentItem(Resource):

    @api.marshal_with(content)
    def get(self, id):
        """
        Returns post for the related id.
        """
        return Content.query.filter(Content.postid == id).one()

    @api.response(204, 'Content successfully removed.')
    def delete(self, id):
        """
        Deletes the desired post.
        """
        post_item = Content.query.filter(Content.postid == id).one()
        images = post_item.images
        for img in images:
            if img.imagepath:
                img_path = img.imagepath.split('/')
                img_name = img_path[-1]
                os.remove(app.config['UPLOADED_IMAGES_DEST'] + '/' + img_name)
                os.remove(app.config['UPLOADED_IMAGES_DEST'] + '/thumbnails/' + img_name)
        db.session.delete(post_item)
        db.session.commit()
        return None, 204

    @api.expect(content_update)
    @api.marshal_with(content, code=200)
    def put(self, id):
        """
        Updates the post.
        """
        # Get data from request.
        data = request.json
        title = data.get('title')
        status = data.get('status', False)
        content = data.get('content')
        createtime = data.get('createtime')

        # Get post from db.
        post = Content.query.filter(Content.postid == id).one()

        # Update changes and commit to db.
        if title:
            post.title = title
        post.status = status
        if content:
            post.content = content
        if createtime:
            post.createtime = createtime

        db.session.add(post)
        db.session.commit()
        return post, 200


## Content List resource
@ns_content.route('/')
class ContentList(Resource):

    @api.expect(pagination_arguments, validate=True)
    @api.expect(user_arguments, validate=True)
    @api.doc(params={'userid': 'ID of user to list their posts'})
    @api.marshal_with(content_list)
    def get(self):
        """
        Returns list of blog posts from a specified time period.
        """
        page_args = pagination_arguments.parse_args(request)
        page = page_args.get('page', 1)
        per_page = page_args.get('per_page', 10)
        userid = user_arguments.parse_args(request).get('userid', -1)

        query = Content.query
        if userid >= 0:
            query = query.filter(Content.authorid == userid)

        posts_page = query.paginate(page, per_page, error_out=False)

        return posts_page

    @api.expect(content_create)
    @api.marshal_with(content, code=201)
    def post(self):
        """
        Creates a new post.
        """
        # Get data from request.
        data = request.json
        authorid = data.get('authorid')
        title = data.get('title')
        status = data.get('status', False)
        content = data.get('content')
        createtime = data.get('createtime')
        # Check if the user exists.
        ret = db.session.query(exists().where(User.userid == authorid)).scalar()
        if not ret:
            abort(400, 'There is no user with this authorid.')

        # Create post and commit it to db.
        post = Content(authorid=authorid, title=title, status=status,
                       content=content, createtime=createtime)
        db.session.add(post)
        db.session.commit()

        return post, 201


## File List resource
@ns_files.route('/')
class FileList(Resource):
    @api.expect(pagination_arguments, validate=True)
    @api.marshal_with(file_list)
    def get(self):
        """
        Returns list of files from a specified content.
        """
        page_args = pagination_arguments.parse_args(request)
        page = page_args.get('page', 1)
        per_page = page_args.get('per_page', 10)

        query = File.query

        images_page = query.paginate(page, per_page, error_out=False)

        return images_page


## File resource
@ns_files.route('/<int:id>')
@api.param('id', 'Unique ID of File.')
@api.response(404, 'File not found.')
class FileItem(Resource):

    @api.marshal_with(files)
    def get(self, id):
        """
        Returns file for the related id.
        """
        return File.query.filter(File.fileid == id).one()

    @api.response(204, 'File successfully removed.')
    def delete(self, id):
        """
        Deletes the desired file.
        """
        file_item = File.query.filter(File.fileid == id).one()
        if file_item.filepath:
            file_path = file_item.filepath.split('/')
            file_name = file_path[-1]
            os.remove(app.config['UPLOADED_FILES_DEST']+'/'+file_name)
        db.session.delete(file_item)
        db.session.commit()
        return None, 204


## Image List resource
@ns_images.route('/')
class ImageList(Resource):
    @api.expect(pagination_arguments, validate=True)
    @api.expect(content_arguments, validate=True)
    @api.doc(params={'postid': 'ID of content to list their images'})
    @api.marshal_with(image_list)
    def get(self):
        """
        Returns list of images from a specified content.
        """
        page_args = pagination_arguments.parse_args(request)
        page = page_args.get('page', 1)
        per_page = page_args.get('per_page', 10)
        postid = content_arguments.parse_args(request).get('postid', -1)

        query = Image.query
        if postid >= 0:
            query = query.filter(Image.postid == postid)

        images_page = query.paginate(page, per_page, error_out=False)

        return images_page


## Image resource
@ns_images.route('/<int:id>')
@api.param('id', 'Unique ID of Image.')
@api.response(404, 'Image not found.')
class ImageItem(Resource):
    @api.marshal_with(image)
    def get(self, id):
        """
        Returns image for the related id.
        """
        return Image.query.filter(Image.imageid == id).one()

    @api.response(204, 'Image successfully removed.')
    def delete(self, id):
        """
        Deletes the desired image.
        """
        img_item = Image.query.filter(Image.imageid == id).one()
        if img_item.imagepath:
            img_path = img_item.imagepath.split('/')
            img_name = img_path[-1]
            os.remove(app.config['UPLOADED_IMAGES_DEST']+'/'+img_name)
            os.remove(app.config['UPLOADED_IMAGES_DEST'] + '/thumbnails/' + img_name)
        db.session.delete(img_item)
        db.session.commit()
        return None, 204

    @api.expect(image_update)
    @api.marshal_with(image, code=200)
    def put(self, id):
        """
        Updates the image.
        """
        # Get data from request.
        data = request.json
        notes = data.get('notes')

        # Get image from db.
        image = Image.query.filter(Image.imageid == id).one()

        # Update changes and commit to db.
        if notes:
            image.notes = notes

        db.session.add(image)
        db.session.commit()
        return image, 200

# Register blueprint to app
app.register_blueprint(blueprint)

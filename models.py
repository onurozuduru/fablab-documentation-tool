from datetime import datetime

from config import db

t_filemap = db.Table(
    'filemap', db.metadata,
    db.Column('ifile', db.ForeignKey(u'files.fileid'), index=True),
    db.Column('post', db.ForeignKey(u'posts.postid'), index=True)
)


class File(db.Model):
    __tablename__ = 'files'

    fileid = db.Column(db.Integer, primary_key=True, unique=True)
    filepath = db.Column(db.Text)

    posts = db.relationship(u'Content', secondary='filemap')
    voice = db.relationship('Image', backref='voice', lazy='dynamic')

    def __init__(self, filepath):
        self.filepath = filepath

    def __repr__(self):
        return '<File %r>' % self.fileid


class Image(db.Model):
    __tablename__ = 'images'

    imageid = db.Column(db.Integer, primary_key=True, unique=True)
    imagepath = db.Column(db.Text)
    thumbpath = db.Column(db.Text)
    notes = db.Column(db.String)
    postid = db.Column(db.ForeignKey(u'posts.postid'), index=True)
    voiceid = db.Column(db.ForeignKey(u'files.fileid'), index=True)

    post = db.relationship(u'Content',
                             backref=db.backref("images", cascade="all, delete-orphan"))

    def __init__(self, imagepath, postid, thumbpath=None, notes=None):
        self.imagepath = imagepath
        self.postid = postid
        self.thumbpath = thumbpath
        self.notes = notes

    def __repr__(self):
        return '<Image %r>' % self.imageid


class Content(db.Model):
    __tablename__ = 'posts'

    postid = db.Column(db.Integer, primary_key=True, unique=True)
    authorid = db.Column(db.ForeignKey(u'users.userid'), index=True)
    createtime = db.Column(db.DateTime)
    content = db.Column(db.String)
    status = db.Column(db.Integer, server_default=db.text("'0'"))
    title = db.Column(db.String(120))

    user = db.relationship(u'User')
    files = db.relationship(u'File', secondary='filemap')

    def __init__(self, authorid, createtime=None, title=None, content=None, status=False):
        self.authorid = authorid
        if createtime is None:
            self.createtime = datetime.utcnow()
        self.content = content
        self.status = status
        self.title = title

    def __repr__(self):
        return '<Content %r>' % self.postid


class User(db.Model):
    __tablename__ = 'users'

    userid = db.Column(db.Integer, primary_key=True, unique=True)
    username = db.Column(db.String(120), nullable=False, unique=True)
    password = db.Column(db.String(120), nullable=False)

    def __init__(self, username, password):
        self.username = username
        self.password = password

    def __repr__(self):
        return '<User %r>' % self.username
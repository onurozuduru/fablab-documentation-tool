from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os

# Debug status for Flask, it will be used in different places
#   that is why there is a constant.
from flask_uploads import UploadSet, IMAGES, configure_uploads, AllExcept, EXECUTABLES

FLASK_DEBUG = True
HOST_URL = 'http://10.20.214.148/'
HOST_PATH = '/var/www/fablabdocumentation.com/backend/' #TRY TO MAKE THIS AUTOMATIC. I CAN READ WHERE THE main.py is located.

app = Flask(__name__)
#app.wsgi_app = ProxyFix(app.wsgi_app)

# SQLAlchemy settings.
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql://root:vm1234@localhost/documentation"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# RestPlus settings
app.config['SWAGGER_UI_DOC_EXPANSION'] = "list"
app.config['RESTPLUS_VALIDATE'] = True
app.config['RESTPLUS_MASK_SWAGGER'] = False
app.config['ERROR_404_HELP'] = False

# Uploads Settings
app.config['SECRET_KEY'] = ('\xa3\xb6\x15\xe3E\xc4\x8c\xbaT\x14\xd1:'
                            '\xafc\x9c|.\xc0H\x8d\xf2\xe5\xbd\xd5')
app.config['UPLOADED_IMAGES_DEST'] = os.path.join(HOST_PATH, 'user_images')
app.config['UPLOADED_FILES_DEST'] = os.path.join(HOST_PATH, 'user_files')
app.config['UPLOADED_IMAGES_URL'] = HOST_URL + '_uploads/images/'
#app.config['UPLOADED_FILES_URL'] = HOST_URL + '_uploads/files/'

uploaded_images = UploadSet('images', IMAGES)
uploaded_files = UploadSet('files', AllExcept(EXECUTABLES))
configure_uploads(app, uploaded_images)
configure_uploads(app, uploaded_files)

# Initialize DB
db = SQLAlchemy(app)




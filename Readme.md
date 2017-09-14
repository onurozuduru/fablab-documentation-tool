# FabLab Documentation Tool

---

__This project is still under development!__

This repo only shows `v0.1`. Project will be continued to develop under below page.

https://gitlab.com/fablabdocumentation/documentation_backend

Developers:

- Ivan Sanchez Milara
- Onur Ozuduru

This is code of back-end and web client, Android client can be seen from [here.](https://github.com/onurozuduru/fablab-documentation-tool-android-client)

---

This readme explains the following topics:

- [How To Install](#how-to-install)
	- [Before Installation](#before-installation)
	- [Requirements](#requirements)
	- [Installation Steps](#installation-steps)
- [Missing Parts](#missing-parts)

## How To Install

### Before Installation

Database must be installed beforehand to use this software, it uses MySql but it can be changed to other ones too.

Please make sure that following packages are installed in your machine:

- [MySQL](https://www.mysql.com/)
- [FFmpeg](https://ffmpeg.org/)
- [Python 2.7.x](https://www.python.org/downloads/)

#### In Ubuntu 16.04

[This guide shows how to install MySQL on Ubuntu 16.04.](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04)

Below command installs FFmpeg on Ubuntu 16.04.

```bash
$ sudo apt-get install ffmpeg
```

### Requirements

All requirements for Python libraries are listed in `requirements.txt` file. They can be installed with below `pip` command.

```bash
$ pip install -r requirements.txt
```

### Installation Steps

In this section, installation steps are explained very briefly.

- Make sure that `MySQL`, `FFmpeg` and `Python 2.7.x` are installed and running in your machine.
- Install Python libraries on `requirements.txt`:

```bash
$ pip install -r requirements.txt
```

- Create a new database on MySQL (Only creating the database is enough).

```
mysql> CREATE DATABASE fablab;
```

- Exit from MySQL and create & populate tables with using data dump. `dump.sql` is located under `database` directory.

```bash
$ mysql -u <username> -p fablab < dump.sql
```

where `fablab` is your database name and `dump.sql` is the name of data dump file.

- In `config.py` change the below lines for your setup.

```python
HOST_URL = 'http://YOURDOMAIN/'
...
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql://USERNAME:PASSWORD@MACHINE/DBNAME"
```

- In `main.js` change below line for your domain.

```javascript
var HOST_URL = "http://YOURDOMAIN/";
```

- Run the application.

```bash
$ python main.py
```

- Since there is no login, user ID must be given to system manually on web client side. Below is an example URL to reach Web UI via web browser.

`http://localhost:5000/docs/?userid=4`

- Please note that if application cannot create folders for images and files,
it must be created manually or paths must be changed for a desired place on `config.py`.

    - In that case please create the folders with the following names under project folder:
    `user_images`, `user_images/thumbnails`, `user_files`.
    - Or modify the below lines for desired folders.

```python
app.config['UPLOADED_IMAGES_DEST'] = 'user_images'
app.config['UPLOADED_FILES_DEST'] = 'user_files'
```


- API documentation can be reached under `/api` endpoint. For example, `http://localhost:5000/api`

- To use Android application please see its Readme.md on Android client repo.

## Missing Parts

It must be noted that this code only covers the documentation tool after login. Since it will be wrap by a main login system for example; FabLab's login functions, **Login have not been implemented.**

**Therefore, an additional login system is needed.**

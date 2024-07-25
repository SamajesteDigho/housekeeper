# HOUSEKEEPER - SERVER APP

- [Introduction](#-introduction)
- [Installation](#-installation)
- [Usage](#-usage)


## Introduction
Here is the server side codebase for the HOUSEKEEPER FINDER APP. Here is the description of how to make it run.
It is coded using the PHP framework **Laravel 10** and PHP **8.1P**. The database used for this is **MySQL** installed
through **WAMP**.

## Installation
To run set up and make functional the codebase on a local server, there are some requirements and steps to follow.

#### Requirements
- **PHP 8.1** : Make sure your have PHP and the required version or latest.
- **Composer** : Composer should be installed in your system. This is to permit you update the vendor folder and download the
required libraries in thier specified versions with one command.
- **MySQL**: Make sure you have MySQL installed and that you have read and write permissions. This is to permit the app connect
to the database with the user credentials and manage the app database.


#### Steps
- **Clone the project repository to you local machine** : Make the codebase available locally.
~~~bash
git clone https://github.com/samajestdigho/housekeeper.git
~~~

- Open the folder in an IDE or position yourself from the terminal/console in the project diretory
~~~bash
code housekeeper/serverapp  # Opening in VSCode for example
---------------
cd housekeeper/serverapp    # Using the terminal/console
~~~

- **Intialize vendor and download dependencies** : Vendor files are not download with the git clone. So you need
to download them yourself using the following command:
~~~bash
composer install
~~~ 
**NB :** If composer is not installed or the above requirements are not available in thier defined versions, this command
is highly probable to fail.

- **Test the app** : If the above commands went through with no error, then you are good to go. Hit the following command,
then copy the link that is generated and open it in your browser. The result is as shown below
~~~bash
php artisan migrate --seed      # To mke migrations and seed is to generate fake data
php artisan serve               # Serve the app ans make it accessible from the browser locally
~~~
[![Landing Page](landingpage.png "Optional title")](landingpage.png)

**NB: _In case you will like to host it on a server, follow this very explicite and interesting video resources to make that comee through :_**
- Setup laravel project on Nginx server : [youtube](doc:https://youtu.be/c6ZsjOvGMGM?si=C2WLQA2a8D04lb3y)
- Setup MySQL on Nginx server and configure your laravel **.env** file : [youtube](doc:https://youtu.be/7yCoAN8p3b0?si=Z2CTE1o2QrVaf2Cb)


## Related Projects
- Housekeeper finder app (Mobile part)

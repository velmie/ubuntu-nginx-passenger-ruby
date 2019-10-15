# ubuntu-nginx-passenger-ruby
Phusion Passenger + Ruby 2.4 container. Builds upon on the Ubuntu 18.04 LTS unsing [phusion/passenger-docker](https://github.com/phusion/passenger-docker) container. You can find the docker automated build [here](https://registry.hub.docker.com/u/velmie/ubuntu-nginx-passenger-ruby/).

[![](https://images.microbadger.com/badges/image/velmie/ubuntu-nginx-passenger-ruby)](https://microbadger.com/images/velmie/ubuntu-nginx-passenger-ruby "Get your own image badge on microbadger.com")


### Services
All services are defined and managed using the phusion/baseimage methodology. Logs are output using syslog and can be accessed using ``docker logs {container}``.

* Nginx **1.14.0**
* Phusion Passenger **6.0.3**
* Ruby **2.4.6**
* Bundler **2.0.2**
* NodeJs **10.16.3**
* Redis server **4.0.9**
* XTERM environment support w/colors
* nano editor


### Default app folder
The container sets up an app folder in the following location:

``/home/app/webapp``

### Permissions fix (/home/app/webapp)
Make the user ``app`` owner of the ``/home/app/webapp`` folder
```bash
fix_app_permissions
```

By default, the system runs this script every hour.

To disable it, just edit the ``/etc/crontab`` file.

### Manage services

```bash
sv (start|stop|restart) nginx
```

[More information](http://smarden.org/runit/sv.8.html)

### Initial configuration

*  Set password

```bash
 docker exec container_id bash -c 'echo "app:password12345"|chpasswd'
```

Where ``password12345`` is the password and you should change it.

* Connect to container via SSH


```bash
ssh -A app@127.0.0.1 -p port
```

The ``port`` can be 22 or 10022 or any other for example

* Add your SSH key to user **app**

```bash
nano ~/.ssh/authorized_keys
```

* Reconnect to the container using SSH key
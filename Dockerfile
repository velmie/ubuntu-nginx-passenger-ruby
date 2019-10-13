FROM phusion/passenger-customizable:1.0.8

# ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# change resolv.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

# Set correct environment variables.
ENV HOME /root

# remove default ruby 2.5.5
RUN /usr/local/rvm/bin/rvm remove 2.5.5

# Install ruby 2.4
RUN /pd_build/ruby-2.4.6.sh

RUN /usr/bin/gem install bundler


ADD build/redis.conf /pd_build/config/redis.conf

RUN /pd_build/redis.sh
RUN rm -f /etc/service/redis/down

RUN /pd_build/nodejs.sh


RUN DEBIAN_FRONTEND="noninteractive" apt update

RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata

# install latest version of git
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git

# install latest version of nano
RUN DEBIAN_FRONTEND="noninteractive" apt install -y nano

# Install ACL (getfacl | setfacl)
RUN DEBIAN_FRONTEND="noninteractive" apt install -y acl

# Install zip & unzip
RUN DEBIAN_FRONTEND="noninteractive" apt install -y zip unzip


RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh


ADD build/sshd_config /etc/ssh/sshd_config

ADD build/.bashrc /root/.bashrc

RUN rm /etc/nginx/sites-enabled/default
ADD build/webapp.nginx /etc/nginx/sites-enabled/webapp.conf
RUN mkdir /home/app/webapp

RUN rm -f /etc/service/nginx/down

ADD build/fix_app_permissions.sh /usr/local/bin/fix_app_permissions
RUN chmod +x /usr/local/bin/fix_app_permissions
RUN /usr/local/bin/fix_app_permissions


# add "setup" script
RUN mkdir -p /root/setup
ADD build/setup.sh /root/setup/setup.sh
RUN chmod +x /root/setup/setup.sh
RUN (cd /root/setup/; /root/setup/setup.sh)

# set terminal environment
ENV TERM xterm

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*nod


# port and settings
EXPOSE 22
EXPOSE 80

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

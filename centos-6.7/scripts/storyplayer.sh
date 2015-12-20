# make sure we have compilers and such like
yum groupinstall -y 'Development Tools'

# add Webtatic repo for PHP 5.5 packages
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# install Nginx
yum install -y nginx

# configure SSL support
mkdir /etc/nginx/ssl
chmod 700 /etc/nginx/ssl
cp /tmp/storyplayer/ssl/nginx.crt /etc/nginx/ssl
cp /tmp/storyplayer/ssl/nginx.key /etc/nginx/ssl
cp /tmp/storyplayer/ssl/default.conf /etc/nginx/conf.d/
chkconfig nginx on

# install libzmq4 stable
git clone https://github.com/zeromq/zeromq4-x.git
( cd zeromq4-x && ./autogen.sh && ./configure && make -j 4 install )

# install PHP 5.5 from Webtatic repo
yum install -y php55w php55w-devel php55w-pear
echo | pecl install zmq-1.1.2
cp /tmp/storyplayer/zmq/centos6-zmq.ini /etc/php.d/zmq.ini

# install Supervisor
yum install -y python-setuptools
easy_install supervisor
mkdir /etc/supervisor.d
cp /tmp/storyplayer/supervisor/supervisord.conf /etc/supervisord.conf

# install our ZMQ echo server
cp /tmp/storyplayer/zmq/zmq-echo-server.php /usr/local/bin/zmq-echo-server.php
cp /tmp/storyplayer/zmq/zmq-echo-server.conf /etc/supervisor.d/zmq-echo-server.conf

# install other tools that we need
yum install -y screen

# now we're ready to start supervisor
supervisord -c /etc/supervisord.conf

# we need to get rid of the default firewall
service iptables save
service iptables stop
chkconfig iptables off

# clean up after ourselves
rm -rf /tmp/storyplayer
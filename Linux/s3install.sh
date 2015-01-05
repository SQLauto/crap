#!/bin/bash
wget http://downloads.sourceforge.net/project/fuse/fuse-2.X/2.8.4/fuse-2.8.4.tar.gz # get our version of fuse
tar -xzvf fuse-2.8.4.tar.gz
cd fuse-2.8.4
yum groupinstall -y "Development Tools"
./configure --prefix=/usr
yum install -y curl-devel libxml2-devel openssl-devel mailcap
make
make install
ldconfig
export PKG_CONFIG_PATH=/usr/lib/pkgconfig
pkg-config --modversion fuse
cd
wget http://s3fs.googlecode.com/files/s3fs-1.74.tar.gz # get our version of s3
tar -xzvf s3fs-1.74.tar.gz
cd s3fs-1.74
./configure --prefix=/usr
make
make install
touch /etc/passwd-s3fs && echo "AKIAJRZBB4RAPBORO6CA:QiO4sSB5RoZtExWaXLgEzIV+vr7QA5ooym+wVmiy" >> /etc/passwd-s3fs # password file creation
chmod 640 /etc/passwd-s3fs
echo "Enter S3 directory path: "
read x
mkdir /mnt/$x 
s3fs $x /mnt/$x #  mount for s3fs
mount
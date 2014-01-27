环境说明
========

- 操作系统: CentOS 6.5 X86_64
- YUM 源: 163, EPEL

--------------------------

## LNMP 环境

- Nginx 1.5.8 ( /usr/local/nginx )
- MySQL 5.5.35 ( /usr/local/mysql )
- PHP 5.5.7 ( /usr/local/php )

## 管理服务

```bash
# Nginx
service nginx start|reload|restart

# MySQL
service mysqld start|reload|restart

# PHP-FPM
service php-fpm start|reload|restart
```

## PHP 扩展 (待完成)

- pthreads 0.0.45
- xdebug 2.2.3

## 工具环境

- strace
- tree

## 源文件

- `puppet/modules/nginx/files` http://nginx.org/download/nginx-1.5.8.tar.gz
- `puppet/modules/php/files` http://www.php.net/get/php-5.5.7.tar.gz/from/this/mirror
- `puppet/modules/php/files` http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
- `puppet/modules/mysql/files` http://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.35-linux2.6-x86_64.tar.gz

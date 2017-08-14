FROM centos

RUN yum update

RUN yum install -y ca-certificates wget vim \
make gcc gcc-c++ \
readline-devel \
zlib-devel \
openssl-devel \
libxml2-devel \
libxslt-devel \
libuuid-devel \
python-devel \
postgresql-plperl \
perl-ExtUtils-Embed \
perl-DBD-Pg

ENV GOSU_VERSION 1.7
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN mkdir /docker-entrypoint-initdb.d

ENV PG_VERSION 9.6.0
RUN cd /tmp && wget "https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.gz" \
&& tar -xvf postgresql-${PG_VERSION}.tar.gz

RUN cd /tmp/postgresql-${PG_VERSION} \
&& ./configure \
--with-perl \
--enable-integer-datetimes \
--enable-thread-safety \
--enable-tap-tests \
--disable-rpath \
--with-uuid=e2fs \
--with-gnu-ld \
--with-pgport=5432 \
--with-python \
--with-openssl \
--with-libxml \
--with-libxslt \
&& make && make install

RUN sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/pgsql/postgresql.conf.sample

RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && chmod 2777 /var/run/postgresql

ENV PGDATA /var/lib/pgsql/data
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"
VOLUME /var/lib/pgsql/data

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / 
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]


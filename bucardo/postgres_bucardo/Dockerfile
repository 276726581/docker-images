FROM centos:7

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

ENV PG_MAJOR 9.6
ENV PG_VERSION 9.6.4
RUN cd /tmp && wget "https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.gz" \
&& tar -xvf postgresql-${PG_VERSION}.tar.gz

RUN cd /tmp/postgresql-${PG_VERSION} \
&& awk '$1 == "#define" && $2 == "DEFAULT_PGSOCKET_DIR" && $3 == "\"/tmp\"" { $3 = "\"/var/run/postgresql\""; print; next } { print }' src/include/pg_config_manual.h > src/include/pg_config_manual.h.new \
&& grep '/var/run/postgresql' src/include/pg_config_manual.h.new \
&& mv src/include/pg_config_manual.h.new src/include/pg_config_manual.h

RUN cd /tmp/postgresql-${PG_VERSION} \
&& ./configure \
--build="x86_64-linux-gnu" \
--enable-integer-datetimes \
--enable-thread-safety \
--enable-tap-tests \
--disable-rpath \
--with-uuid=e2fs \
--with-gnu-ld \
--with-pgport=5432 \
--with-system-tzdata=/usr/share/zoneinfo \
--prefix=/usr/local \
--with-includes=/usr/local/include \
--with-libraries=/usr/local/lib \
--with-openssl \
--with-libxml \
--with-libxslt \
--with-perl \
--with-python \ 
&& make -j "$(nproc)" world \
&& make install-world \
&& make -C contrib install

RUN sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/local/share/postgresql/postgresql.conf.sample

RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && chmod 2777 /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib64/perl5/CORE:$LD_LIBRARY_PATH
ENV PGDATA /var/lib/postgresql/data
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / 
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]


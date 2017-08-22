FROM 276726581/postgres_bucardo:9.6

RUN yum install -y make wget \
postgresql-plperl \
perl-Time-HiRes \
perl-ExtUtils-MakeMaker \
perl-ExtUtils-Embed \
perl-DBD-Pg \
perl-Sys-Syslog \
perl-CPAN

COPY Bucardo-5.4.1.tar.gz /tmp/
COPY DBIx-Safe-1.2.5.tar.gz /tmp/
COPY boolean-0.46.tar.gz /tmp/

RUN cd /tmp && tar -xvf Bucardo-5.4.1.tar.gz && tar -xvf DBIx-Safe-1.2.5.tar.gz && tar -xvf boolean-0.46.tar.gz

RUN cd /tmp/Bucardo-5.4.1 && perl Makefile.PL && make && make install
RUN cd /tmp/DBIx-Safe-1.2.5 && perl Makefile.PL && make && make install
RUN cd /tmp/boolean-0.46 && perl Makefile.PL && make && make install

RUN mkdir -p /var/run/bucardo && mkdir -p /var/log/bucardo

RUN yum install -y java-1.8.0-openjdk-devel


#Dockerfile
FROM centos:7
MAINTAINER timogroup "redmine@tiho-mobi.com"
USER root

#COPY
RUN mkdir -p /build
COPY ./ffmpeg-n4.1 /build/ffmpeg-n4.1
COPY ./fdk-aac-0.1.6 /build/fdk-aac-0.1.6
COPY ./opencore-amr-0.1.5 /build/opencore-amr-0.1.5
COPY ./opus-1.3 /build/opus-1.3
COPY ./vo-amrwbenc-0.1.3 /build/vo-amrwbenc-0.1.3

WORKDIR /build

RUN yum -y install gcc gcc-c++ make
RUN cd /build/fdk-aac-0.1.6 && ./configure && make -j 4 && make install
RUN cd /build/opencore-amr-0.1.5 && ./configure && make -j 4 && make install
RUN cd /build/opus-1.3 && ./configure && make -j 4 && make install
RUN cd /build/vo-amrwbenc-0.1.3 && ./configure && make -j 4 && make install

ENV LD_LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

RUN cd /build/ffmpeg-n4.1 \
&& ./configure --disable-x86asm --disable-ffplay --disable-ffprobe --disable-doc --disable-debug \
--disable-shared --enable-static --enable-protocol=file --enable-version3 \
--enable-libfdk_aac --enable-libopus --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvo-amrwbenc \
&& make -j 4 && make install


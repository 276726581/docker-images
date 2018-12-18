#Dockerfile
FROM centos:7
MAINTAINER timogroup "redmine@tiho-mobi.com"
USER root

#COPY
RUN mkdir -p /build
COPY ./ffmpeg-4.1.tar.gz /build/
COPY ./fdk-aac-2.0.0.tar.gz /build/
COPY ./opencore-amr-0.1.5.tar.gz /build/
COPY ./opus-1.3.tar.gz /build/
COPY ./vo-amrwbenc-0.1.3.tar.gz /build/

ENV LD_LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

WORKDIR /build

RUN yum -y install gcc gcc-c++ make libtool tar

RUN sed -i -e "s/build_libtool_libs=yes/build_libtool_libs=no/g" "/usr/bin/libtool"

RUN cd /build \ 
&& tar -xvf fdk-aac-2.0.0.tar.gz \
&& tar -xvf opencore-amr-0.1.5.tar.gz \
&& tar -xvf opus-1.3.tar.gz \
&& tar -xvf vo-amrwbenc-0.1.3.tar.gz \
&& tar -xvf ffmpeg-4.1.tar.gz

RUN cd /build/fdk-aac-2.0.0 \
&& ./configure --enable-static=yes --enable-shared=no && make -j 4 && make install

RUN cd /build/opencore-amr-0.1.5 \
&& ./configure --enable-static=yes --enable-shared=no && make -j 4 && make install

RUN cd /build/opus-1.3 \
&& ./configure --enable-static=yes --enable-shared=no && make -j 4 && make install

RUN cd /build/vo-amrwbenc-0.1.3 \
&& ./configure --enable-static=yes --enable-shared=no && make -j 4 && make install

RUN cd /build/ffmpeg-4.1 \
&& ./configure --disable-x86asm --disable-ffplay --disable-ffprobe --disable-doc --disable-debug \
--disable-shared --enable-static --enable-protocol=file --enable-version3 \
--pkg-config-flags="--static" \
--enable-libfdk_aac --enable-libopus --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvo-amrwbenc \
&& make -j 4 && make install



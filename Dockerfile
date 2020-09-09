FROM ubuntu:groovy
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN apt-get update -qq && apt-get install  -y make git zlib1g-dev libssl-dev gperf php cmake clang-10 libc++-dev libc++abi-dev && git clone https://github.com/tdlib/td.git /root/td && mkdir /root/td/build \
export CXXFLAGS="-stdlib=libc++" \
CC=/usr/bin/clang-10 CXX=/usr/bin/clang++-10 cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib -DTD_ENABLE_LTO=ON -DCMAKE_AR=/usr/bin/llvm-ar-10 -DCMAKE_NM=/usr/bin/llvm-nm-10 -DCMAKE_OBJDUMP=/usr/bin/llvm-objdump-10 -DCMAKE_RANLIB=/usr/bin/llvm-ranlib-10 .. 
RUN mkdir /root/out \
cmake --build .  && cp /root/td/build/*.so /root/out

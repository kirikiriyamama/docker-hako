FROM ruby:2.6.3-alpine

WORKDIR /opt/hako

RUN apk add --no-cache g++ git make && \
    git clone https://github.com/google/jsonnet.git /tmp/jsonnet && \
    cd /tmp/jsonnet && \
    git checkout v0.11.2 && \
    make libjsonnet.so && \
    cp libjsonnet.so /usr/local/lib/libjsonnet.so && \
    cp include/libjsonnet.h /usr/local/include/libjsonnet.h

COPY Gemfile Gemfile.lock /opt/hako/
RUN JSONNET_USE_SYSTEM_LIBRARIES=1 bundle install

ENTRYPOINT ["hako"]

FROM ruby:2.5.3

ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
	&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -L https://git.io/n-install | N_PREFIX=/usr/local/n bash -s -- -y 8.11.4
ENV PATH /usr/local/n/bin:$PATH

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libpq-dev \
		libxml2 \
		libxml2-dev \
		libxslt1-dev \
		postgresql-client \
	&& rm -rf /var/lib/apt/lists/*

ENV BUNDLER_VERSION 1.16.4
RUN gem install bundler -v ${BUNDLER_VERSION}

COPY \
	Gemfile \
	Gemfile.lock \
	/app/
RUN bundle install --jobs=4

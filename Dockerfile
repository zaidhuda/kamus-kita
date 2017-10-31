FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# wkhtmltopdf
RUN apt-get -y install xvfb libjpeg-turbo8 xfonts-75dpi
RUN wget https://bitbucket.org/wkhtmltopdf/wkhtmltopdf/downloads/wkhtmltox-0.13.0-alpha-7b36694_linux-trusty-amd64.deb \
    && dpkg -i wkhtmltox-0.13.0-alpha-7b36694_linux-trusty-amd64.deb \
    && apt-get -f install -y
RUN echo 'exec xvfb-run -a -s "-screen 0 640x480x16" wkhtmltopdf "$@"' | tee /usr/local/bin/wkhtmltopdf.sh >/dev/null \
    && chmod a+x /usr/local/bin/wkhtmltopdf.sh

# Init ruby gems
RUN mkdir -p /kamuskita
WORKDIR /kamuskita
ADD Gemfile /kamuskita/
ADD Gemfile.lock /kamuskita/
RUN bundle install

ADD . /kamuskita

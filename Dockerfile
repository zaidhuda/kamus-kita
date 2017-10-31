FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# wkhtmltopdf
RUN yum install -y xorg-x11-fonts-75dpi
RUN yum install -y xorg-x11-fonts-Type1
RUN yum install -y icu libXext libXrender
RUN wget https://bitbucket.org/wkhtmltopdf/wkhtmltopdf/downloads/wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm \
    && rpm -Uvh wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm

# Init ruby gems
RUN mkdir -p /kamuskita
WORKDIR /kamuskita
ADD Gemfile /kamuskita/
ADD Gemfile.lock /kamuskita/
RUN bundle install

ADD . /kamuskita

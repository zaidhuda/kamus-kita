FROM ruby:2.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# wkhtmltopdf
RUN apt-get install -y build-essential xorg libssl-dev libxrender-dev wget gdebi
RUN wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN gdebi --n wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
ENTRYPOINT ["wkhtmltopdf"]

# Init ruby gems
RUN mkdir -p /kamuskita
WORKDIR /kamuskita
ADD Gemfile /kamuskita/
ADD Gemfile.lock /kamuskita/
RUN bundle install

ADD . /kamuskita

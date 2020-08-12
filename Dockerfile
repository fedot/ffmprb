FROM debian:stretch

RUN bash -c 'apt update; apt -y install ruby-all-dev=1:2.3.3 ffmpeg=7:3.2.15-0+deb9u1 sox=14.4.1-5+deb9u2 build-essential=12.3 libmagickwand-dev=8:6.9.7.4+dfsg-11+deb9u8 git=1:2.11.0-3+deb9u7 pkg-config=0.29-4+b1'
RUN gem install bundler -v '~> 2.0'

WORKDIR /ffmprb

ADD Gemfile Gemfile.lock ffmprb.gemspec ./
ADD lib/ffmprb/version.rb ./lib/ffmprb/version.rb
RUN bundle install

ENTRYPOINT ["bundle", "exec", "ffmprb"]

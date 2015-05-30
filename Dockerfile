# 

FROM phusion/baseimage

RUN apt-get update
RUN apt-get -yq install build-essential git-core curl libssl-dev \
                   libreadline5 libreadline-gplv2-dev \
                   zlib1g zlib1g-dev \
                   libmysqlclient-dev \
                   libcurl4-openssl-dev \
                   libxslt-dev libxml2-dev
 
# Install rbenv
RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
 
# Add rbenv to the path:
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh && \
  	echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
	  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
 
RUN chmod +x /etc/profile.d/rbenv.sh && . /etc/profile.d/rbenv.sh
 
# Install ruby-build:
RUN mkdir /usr/local/rbenv/plugins && \
    git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Install Ruby
RUN rbenv install 2.1.2 && rbenv global 2.1.2 && rbenv rehash

# Production installing gems skipping ri and rdoc
RUN echo '---'                        > /root/.gemrc && \
  echo ':sources: ' 				         >> /root/.gemrc && \ 
	echo '- http://gems.rubyforge.org' >> /root/.gemrc && \ 
	echo '- http://gems.github.com'    >> /root/.gemrc && \ 
	echo 'gem: --no-ri --no-rdoc'       >> /root/.gemrc 


RUN gem install bundler

RUN gem install rails -v 4.1.4 && rbenv rehash

RUN gem install unicorn


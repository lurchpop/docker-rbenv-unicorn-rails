# docker-rbenv-unicorn-rails
Dockerfile base for rbenv, Ruby on Rails and Unicorn
### Features 
  - Based on phusion/baseimage (Ubuntu 14.04)
  - RBEnv set up for multi-user in /usr/local/rbenv instead of root's home dir
  - Installs bundler
  - Ruby 2.1.2
  - Rails 4.1.4
  - Installs unicorn (stable? -- no args)
  - /etc/init.d script
   
  
### Todo
  - rails and unicorn log to host(?)
  - RAILS_ENV passed to init.d script
  - example cascade script
  - create base image so you don't have to wait goddamn 50 years for ruby to build



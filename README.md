# Getting started
sudo apt install ruby ruby-dev
sudo apt install mecab mecab-ipadic-utf8 libmecab-dev libffi-dev
sudo gem install bundler

git clone https://github.com/tsunematsu21/negaposi-test.git
cd negaposi-test
bundle install --path=/vendor/bundle

./negaposi.rb

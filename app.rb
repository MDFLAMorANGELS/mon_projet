require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__)
require 'scrapper'

Emails_Val_D_Oise.new.perform
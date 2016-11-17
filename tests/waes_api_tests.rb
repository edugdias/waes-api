# File: waes_api_tests.rb
#
# This is a ruby script that uses Minitest and RackTest to test Sinatra Application

# TODO:
# - improve looging for debugging
# - improve te code to define variables, intead of use it as harded code

# Requirements:
# - Linux Ubuntu 14.04 prefered
# - Ruby 2.1.5
# - Rubygems
#    - Sinatra
#    - Json
#    - Base64

# How to run the tests:
# ruby tests/waes_api_tests.rb

require 'minitest/autorun'
require 'rack/test'
require 'base64'

require_relative '../weas_api.rb'

class MainAppTest < Minitest::Test
  include Rack::Test::Methods 

  def app
    Sinatra::Application
  end

  # Test if the application is running and responding with main page
  def test_application_running
    get '/v1/main'
    assert last_response.ok?
    assert last_response.body.include?('Hello world')
  end

  # Test if is possible to read user name and country
  def test_read_all_info
    get '/v1/read_all?data=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D'
    assert last_response.ok?
    assert last_response.body.include?('Eduardo')
    assert last_response.body.include?('Brazil')
  end

  # Test if fails when JSON doesn't have user name
  def test_read_all_info_without_name
    get '/v1/read_all?data=eyAiQ291bnRyeSI6ICJCcmF6aWwiIH0='
    assert last_response.body.include?('Name field was not found in JSON')
  end

  # Test if fails when JSON doesn't have user country
  def test_read_all_info_without_country
    get '/v1/read_all?data=eyJOYW1lIjogIkVkdWFyZG8ifSA='
    assert last_response.body.include?('Country field was not found in JSON')
  end

  # Test if is possible to read user name
  def test_read_user_name
    get '/v1/read_all?data=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D'
    assert last_response.ok?
    assert last_response.body.include?('Eduardo')
  end

  # Test if is possible to read user country
  def test_read_user_country
    get '/v1/read_all?data=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D'
    assert last_response.ok?
    assert last_response.body.include?('Brazil')
  end

  # Test if the users have the same country configured
  def test_compare_user_w_same_country
    get '/v1/compare_country?data1=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D&data2=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D'
    assert last_response.ok?
    assert last_response.body.include?('The users live in the same country')
  end

  # Test if the users don't have the same country configured
  def test_compare_user_w_different_country
    get '/v1/compare_country?data1=eyJOYW1lIjogIkVkdWFyZG8iLCAiQ291bnRyeSI6ICJCcmF6aWwiIH0%3D&data2=eyJOYW1lIjogIkplcm9lbiIsICJDb3VudHJ5IjogIkhvbGxhbmQiIH0='
    assert last_response.ok?
    assert last_response.body.include?('The users live in different countries')
  end

  # Test if redirect is working well
  # def test_redirect
  # TODO:
  # redirect has a trick related to response, it needs more investigation
  # end

end

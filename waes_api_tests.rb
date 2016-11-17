# File: waes_api_tests.rb
#
# It is an API based on Sinatra
# - http://www.sinatrarb.com/
# - https://github.com/sinatra/sinatra

# TODO:
# - improve looging for debugging
# - improve te code to define variables, intead of use it as harded code

# The API implements 5 methods, to know:
# - main:            returns a wellcome main page
# - read_all:        returns the user name and country from a JSON 64BAse encoded binary data
# - read_name:       returns the user name from a JSON 64BAse encoded binary data
# - read_country:    returns the user country from a JSON 64BAse encoded binary data
# - compare_country: returns if the users live or not in the same country from a JSON 64BAse encoded binary data
# - redirect:        redirect to a new page based on the user country

# Requirements:
# - Linux Ubuntu 14.04 prefered
# - Ruby 2.1.5
# - Rubygems
#    - Sinatra
#    - Json
#    - Base64

# How to start the application:
# $ ruby weas_api.rb

# How to use it:
# Create a JSON 64encoded using the JSON example below:
# {"Name": "Eduardo", "Country": "Brazil" }
# For compare_cuntry entry point use the link below:
# http://localhost:4567/vi/compare_cuntry?data1=<json_encoded1>&data2=<json_encoded2>
# For all others entry points uses the link example below:
# http://localhost:4567/vi/read_XXXX?data=<json_encoded>

require 'sinatra'
require 'json'
require 'base64'

# This method returns the main page
get '/v1/main' do
  'Hello world! It is a Ruby API based on Sinatra DSL'
end

# This method returns the main page
get '/v1/redirect' do
  begin
    content_type :text
    json = Base64.decode64(request[:data])
    json_content = JSON.parse(json)
    if json_content['Country'].to_s.empty?
        raise JSON::ParserError, "Country field was not found in JSON"
    end
    if json_content['Country'].eql?('Brazil')
      redirect '/vi/portuguese'
    else
      redirect '/vi/english'
    end
  rescue JSON::ParserError => e
    return "#{e}"
  end
end

get '/vi/english' do
  return "Wellcome to our webpage"
end

get '/vi/portuguese' do
  return "Bem vindo ao nosse site"
end

# This method list the User Name and Country of some JSON 64base encoded data
get '/v1/read_all' do
  begin
    content_type :text
    json = Base64.decode64(request[:data])
    json_content = JSON.parse(json)
    if json_content['Name'].to_s.empty?
        raise JSON::ParserError, "Name field was not found in JSON"
    end
    if json_content['Country'].to_s.empty?
        raise JSON::ParserError, "Country field was not found in JSON"
    end
    return "The user name is #{json_content['Name']} and the country is #{json_content['Country']}"
  rescue JSON::ParserError => e
    return "#{e}"
  end
end

# This method list the User Name of some JSON 64base encoded data
get '/v1/read_name' do
  begin
    content_type :text
    json = Base64.decode64(request[:data])
    json_content = JSON.parse(json)
    if json_content['Name'].to_s.empty?
        raise JSON::ParserError, "Name field was not found in JSON"
    end
    return "The user name is #{json_content['Name']}"
  rescue JSON::ParserError => e
    return "#{e}"
  end
end

# This method list the User Country of some JSON 64base encoded data
get '/v1/read_country' do
  begin
    content_type :text
    json = Base64.decode64(request[:data])
    json_content = JSON.parse(json)
    if json_content['Country'].to_s.empty?
        raise JSON::ParserError, "Country field was not found in JSON"
    end
    return "The user country is #{json_content['Country']}"
  rescue JSON::ParserError => e
    return "#{e}"
  end
end

get '/v1/compare_country' do
  begin
    content_type :text
    json1 = Base64.decode64(request[:data1])
    json2 = Base64.decode64(request[:data2])

    json_content1 = JSON.parse(json1)
    json_content2 = JSON.parse(json2)

    if json_content1['Country'].to_s.empty? || json_content2['Country'].to_s.empty?
        raise JSON::ParserError, "Country field was not found in JSON"
    end
    country1 = json_content1['Country']
    country2 = json_content2['Country']

    if country1.eql?(country2)
     return "The users live in the same country"
    else
     return "The users live in different countries"
    end
  rescue JSON::ParserError => e
    return "#{e}"
  end
end

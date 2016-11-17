# waes-api

It is an API based on Sinatra
 - http://www.sinatrarb.com/
 - https://github.com/sinatra/sinatra

 The API implements 5 methods, to know:
 - main:            returns a wellcome main page
 - read_all:        returns the user name and country from a JSON 64BAse encoded binary data
 - read_name:       returns the user name from a JSON 64BAse encoded binary data
 - read_country:    returns the user country from a JSON 64BAse encoded binary data
 - compare_country: returns if the users live or not in the same country from a JSON 64BAse encoded binary data
 - redirect:        redirect to a new page based on the user country

 Requirements:
 - Linux Ubuntu 14.04 prefered
 - Ruby 2.1.5
 - Rubygems
    - Sinatra
    - Json
    - Base64

 How to start the application:
 $ ruby weas_api.rb

 How to use it:
 - Create a JSON 64encoded using the JSON example below:
   {"Name": "Eduardo", "Country": "Brazil" }
 - For compare_cuntry entry point use the link below:
   http://localhost:4567/vi/compare_cuntry?data1=<json_encoded1>&data2=<json_encoded2>
 - For all others entry points uses the link example below:
   http://localhost:4567/vi/read_XXXX?data=<json_encoded>

# CDN Exercise
# 
# Create a container using the request interface and make it public using the CDN service. Print out CDN headers.
#
# The demo console logs can be found here:
#
# Hint: http://developer.rackspace.com/#ruby
#

# require rubygems library if using 1.8.7
require 'rubygems'

require 'fog'

service = Fog::Storage.new :provider => 'rackspace', :rackspace_region => :ord

container_name = "cdn-exercise"

service.put_container container_name

r = service.cdn.put_container container_name, "X-Cdn-Enabled" => "True"

r.headers.each {|k,v| puts "#{k}: #{v}"}

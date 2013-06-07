# Cloud Servers Exercise
# 
# Create a server using bootstrap and execute `uname -a` on the remote server 
#
# The demo console logs can be found here:
#
# Hint: http://developer.rackspace.com/#ruby
# 

# require rubygems library if using 1.8.7
require 'rubygems'

require 'fog'

# create connection to Storage Service
service = Fog::Storage.new :provider => 'rackspace', :rackspace_region => :ord

# create container backed by CDN (AKA public container)
dir = service.directories.create :key => 'sdk-exercise', :public => true

# upload file
file = dir.files.create :key => 'fog.png', :body => File.read('fog.png')

puts "Public URL: #{file.public_url}"
puts "Streaming URL: #{file.streaming_url}"
puts "iOS URL: #{file.ios_url}"


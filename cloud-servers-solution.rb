# Cloud Servers Solution
# 
# Create a server using bootstrap and execute `uname -a` on the remote server 
#
# The demo console logs can be found here:
#
# Hint: http://developer.rackspace.com/#ruby
# 

require 'rubygems'
require 'fog'

# create connection to Next Gen Server
service = Fog::Compute.new :provider => 'rackspace', :version => :v2 #, :rackspace_username => USER_NAME, :rackspace_api_key => API_KEY

# first Ubuntu image
image = service.images.find {|img| img.name =~ /Ubuntu/}

# first flavor
flavor = service.flavors.first

put "Now Creating Server..."

# Bootstrap server
server = service.servers.bootstrap :name => 'bootstrap-server',
  :flavor_id => flavor.id,
  :image_id => image.id,
  :public_key_path => '~/.ssh/fog_rsa.pub',
  :private_key_path => '~/.ssh/fog_rsa'

puts "success!\n\n"

# call uname
results = server.ssh("uname -a")

puts "===[uname -a result]============="
puts "\t#{results.first.stdout}"
  
puts "\n\n\t ***Do not forget to delete #{server.name}!"


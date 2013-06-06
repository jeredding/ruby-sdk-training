# Cloud Servers Demo

# I will be using Ruby 1.8.7 (default on mac) 
# On the command line execute the following to install fog. (Default mac ruby will require sudo)
# prompt>> install the fog gem

# require rubygems library if using 1.8.7
require 'rubygems'

# require the fog library
require 'fog'

# create connection to Next Gen Server
service = Fog::Compute.new :provider => 'rackspace', :version => :v2, :rackspace_username => USER_NAME, :rackspace_api_key => API_KEY

# list images
images = service.images

# get first Ubuntu image
image = images.find {|img| img.name =~ /Ubuntu/}

# in a similar manner we are just going to pick the first flavor
flavor = service.flavors.first

# Let's create a server
server = service.servers.create(:image_id => image.id, :flavor_id => flavor.id, :name => 'fog-training')

# let's look at the server attributes
server.attributes

# notice how not all of the attributes are populated after server creation to get the latest details do a reload
server.reload

# fog does some meta-magic to generate accessors/mutators
server.state

server.progress

# let's reload to get the latest progress
server.reload

# Let's check the status again
server.state
server.progress

# We can't do anything until it is in a ready state. Fog provides a convenience method for this
server.ready?

# lets reload
server.reload
server.ready?

# this is a common pattern with compute services. Fog provides another convenience method for that too
server.wait_for { puts "progress>> #{progress}%"; ready? }

# wait for is going to reload the server every second and run our block. After 10 minutes it will throw a Errors::TimeoutError exception

# Once our server is in a ready state we should be able to perform actions on it. See http://rubydoc.info/gems/fog/Fog/Compute/RackspaceV2/Server
# Note: Next Gen Servers have name space Fog::Compute::RackspaceV2 and First Gen Servers have namespace Fog::Compute::Rackspace


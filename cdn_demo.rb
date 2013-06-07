# require rubygems library if using 1.8.7
require 'rubygems'

require 'fog'

# we are going to create a connection to the CDN service
service = Fog::CDN.new :provider => 'rackspace',  :rackspace_username => USER_NAME, :rackspace_api_key => API_KEY

# notice that CDN does not have any collections
service.collections

# but it does have requests
service.requests

# lets get a list of containers in the cdn
r1 = service.get_containers

# This returns an Excon::Response (fog uses the Excon HTTP library)

# To see the HTTP response code
r1.status

# To see the body of the request
r1.body

# notice that the body has been JSON decoded. To see the first CDN entry:
r1.body.first

# Let's look at the CDN information for our sdk-exercise container
r2 = service.head_container "sdk-exercise"

# The body is empty in this call
r2.body

# Everything is stored as a header
r2.header

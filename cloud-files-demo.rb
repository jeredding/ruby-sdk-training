# Cloud Files Demo

# I will be using Ruby 1.8.7 (default on mac) 
# On the command line execute the following to install fog. (Default mac ruby will require sudo)
# prompt>> install the fog gem

# require rubygems library if using 1.8.7
require 'rubygems'

# require the fog library
require 'fog'

# create connection to Next Gen Server
service = Fog::Storage.new :provider => 'rackspace', :rackspace_username => USER_NAME, :rackspace_api_key => API_KEY, :rackspace_region => :ord

# How would you list all of your containers?
service.directories

# How would you create a container?
dir = service.directories.create :key => 'sdk-training'

# Let's check our work
service.directories

# upload a file
file_object = dir.files.create :key => 'fog.png', :body => File.read 'fog.png'

# Let's download it
File.open('download1.png', 'w') {|f| f.write(file_object.body) }

# the method above loads the whole object into memory and then writes it out. Not the best for large files!
# For large files you should try this
File.open('download2.jpg', 'w') do | f |
  dir.files.get("fog.png") do | data, remaining, content_length |
    f.write data
  end
end

# so how would we publish fog.png to the CDN?
dir.public = true
dir.save

# What's the url for our file?
file_object.public_url
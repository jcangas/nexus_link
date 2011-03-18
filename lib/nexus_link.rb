
require 'nexus_link/models'
require 'nexus_link/nax'
require 'version_info'

module NexusLink
  include VersionInfo
  VERSION.file_name = 'version_info.yml'  
end

module Nexus
  module Models
    class Articulo < ActiveRecord::Base
      self.table_name = "ARTICULO"
      self.primary_key = "CODART"
    end
  end
end
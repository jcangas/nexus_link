module NexusLink
  module Models
    class Cliente < ActiveRecord::Base
      self.table_name = "CLIENTES"
      self.primary_key = "CODCLI"
    end
  end
end
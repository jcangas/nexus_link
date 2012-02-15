module NexusLink
  module Models
    class PedidoVenta < ActiveRecord::Base
      self.table_name = "CABEALBV" #"CABEPEDV"
      self.primary_key = "IDALBV"
      has_many :lineas, :class_name => 'LineaPedidoVenta', :foreign_key => 'IDALBV', :autosave => true
  
      def create
        @nax_obj = NAX::PedidoVenta.create(self.attributes)
        self.lineas.each {|l| nax_save_line(l) }
        @nax_obj.save
        @nax_obj = nil
      end
      
      def nax_save_line(line)
        @nax_obj.add_line(line.attributes)        
      end
    end
  end
end

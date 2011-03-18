module  Nexus
  module Models
    class LineaPedidoVenta < ActiveRecord::Base
      self.table_name = "LINEALBA"
      self.primary_key = "IDLIN"
      belongs_to :documento, :class_name => PedidoVenta, :foreign_key => 'IDALBV', :autosave => true

      def create
        self.documento.nax_save_line(self)
      end
    end
  end
end

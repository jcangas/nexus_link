
include WIN32OLE::VARIANT

module Nexus
  module NAX
  
    def self.check
      @enlace.check
    end
    
    def self.enlace
      @enlace ||= open
    end

    def self.enlace=(value)
      @enlace = value
    end
    
    def self.open?
      @enlace
    end

    def self.closed?
      !open?
    end
    
    def self.open
      return if open?
      @enlace = create_enlace
    end
    
    def self.close
      return if closed?
      nax = enlace
      enlace = nil
      nax.close
    end
    
    def self.establish_connection(conn)
      @conn = conn.dup
      @conn['nax_empresa'] ||= @conn['database']
      self
    end
    
    def self.create_enlace
      nax_enl = Nexus::NAX::Enlace.new
      nax_enl.RaiseOnException = false
      nax_enl.LoginUsuario(@conn['username'], @conn['password'])
      nax_enl.Iniciar(@conn['nax_empresa'])
      nax_enl.check
      nax_enl
    end

    class Enlace < WIN32OLE
      def initialize
        @progid = "NAX.Enlace"
        super @progid
      end
            
      def check
        raise self.sMensaje	if self.bError
      end
      
      def close
        self.Acabar
      end
    end
    
    class PedidoVenta < WIN32OLE
      attr_accessor :attributes
    
      def self.circuit
        @circuit
      end
      
      def self.circuit=(value)
        @circuit = value
      end
      
      self.circuit = :venta
          
      def self.create(attrs)
        attrs.reject! { |k, v| v.nil? }
        NAX.open
        fecha = attrs['FCHA'] || Time.now.strftime('%d/%m/%Y')
        codcli = attrs['CODCLI']
        result = NAX::PedidoVenta.new
        result.attributes = attrs.clone
        result.Iniciar
        NAX.check
        result.Nuevo(fecha, codcli , self.circuit == :compra)
        NAX.check
        attrs['IDALBV'] = result.AsStringCab['IDALBV']
        result.refresh_attrs(attrs)
        result
      end
      
      def save
        attributes.each do |key, val| 
          old_val = self.AsStringCab[key.to_s]
          unless  val == old_val
            val = '' if val.nil?
            self.AsStringCab[key.to_s] = val
          end
        end
        self.Anade
        self.Acabar
        NAX.check
        refresh_attrs
        self
      end
  
      def refresh_attrs(delta={})
        attributes.keys.each { |key| attributes[key] = self.AsStringCab[key.to_s]   }
        attributes.merge! delta
      end
  
      def add_line(line)
        self.NuevaLinea
        NAX.check
        save_line(line)
      end
  
      def update_line(rec_id, delta)
        self.EditarLinea(rec_id)
        NAX.check
        save_line(delta)
      end

      def save_line(attrs)
        attrs.each{|key, val|
          val = val.to_f if val.is_a? BigDecimal
          self.AsStringLin[key.to_s] = val if val
        }
        self.AnadirLinea;
        NAX.check
      end
      
      def initialize
        @progid = "NAX.Albaran"
        super @progid
        @attributes = {}
      end
      
      def AsStringCab
        OLEProperty.new(self, 15, [VT_BSTR], [VT_BSTR, VT_BSTR])
      end
      
      def AsStringLin
        OLEProperty.new(self, 19, [VT_BSTR], [VT_BSTR, VT_BSTR])
      end
    end
  end
end
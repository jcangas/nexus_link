require 'win32ole'
require 'win32ole/property'
require 'nexus_link/nax/enlace'
require 'nexus_link/nax/pedido_venta'

include WIN32OLE::VARIANT

module NexusLink
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
  end
end
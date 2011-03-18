module NexusLink
  module NAX
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
  end
end

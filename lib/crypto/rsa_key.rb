module Crypto
  #
  # Clase para crear llaves privadas, en formato X509 no PKCS7
  #
  # Para convertirlos vía linea de comandos:
  #     openssl pkcs8 -inform DER -in nombreGiganteDelSAT.key -passin pass:miFIELCreo >> certX509.pem
  #
  class RSAKey < OpenSSL::PKey::RSA
    # path de la llave
    attr_reader :path

    # path de la llave .pem.enc
    attr_reader :enc_path

    # contraseña de la llave
    attr_reader :password

    # información de la llave en formato .pem
    attr_reader :pem

    # información de la llave en formato .pem.enc
    attr_reader :enc_pem
    attr_reader :data

    #
    # Crea una llave privada
    #
    # @param file [IO, String] El 'path' de esta llave o los bytes de la misma
    # @param password [String, nil] El password de esta llave
    #
    # @return [Security::RSAKey] La llave privada
    #
    def initialize(file, password = nil)
      @password = password
      if File.file?(file)
        @path = file
        @enc_path = @path + '.enc'
        file = File.read(@path)
      end
      super file, password
      @data = to_s.gsub(/^-.+/, '').delete("\n")
    end

    #
    # Sella una cadena de texto
    #
    # @param original_chain [String] La cadena a firmar
    #
    # @return La cadena firmada
    #
    def seal(text)
      Base64.encode64(sign(OpenSSL::Digest::SHA256.new, text)).delete("\n")
    end

    # Encripta el pem generado, requerido para cancelar facturas
    def encrypt_pem(encrypt_password)
      cipher = OpenSSL::Cipher::Cipher.new('des3')
      return to_pem(cipher, encrypt_password)
    end
  end
end

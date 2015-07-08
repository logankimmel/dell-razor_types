module PuppetX::Puppetlabs::Transport
  class Razor
    attr_reader :name

    def initialize(opts)
      @name = opts[:name]
      options  = opts[:options] || {}
      @options = options.inject({}){|h, (k, v)| h[k.to_sym] = v; h}
      @options[:host]     = opts[:server]
      @options[:user]     = opts[:username]
      @options[:password] = opts[:password]
      @options[:scheme] ||= 'http'
    end

    def connect
      if @options[:client_cert]
        cert = OpenSSL::X509::Certificate.new(File.read(@options[:client_cert]))
        key = OpenSSL::PKey::RSA.new(File.read(@options[:client_cert]))
        RestClient::Resource.new("https://#{@options[:host]}/api",
                                 :ssl_client_cert => cert,
                                 :ssl_client_key => key,
                                 :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
      else
        RestClient::Resource.new("#{@options[:scheme]}://#{@options[:host]}/api",
                                 :user => @options[:user],
                                 :password => @options[:password],
                                 :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
      end
    end

    def config
      @options
    end

  end
end
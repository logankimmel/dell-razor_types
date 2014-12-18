begin
  require 'puppet/provider/razor'
rescue LoadError
  require_relative '../razor'
end

Puppet::Type.type(:rz_tag).provide(
  :rest,
  :parent => Puppet::Provider::Razor
  ) do
    
    def exists?
      get('tags', resource[:name])
    end

    def create
      args = {
        :name => resource[:name],
        :rule => resource[:rule]
      }
      post('create-tag', args)
    end

    def destroy
      args = { 'name' => resource[:name] }
      post('delete-tag', args)
    end
  end
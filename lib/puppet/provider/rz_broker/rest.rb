begin
  require 'puppet/provider/razor'
rescue LoadError
  require_relative '../razor'
end

Puppet::Type.type(:rz_broker).provide(
  :rest,
  :parent => Puppet::Provider::Razor
) do

  def exists?
    get('brokers', resource[:name])
  end

  def create
    args = {
      'name'          => resource[:name],
      'configuration' => resource[:configuration],
      'broker-type'   => resource[:broker_type]
    }

    post('create-broker', args)
  end

  def destroy
    args = {
      'name' => resource[:name],
    }

    post('delete-broker', args)
  end
end

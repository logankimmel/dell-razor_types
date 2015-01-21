begin
  require 'puppet/provider/razor'
rescue LoadError
  require_relative '../razor'
end

Puppet::Type.type(:rz_policy).provide(
  :rest,
  :parent => Puppet::Provider::Razor
) do

  def exists?
    @policy = get('policies', resource[:name])
  end

  def create
    args = {
      'name'          => resource[:name],
      'hostname'      => resource[:hostname],
      'root_password' => resource[:root_password],
      'max_count'     => resource[:max_count],
      'tags'          => resource[:tags],
      'repo'          => resource[:repo],
      'broker'        => resource[:broker],
      'enabled'       => resource[:enabled],
      'node-metadata' => resource[:node_metadata]
    }
    #May be desired to override task.
    if resource[:task]
      args['task'] = resource[:task]
    end

    post('create-policy', args)
  end

  def destroy
    nodes = get('policies', resource[:name], 'nodes')
    raise(Exception, "Failed to find nodes for #{resource[:name]}") unless nodes

    nodes['items'].each do |item|
      Puppet.debug("Reinstalling node #{item['name']}")
      post('reinstall-node', { 'name' => item['name'] })
    end

    Puppet.debug("Deleting policy #{resource[:name]}")
    post('delete-policy', { 'name' => resource[:name] })
  end

  def enabled
    @policy['enabled'] ? :true : :false
  end

  def enabled=(value)
    args = { 'name' => resource[:name] }
    if value
      post('enable-policy', args)
    else
      post('disable-policy', args)
    end
  end

  def max_count
    @policy['max_count']
  end

  def max_count=(value)
    args = {
      'name'      => resource[:name],
      # razor code is not consistent about - vs _
      'max-count' => resource[:max_count],
    }

    post('modify-policy-max-count', args)
  end

end

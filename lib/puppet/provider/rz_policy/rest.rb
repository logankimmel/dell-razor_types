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
      'rule_number'   => resource[:rule_number],
      'tags'          => resource[:tags],
      'enabled'       => resource[:enabled]
    }
    [:repo, :task, :broker].each do |attr|
      if resource[attr]
        args.merge!({attr.to_s => {'name' => resource[attr] }})
      end
    end

    post('create-policy', args)
  end

  def destroy
    args = { 'name' => resource[:name] }

    post('delete-policy', args)
  end

  def enabled
    @policy['enabled'] ? :true : :false
  end

  def enabled=(value)
    args = { 'name' => resource[:name] }
    if value == :true
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

  def tags
    #get('policies', resource[:name])['tags'].map{|x| x['name'] }
    # This property does not update it always thinks it is in sync.
    # I would have made it a parameters, but for some reason array_matching=>all
    # does not work for parameters
    resource[:tags]
  end

  def tags=(tags)
    raise(Exception, "Tags do not support updates")
  end

end

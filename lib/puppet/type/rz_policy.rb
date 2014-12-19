Puppet::Type.newtype(:rz_policy) do

  @doc = <<-EOT
    Manages razor policy.
  EOT

  ensurable

  newparam(:name) do
    desc 'razor policy name'
  end

  newproperty(:enabled) do
    desc 'is the policy enabled'
    newvalues(:true, :false)
    defaultto(true)
    munge do |value|
      #This is required so value is a boolean, not just a string. Needed for api
      value.to_s =='true'
    end
  end

  newparam(:repo) do
    desc 'name of repo to use'
  end

  newparam(:installer) do
    desc 'installer to use'
    munge do |value|
      Puppet.warning 'rz_policy installer parameter deprecated, use task'
      resource[:task] = value
    end
  end

  newparam(:task) do
    desc 'task to use'
  end

  newparam(:broker) do
    desc 'name of broker'
  end

  newparam(:hostname) do

  end

  newparam(:root_password) do
    desc 'root password'
  end

  newproperty(:max_count) do
    desc 'max count for policy'
    munge do |x|
      Integer(x)
    end
  end

  newparam(:rule_number) do
    munge do |x|
      Integer(x)
    end
  end

  newparam(:tags) do
    #Puppet will convert a single element array to a string, have to munge into an array.
    munge do |x|
      !x.is_a?(Array) ? [x] : x
    end
  end

  newparam(:node_metadata) do
    desc 'The node metadata associated with this policy'
    munge do |x|
      x.nil? ? {} : x
    end
  end

  autorequire(:rz_repo) do
    self[:repo]
  end

  autorequire(:rz_broker) do
    self[:broker]
  end
end

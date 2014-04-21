Puppet::Type.newtype(:rz_broker) do
  @doc = <<-EOT
    Manages razor brokers.
  EOT

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the broker.'
    newvalues(/\w+/)
  end

  newparam(:broker_type) do
    desc 'The type of broker.'
    newvalues(/\w+/)
  end

  newparam(:configuration) do
    desc 'Configuration for broker'
  end
end

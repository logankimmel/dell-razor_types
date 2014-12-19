Puppet::Type.newtype(:rz_tag) do

  @doc = <<-EOT
    Manages razor tag.
  EOT

  ensurable

  newparam(:name) do
    desc 'razor tag name'
  end

  newparam(:rule) do
    desc 'the rule the tag uses to match'
  end
end
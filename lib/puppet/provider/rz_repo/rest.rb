begin
  require 'puppet/provider/razor'
rescue LoadError
  require_relative '../razor'
end

Puppet::Type.type(:rz_repo).provide(
  :rest,
  :parent => Puppet::Provider::Razor
) do

  def exists?
    get('repos', resource[:name])
  end

  def create
    args = {
      'name'          => resource[:name],
      'iso-url'       => resource[:iso_url],
    }

    post('create-repo', args)
  end

  def destroy
    args = { 'name' => resource[:name] }

    post('delete-repo', args)
  end
end

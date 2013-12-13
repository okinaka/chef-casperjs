version="1.1-beta3"
src_filename = "casperjs-#{version}"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}.tar.gz"
install_path = "/usr/local/casperjs"

package "python"

remote_file src_filepath do
  source "https://github.com/n1k0/casperjs/archive/#{version}.tar.gz"
  action :create_if_missing
end

bash 'extract' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    tar xzf #{src_filepath}
    dname=`tar tzf #{src_filepath} | head -1`
    mv $dname #{install_path}
  EOH
end

version="1.1-beta3"
src_filename = "casperjs-#{version}"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}.tar.gz"
extract_path = "/usr/local/casperjs"
install_path = "/usr/local/bin"

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
    mv $dname #{extract_path}
  EOH
  not_if { ::File.exists?(extract_path) }
end

link "#{install_path}/casperjs" do
  to "#{extract_path}/bin/casperjs"
end

## Initial recipe to set up workstation
#
#

execute "update-upgrade" do
  command "apt-get update && apt-get upgrade -y"
  action :run
end

package %w(vim git tmux firefox terminator)

%w[ /home/gfechio/Git /home/gfechio/GitHub /home/gfechio/Go ].each do |path|
directory path do
  owner 'gfechio'
  recursive true
  action :create
  mode '0755'
end


# Install repo dependencies
package %w( git automake autoconf libssl-dev libexpat1-dev libncursesw5-dev libglib2.0-dev libnotify-dev libcurl3-dev libxss-dev libotr2-dev libtool libexpat1-dev)

# Install libstrophe
directory '~/.local/src/libmesode' do
  recursive true
  action :create
  mode 0775
end

git '~/.local/src/libmesode'  do
  repository 'https://github.com/boothj5/libmesode.git'
  revision 'master'
  action :sync
end

directory '~/.local/src/libmesode/m4' do
  recursive true
  action :create
  mode 0775
end

execute "boostrap_libmesode" do
  command "~/.local/src/libmesode/bootstrap.sh"
end

execute "configure_libmesode" do
  command "~/.local/src/libmesode/configure && ~/.local/src/libmesode/make && sudo ~/.local/src/libmesode/make install"
end

# install profanity

version="0.5.1"

package 'profanity' do
  action :install
  version = #{version}
end

directory '~/.local/src/profanity' do
  recursive true
  action :create
  mode 0775
  not_if "dpkg-query -W profanity"
end

git '~/.local/src/profanity'  do
  repository 'https://github.com/boothj5/profanity.git'
  revision 'master'
  action :sync
  not_if "dpkg-query -W profanity"
end

directory '~/.local/src/profanity/m4' do
  recursive true
  action :create
  mode 0775
  not_if "dpkg-query -W profanity"
end

execute "get_version" do
  command "cd ~/.local/src/profanity/ ; git checkout #{version}"
  not_if "dpkg-query -W profanity"
end

execute "boostrap_profanity" do
  command "~/.local/src/profanity/bootstrap.sh"
  not_if "dpkg-query -W profanity"
end

execute "configure_profanity" do
  command "~/.local/src/profanity/configure && ~/.local/src/profanity/make && sudo ~/.local/src/profanity/make install"
  not_if "dpkg-query -W profanity"
end

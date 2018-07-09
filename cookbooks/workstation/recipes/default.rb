## Initial recipe to set up workstation
#
#

execute "update-upgrade" do
  command "apt-get update && apt-get upgrade -y"
  action :run
end

package %w(vim git tmux terminator xclip python3 virtualenv golang tree pidgin)

%w[ /home/gfechio/Git /home/gfechio/GitHub /home/gfechio/Go ].each do |path|
  directory path do
    owner 'gfechio'
    recursive true
    action :create
    mode '0755'
  end
end

execute 'set_caps_lock_to_ctrl' do
  command 'setxkbmap -option caps:ctrl_modifier'
end

#Dotfiles Config (TMUX ALIAS VIM ZSH BASH)
git '/home/gfechio/GitHub/gfechio'  do
  repository 'https://github.com/gfechio/dotfiles.git'
  revision 'master'
  action :sync
end

#execute 'move_dotfiles' do
#  command 'cp -r /home/gfechio/GitHub/gfechio/dotfiles/.* /home/gfechio/'
#end

cookbook_file '/home/gfechio/.config/gtk-3.0/gtk.css' do
  source 'gtk.css'
  mode '0755'
  owner 'gfechio'
  group 'gfechio'
end

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
git '~/GitHub/gfechio'  do
  repository 'https://github.com/gfechio/dotfiles.git'
  revision 'master'
  action :sync
end

execute 'move_dotfiles' do
  command 'cp -r ~/GitHub/gfechio/dotfiles/.* ~'
end


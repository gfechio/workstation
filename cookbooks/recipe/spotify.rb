package dirmngr

execute 'init_deb_repo' do 
  command ' sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410'
end

execute 'add_deb_repo' do
  command 'echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list'
end

execute 'apt_update' do
  command 'sudo apt update'
end

#Download libssl1.0.0 package from https://packages.debian.org/jessie/libssl1.0.0 - as of the time of this writing Spotify has not been ported to newer versions of libssl so you will need to use the one available for Jessie.
#Install the downloaded package (for example libssl1.0.0_1.0.2d-1_amd64.deb)

execute 'install libssl' do
  command 'sudo apt install ./libssl1.0.0_1.0.2d-1_amd64.deb' 
end

# Finally install Spotify

package spotify-client

pr() {
  echo -e "\n Running $1 \n"
}

pi() {
  echo -e "\n Installing $1 \n"
}

pd(){
  echo -e "\n Downloading $1 \n"
}

maintainPackage(){
  pr 'apt update'
  apt update

  pr 'apt dist-upgrade'
  apt dist-upgrade -y

  pr 'apt autoremove'
  apt autoremove -y
}

maintainPackage

echo -e "\n Installing essential packages\n"

echo -e "\n Installing software-properties-common \n"
apt install software-properties-common --assume-yes

echo -e "\n Installing jq for json formatting \n"
apt install jq --assume-yes

echo -e "\n Installing  geary curl \n"
apt install geary curl git --assume-yes

echo -e "\n Installing golang \n"
apt install golang-go --assume-yes

echo -e "\n Installing nextcloud \n"
add-apt-repository ppa:nextcloud-devs/client -y
apt install nextcloud-client -y

echo -e "\n Installing timeshift \n"
add-apt-repository -y ppa:teejee2008/ppa -y
apt install timeshift --assume-yes

echo -e "\n Installing transmission \n"
apt install transmission --assume-yes

#echo -e "\n Installing vscode \n"
#wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
#add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
#apt install code

echo -e "\n Installing signal \n"
curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
apt update && apt install signal-desktop -y

echo -e "\n Installing riot \n"
sudo apt install -y wget apt-transport-https
sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ default main" |
                sudo tee /etc/apt/sources.list.d/riot-im.list
apt update
apt install riot-desktop --assume-yes

echo -e "\n Installing firefox beta \n"
add-apt-repository ppa:mozillateam/firefox-next -y
apt-get install firefox --assume-yes

echo -e "\n Installing firefox-trunk \n"
add-apt-repository ppa:ubuntu-mozilla-daily/ppa -y
apt install firefox-trunk -y

echo -e "\n Installing Persepolisdm \n"
add-apt-repository ppa:persepolis/ppa -y
apt update
apt install persepolis -y

echo -e "\n Installing gitG\n"
apt install gitg --assume-yes


pd 'SmartGit Protonmail Ulauncher Hugo'
#wget https://protonmail.com/download/protonmail-bridge_1.2.8-1_amd64.deb

protnmailDebPkg="$(curl https://protonmail.com/download/current_version_linux.json | jq -r '.DebFile')"

wget $protnmailDebPkg

#wget https://www.syntevo.com/downloads/smartgit/smartgit-20_1_4.deb

smartgitBaseUrl="https://www.syntevo.com"
smartgitEndPoint="https://www.syntevo.com/smartgit/download/"
smartgitDownloathPath="$(curl $smartgitEndPoint | grep "Debian Bundle" | cut -d ":" -f 2,3 | grep -Po '(?<=href=")[^"]*'  )"
smartgitDownloadUrl="$smartgitBaseUrl$smartgitDownloathPath"
echo -e $smartgitDownloadUrl
wget $smartgitDownloadUrl


#wget https://github.com/Ulauncher/Ulauncher/releases/download/5.8.0/ulauncher_5.8.0_all.deb
curl -s https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest \
  | grep "browser_download_url.*ulauncher_[^extended].*_all\.deb" \
  | cut -d ":" -f 2,3 \
  | tr -d \" \
  | wget -qi -

curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
  | grep "browser_download_url.*hugo_[^extended].*_Linux-64bit\.deb" \
  | cut -d ":" -f 2,3 \
  | tr -d \" \
  | wget -qi -
  
  
curl -s https://api.github.com/repos/persepolisdm/persepolis/releases/latest \
  | grep "browser_download_url.*persepolis_[^extended].*_all\.deb" \
  | cut -d ":" -f 2,3 \
  | tr -d \" \
  | wget -qi -
 
#wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb 

echo -e "\n Installing deb package \n"
apt install ./*.deb --assume-yes



echo -e "\n Fixing broken package \n"
apt --fix-broken install

echo -e "\n Installing etesync \n"
wget https://github.com/etesync/etesync-dav/releases/download/v0.20.0/linux-etesync-dav
mv linux-etesync-dav etesync
cp -b ./etesync /usr/bin/
chmod a+x /usr/bin/etesync
chmod u+x /usr/bin/etesync



echo -e "\n  Installing 'spotify-tui' && Spotifyd \n"

curl -s https://api.github.com/repos/Rigellute/spotify-tui/releases/latest \
|grep "browser_download_url.*spotify[^extended].*inux\.tar\.gz" \
| cut -d ":" -f 2,3 \
| tr -d \" \
| wget -qi -

tarball="$(find . -name "spotify-tui-linux.tar.gz")"
tar -xzf $tarball

#renameing 'spotify-tui' release package
mv spt spotify

echo -e "\n  downloading 'spotifyd v0.2.24' & 'spotify-tui v0.21.0' release package\n"

#wget https://github.com/Rigellute/spotify-tui/releases/download/v0.21.0/spotify-tui-linux.tar.gz
wget https://github.com/Spotifyd/spotifyd/releases/download/v0.2.24/spotifyd-linux-full.tar.gz

echo -e "\n  unpacking 'spotifyd v0.2.24' & 'spotify-tui v0.21.0' release package\n"
#tar xf spotify-tui-linux.tar.gz
tar xf spotifyd-linux-full.tar.gz

#spotifyd-linux-full.tar.gz

curl -s https://api.github.com/repos/Spotifyd/spotifyd/releases/latest \
| grep "browser_download_url.*spotifyd[^extended].*linux-full\.tar\.gz" \
| cut -d ":" -f 2,3 \
| tr -d \" \
| wget -qi -

tarball="$(find . -name "spotifyd-linux-full.tar.gz")"
tar -xzf $tarball

echo -e "\n  makeing 'spotify-tui'  executable \n"
chmod a+x spotify
chmod u+x spotify

echo -e "\n  makeing 'spotifyd'  executable \n"
chmod a+x spotifyd
chmod u+x spotifyd

echo -e "\n  copying 'spotifyd' & 'spotify-tui' to system\n"
cp -b ./spotifyd /usr/bin/
cp -b ./spotify /usr/bin/

echo -e "\n spotify Gui and player is installed \n"

echo -e "\n Installing vscodeium \n"
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/vscodium.gpg 
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | tee --append /etc/apt/sources.list.d/vscodium.list 

apt update 
apt install codium --assume-yes

echo -e "\n adding git repo \n"
add-apt-repository ppa:git-core/ppa -y


echo -e "\n installing keepassxc \n"

add-apt-repository ppa:phoerious/keepassxc -y
apt install keepassxc --assume-yes


echo -e "\n installing gimp \n"

apt install gimp --assume-yes



echo -e "\n settings flatpak \n"
add-apt-repository ppa:alexlarsson/flatpak -y
apt install flatpak -y
apt install plasma-discover-flatpak-backend -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

echo -e "\n installing eval chrome \n"
flatpak install com.google.Chrome


 echo -e "\n installing tor \n"
 flatpak install com.github.micahflee.torbrowser-launcher -y

# 
# torBaseUrl="https://www.torproject.org"
# torEndPoint="https://www.torproject.org/download/"
# torDownloathPath="$(curl $torEndPoint | grep "Download for Linux" | cut -d ":" -f 2,3 | grep -Po '(?<=href=")[^"]*'  )"
# torDownloadUrl="$torBaseUrl$torDownloathPath"
# 
# echo -e "\n downloading tor  from $torDownloadUrl\n"
# wget -O tor.tar.xz $torDownloadUrl
# 
# tar xf tor.tar.xz
# 
# echo -e "\n renameing tor  unpacked dir \n"
# mv tor-browser_en-US tor
# 
# appDir=/home/$USER/.Apps/tor
# echo -e "\n moving tor to  unpacked dir  $appDir\n"
# mv tor $appDir
# 
# echo -e '\n Downloading linphone AppImage Please install it manually'
# wget curl https://www.linphone.org/ | grep ".AppImage" | grep -Po '(?<=href=")[^"]*' 
snap install android-studio --classic
snap install android-studio-canary --classic
snap install flutter --classic
snap install chromium --edge



maintainPackage

echo 'all operation completed on \n' $(date)

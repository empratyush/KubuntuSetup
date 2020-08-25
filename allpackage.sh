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
apt install software-properties-common

echo -e "\n Installing jq for json formatting \n"
apt install jq

echo -e "\n Installing  geary curl \n"
apt install geary curl git --assume-yes

echo -e "\n Installing golang \n"
apt install golang-go

echo -e "\n Installing nextcloud \n"
add-apt-repository ppa:nextcloud-devs/client -y
apt install nextcloud-client -y

echo -e "\n Installing timeshift \n"
add-apt-repository -y ppa:teejee2008/ppa -y
apt install timeshift

echo -e "\n Installing vscode \n"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
apt install code

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

echo -e "\n Installing gitG\n"
apt install gitg


pd 'SmartGit Protonmail Ulauncher hugo'
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


echo -e "\n installing tor \n"

torBaseUrl="https://www.torproject.org"
torEndPoint="https://www.torproject.org/download/"
torDownloathPath="$(curl $torEndPoint | grep "Download for Linux" | cut -d ":" -f 2,3 | grep -Po '(?<=href=")[^"]*'  )"
torDownloadUrl="$torBaseUrl$torDownloathPath"

echo -e "\n downloading tor  from $torDownloadUrl\n"
wget -O tor.tar.xz $torDownloadUrl

tar xf tor.tar.xz

echo -e "\n renameing tor  unpacked dir \n"
mv tor-browser_en-US tor

appDir=/home/$USER/.Apps/tor
echo -e "\n moving tor to  unpacked dir  $appDir\n"
mv tor $appDir

maintainPackage

echo 'all operation completed on \n' $(date)
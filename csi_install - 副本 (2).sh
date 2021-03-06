sudo apt-get -y install git-core gcc make
sudo apt-get -y install iw
sudo apt-get -y install fakeroot
sudo apt-get -y install kernel-package build-essential ncurses-dev
sudo apt-get -y install libnl-dev libssl-dev
sudo apt-get -y install linux-headers-$(uname -r)
cd
git clone https://github.com/dhalperi/linux-80211n-csitool.git && git clone https://github.com/dhalperi/linux-80211n-csitool-supplementary.git
CSITOOL_KERNEL_TAG=csitool-$(uname -r | cut -d . -f 1-2)
cd linux-80211n-csitool
git checkout ${CSITOOL_KERNEL_TAG}
UBUNTU_KERNEL_TAG=Ubuntu-lts-3.13.0-117.164_percise1
git remote add ubuntu git://kernel.ubuntu.com/ubuntu/ubuntu-${percise}.git git pull -- no-edit ubuntu ${Ubuntu-lts-3.13.0-117.164_percise}
make -C /lib/modules/3.13.0-117-generic/build M=$(pwd)/drivers/net/wireless/iwlwifi modules
make && make install && make modules_install
sudo make -C /lib/modules/3.13.0-117-generic/build M=$(pwd)/drivers/net/wireless/iwlwifi INSTALL_MOD_DIR=updates modules_install
sudo depmod
cd
for file in /lib/firmware/iwlwifi-5000-*.ucode; do sudo mv $file $file.orig; done
sudo cp linux-80211n-csitool-supplementary/firmware/iwlwifi-5000-2.ucode.sigcomm2010 /lib/firmware/
sudo ln-s iwlwifi-5000-2.ucode.sigcomm2010 /lib/firmware/iwlwifi-5000-2.ucode
sudo ln -s iwlwifi-5000-2.ucode.sigcomm2010 /lib/firmware/iwlwifi-5000-2.ucode
make -C linux-80211n-csitool-supplementary/netlink/
sudo modprobe -r iwlwifi  mac80211
sudo modprobe -r iwldvm iwlwifi  mac80211
sudo modprobe iwlwifi connector_log=0x1

sudo apt-get install python3-dev python3-pip
sudo pip3 --default-timeout=100000  install -i  https://pypi.tuna.tsinghua.edu.cn/simple/  --upgrade tensorflow2.0 numpy matplotlib
sudo pip3 --default-timeout=100000  install -i  https://pypi.tuna.tsinghua.edu.cn/simple/  --upgrade pickle sklearn
# Arch Install
*Tutorial by Santo_101*
*Translation into Markdown by JayVii*
Original Document can be found [on Santo_101's GoogleDrive](https://drive.google.com/file/d/0B2dHoo7ShqE6ZlhOYzZQcy1NWE0/view?usp=sharing)



## Install

### Partitioning
partition the drive suitable for your self and format it likewise
```
cfdisk
```

### Filesystems
```
mkfs.vfat ­F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4
```

### Mounting the Drives
```
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda3 /mnt/home
```

### Enabling Download-Mirror
```
vi /etc/pacman.d/mirrorlist
```

### Installing base-system
```
pacstrap /mnt base base-devel
```

### Generating FStab
```
genfstab -U -p /mnt >> /mnt/etc/fstab
vi /mnt/etc/fstab
```

### Chrooting into target-system and setting locales
```
arch-chroot /mnt
vi /etc/locale.gen
locale.gen
ln -s /etc/share/zoneinfo/[YOUR-TIMEZONE]/[YOUR-TOWN] /etc/localtime
hwclock --systohc --utc
```

### Setting hostname
```
echo [YOUR-HOSTNAME] > /etc/hostname
```

### Generating initcpio
```
mkinitcpio -p linux
vi /etc/mkinitcpio.conf
```

### Choosing the Root-password
Make sure, to choose something secure.
```
passwd
```

### Installing Bootloader, EFI- and Wireless-support
```
pacman -S grub efibootmgr dialog iw wpa_supplicant
```

### Initializing GRUB
```
grub-install --target=x86_64-efi --efi-directory=$esp --bootloader-id=grub --grub-directory=$esp --recheck --debug
grub-mkconfig -o /boot/grub/grub.cfg
```

### Exiting chroot and rebooting
**CTRL** + **D** or `exit`
```
umount /mnt/home /mnt/boot
umount /mnt
reboot
```
make sure to boot into your installed system, not the live-image.


## Post-Install
Login as root with your set password.

### Adding new user
```
useradd -m -g users,wheel -s /bin/bash [YOUR-USERNAME]
passwd [YOUR-USERNAME]
```

### Multilib and nonfree GPU-drivers
Uncomment the *Multilib* line in `/etc/pacman.conf`.
Also, add following ad the end of the file:
```
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
```

### Add user to sudoers
uncomment the *%wheel* line:
```
EDITOR=vi visudo
```

### Install Yaourt for easy AUR-access
```
pacman -Syu
pacman -S yaourt
```

### Install Xorg and GPU-drivers
```
pacman -S xorg-server xorg-server-utils xorg-xinit xorg-twm xorg-xclock xterm mesa xf86-video-mesa
```

**AMD/ATI:**
```
pacman -S xf86-video-ati
```

### Installing XFCE and LightDM
```
pacman -S xfce4 xfce4-goodies lightdm
systemctl enable lightdm
```

### Installing Misc-Packages
```
pacman -S ttf-dejavu opendesktop-fonts pavucontrol pulseaudio-alsa networkmanager network-manager-applet
systemctl enable NetworkManager
```

### Done.
Reboot and login with your previously set user-credentials.
```
reboot
```

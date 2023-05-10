parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MB 2GB
parted /dev/sda -- mkpart primary 2GB -8GB
parted /dev/sda -- mkpart primary linux-swap -8GB 100%
parted /dev/sda -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2
mkswap -L swap /dev/sda3
swapon /dev/sda3
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

nixos-generate-config --root /mnt
cp configuration.nix /mnt/etc/nixos
nixos-install --no-root-passwd

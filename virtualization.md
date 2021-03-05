[KVM-QEMU](#kvm-qemu)

### KVM-QEMU
```bash
# http://www.howtogeek.com/117635/how-to-install-kvm-and-create-virtual-machines-on-ubuntu/
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager
sudo adduser $USER libvirtd # only people in libvirtd can use kvm
virsh -c qemu:///system list
virsh list --all
virt-manager --connect qemu:///session
# find ip of guests
virsh domiflist <guest>

qemu-img create -f qcow2 virtual.hd 8G
qemu-img convert -o compat=0.10 -f vmdk -O qcow2 -c -p TurnKeyMySQL20120413-disk1.vmdk TurnKeyMySQL20120413-disk1.qcow2
qemu-system-i386 -m 2048 -cdrom ./Documents/ISO/vista32bit.iso -boot d -monitor stdio [-no-acpi] temp/virtual.hd

# remote connection
spicec --host 127.0.0.1 --port 5901
remote-viewer spice://127.0.0.1:5901

# clone & backup $(date +%Y-%M-%d_%H:%M)
cp --sparse=always IN.img OUT.img # only for raw files
tar cfS xnat-1.6.4-server-disk1.img.tar xnat-1.6.4-server-disk1.img

rsync --sparse # the first time, or use dd if=/dev/zero of=file.img bs=1 count=0 seek="$(bitesize of original file)"
rsync --inplace # to update
#qemu-img convert -f raw -O raw -S xxx /home/store/xnat_rete_ad/xnat-1.6.4-server-disk1.img 

# http://www.dedoimedo.com/computers/kvm-clone.html
kpartx -av /kvm/disk.raw
```

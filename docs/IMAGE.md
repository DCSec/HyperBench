# HyperBench Image

创建os.img
```
dd if=/dev/zero of=./os.img bs=1M count=100
```

使用fdisk在os.img上创建分区表，然后对他进行分区
```
fdisk os.img
hexdump os.img
```

使用循环设备挂载os.img挂载
```
losetup /dev/loop0 os.img
mount /dev/mapper/loop0p1 /root/os
df -hT
```

激活分区
```
kpartx -av /dev/loop0
ll /dev/mapper/loop*
```

格式化
```
mkfs -t xfs /dev/mapper/loop0p1
```

安装grub
```
grub2-install --root-directory=/root/os /dev/loop0
```

安装grub.cfg文件
```
grub-mkconfig -o /boot/grub/grub.cfg
```


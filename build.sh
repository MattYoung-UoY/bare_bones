shopt -s expand_aliases
alias i686='~/programming/osdev/osdevwiki/xcompiler/bin/i686-elf-gcc'

i686 -std=gnu99 -ffreestanding -g -c start.s -o start.o
i686 -std=gnu99 -ffreestanding -g -c kernel.c -o kernel.o
i686 -ffreestanding -nostdlib -g -T linker.ld start.o kernel.o -o kernel.elf -lgcc

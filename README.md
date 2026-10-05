# AnchorOS

Well this is an os from scratch that I build to help me learn and understand about os. 

I call it anchor because it feels like it stablize me in the wavy sea, this eventually should be something that back me up, anchor me in the chaos sea , even when it can look very bare bone, very primitive, even when visible stuff looks almost not existing , and lots of invisible work needs to be done before even a not-really-direct visible things can exist

## Foundation pillars

This os follows: 3 pillar from the book "Operating Systems: Three Easy Pieces"

- **Virtualization**: each program thinks it has the whole machine to itself

- **Concurrency**: many things happen at once without breaking each other

- **Persistence**: data survives after switching the power button off 

Other than that, there is "sub pillar" or pillar in the middle pillar that I kinda make it to help me understand more, or it simply does not fit anywhere else 

## Supporting pillars

- **Foundation:** getting code built and running on bare metal at all (cross-compiler, boot, the C library)

- **Protection:** the walls between programs, and between programs and the kernel, so one buggy program can't wreck everything

- **Devices:** talking to specific pieces of hardware (keyboard, screen, timer, disk); the code for each one is called a driver

- **Tooling:** things the user never sees, built so *I* can see inside the OS and debug it



## System diagram

Okay so our system diagram so far gonna look something like this : 

```text
          ---syscall--->              --I/O ports, MMIO-->
User space <-------------- Kernel space <-------------------- Hardware
          <---result----              <----interrupts-----
```

## Phases 

### Phase 1: the kernel foundation
| Component | Description | Pillar | How it manifests |
|---|---|---|---|
| Cross-compiler | Builds code for bare metal, not for my host* | Foundation | Inspect the output binary on  host |
| Boot (Multiboot + GRUB) | Gets code running after firmware | Foundation | Text on screen |
| `printf` to screen | microscope for everything after | Tooling, Devices | Itself |
| GDT | Sets up memory segments and privilege levels | Protection | QEMU register dump |
| Interrupts (IDT, timer) | Reacts to hardware events and CPU errors | Concurrency, Devices | Tick counter, divide-by-zero message |
| Keyboard | Input | Devices | Echo what is typed out |
| Physical memory manager | Tracks which RAM is free | Virtualization | Print the memory map |
| Paging | Gives virtual addresses, walls off memory | Virtualization, Protection | QEMU page table view, a deliberate page fault |
| Kernel heap | `kmalloc` / `kfree` | Virtualization | Allocation stress test |
| Threads + scheduler | Many tasks sharing one CPU | Virtualization, Concurrency | Two tasks printing A and B alternately |
| Locks | Stop two tasks from corrupting shared data | Concurrency | A race shown without the lock, fixed with it |
| Kernel debugger | Magic key that freezes and inspects the kernel | Tooling | Press the key, see the task list |
| Ramdisk filesystem | Files loaded into memory at boot | Persistence | `ls` on files I packed in |

item with "*" will be documented in more detail

Note: the ramdisk is persistence's *interface* without real persistence (it vanishes on reboot). Real persistence arrives with the disk driver in Phase III.

### Phase 2: the user space 

| Component | Description | Pillar | How it manifests |
|---|---|---|---|
| User mode | Programs run with limited power | Protection | A program touching kernel memory gets killed |
| Program loading (ELF) | Puts a program in memory and runs it | Virtualization | Compare with `readelf` on my host |
| System calls | The doors from programs into the kernel | Protection | Log every syscall |
| Small C library | `printf`, `malloc` for programs | Foundation | Programs written in normal C |
| Fork and exec | Programs creating programs | Virtualization | Process list |
| Shell | I choose what runs, while it runs | Everything together | Typing commands |

### Phase 3: extending phase in any order 
- Time and clocks (Devices)
- Multiple CPU cores, SMP (Concurrency)
- Disk driver (Devices, Persistence)
- Real filesystem like FAT (Persistence)
- Graphics / framebuffer (Devices)
- Virtual consoles, text editor (user space, everything together)
- Networking, sound, USB (Devices)

### Phase IV: self-hosting - end game ish 
Compiling AnchorOS while running AnchorOS.

# Progress thread

Setting up the proj

Consider build gdb for our new os

Building gcc, check if there is any problem! 

If no, then continue after Build GCC, either build gdb or Using the new Compiler

https://wiki.osdev.org/GCC_Cross-Compiler


# Setting everything up

link: https://wiki.osdev.org/GCC_Cross-Compiler

Well because I am using fedora, so for ease of use in the future, I will just list all here:

## Host side 
sudo dnf install gcc gcc-c++ make bison flex gmp-devel libmpc-devel mpfr-devel texinfo isl-devel


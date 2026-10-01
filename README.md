# AnchorOS

Well this is an os from scratch that I build to help me learn and understand about os. 

I call it anchor because it feels like it stablize me in the wavy sea, this eventually should be something that back me up, anchor me in the chaos sea , even when it can look very bare bone, very primitive, even when visible stuff looks almost not existing , and lots of invisible work needs to be done before even a not-really-direct visible things can exist

## Foundation pillars

This os follows: 3 pillar from the book "Operating Systems: Three Easy Pieces"

- Virtualization: each program thinks it has the whole machine to itself

- Concurrency: many things happen at once without breaking each other

- Persistence: data survives after switching the power button off 

Other than that, there is "sub pillar" or pillar in the middle pillar that I kinda make it to help me understand more, or it simply does not fit anywhere else 




## System diagram

Okay so our system diagram so far gonna look something like this : 

```text
          ---syscall--->              --I/O ports, MMIO-->
User space <-------------- Kernel space <-------------------- Hardware
          <---result----              <----interrupts-----
```

## Phases 

### Phase 1: the kernel foundation

### Phase 2: the user space 

### Phase 3: extending phase in any order 

### Phase IV: self-hosting - end game ish - compiling  AnchorOS while runing AnchorOS 


# Progress thread

Day one (again?) - or Day Ones. Tomorrow, we would need to divide our phase plan , understand the structure more of an OS 

the current convo so far is like : 

"back then you were saying there is quite some more pillar: like plumbing, protection, concurrency, devices , tooling , that was originally mentioned 

this created a gap in our doc, which is not ideal ! 
"

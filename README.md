# Build-Your-Own-OS — Roadmap & Rulebook

---

## Endgame Goal

A "usable" OS, defined as **all three** true at once:

1. **Boots on real laptop hardware** from USB — not just QEMU
2. **Accepts keyboard input** and does something with it — a shell, even a dumb one
3. **Has persistent storage** — write a file, reboot, read it back

GUI / framebuffer graphics is a stretch goal (Milestone 10), not a requirement. A working text shell on bare metal with a real filesystem underneath is already "I built an OS."

---

## The Rules

### Rule 1 — AI Tiers

| Tier | What it means | Allowed for |
|---|---|---|
| 🟢 Concept questions | Ask freely, then verify against a primary source before it "counts" as known | Comparing FAT12/32/NTFS, explaining what a GDT is, etc. |
| 🟡 Debugging dialogue | Describe symptom + your code. AI asks questions / narrows hypotheses. **You** find and write the fix. AI never pastes a fix. | Any bug in core OS code |
| 🔴 No AI-written code | Forbidden | Anything flagged 🔴 in the milestone table below |
| ⚪ AI-written code OK | Fine to generate directly | Makefiles, linker scripts, QEMU launch flags, `.gitignore`, build plumbing |

### Rule 2 — Reference Material First
Before touching a new component, find the primary source (OSDev wiki page, Intel SDM section, the actual FAT spec, etc.) *before* asking AI to explain it. AI translates/clarifies; it does not originate the knowledge.

### Rule 3 — The Rewrite-From-Memory Check
After a milestone works: close the editor, `git stash` or delete that component, and rewrite it from scratch with no notes open. If it doesn't come back together in roughly "research time minus implementation time" — it wasn't actually learned. Go back before moving on.

### Rule 4 — Verification Log
One line per concept in the log below. Format:
> **Concept** — one-line summary — *verified against [source]*

This is your proof-of-understanding trail.

### Rule 5 — No Skipping Ahead
Milestone N+1 doesn't start until Milestone N passes its Rule 3 check. Slow is allowed. Skipping because a tutorial made it look easy is spoonfeeding in disguise.

---

## Milestones

Each has: the core lesson, sub-steps, AI tier for the *core* logic (scaffolding is always ⚪), and a Rule 3 checkbox.

### Milestone 0 — Bootable Hello World
**Lesson:** boot handoff, freestanding C, linking a kernel GRUB can load.
- [ ] Set up cross-compiler toolchain (`i686-elf-gcc` or similar)
- [ ] Write multiboot2 (or multiboot1) header in assembly
- [ ] Minimal `kernel.S` → `kmain()` in C handoff
- [ ] VGA text-mode `putc` / `puts` / `clear`
- [ ] Boots and prints in QEMU
- [ ] **Rewrite-from-memory check passed**

### Milestone 1 — GDT, IDT, Interrupts
**Lesson:** protection rings, interrupt mechanics. 🔴 core logic.
- [ ] Set up GDT (flat memory model)
- [ ] Set up IDT
- [ ] Handle a CPU exception (e.g. divide-by-zero) and print diagnostic
- [ ] Remap PIC, handle a hardware IRQ (timer tick is a good first one)
- [ ] **Rewrite-from-memory check passed**

### Milestone 2 — Keyboard Input
**Lesson:** polling/IRQ-driven I/O. 🔴 core logic.
- [ ] PS/2 keyboard driver (scancode → ASCII)
- [ ] Echo typed characters to screen
- [ ] Handle backspace / enter sensibly
- [ ] **Rewrite-from-memory check passed**

### Milestone 3 — Physical Memory Manager
**Lesson:** memory as a managed resource. 🔴 core logic.
- [ ] Parse memory map from multiboot info
- [ ] Bitmap or free-list physical allocator
- [ ] `alloc_frame()` / `free_frame()` working and tested
- [ ] **Rewrite-from-memory check passed**

### Milestone 4 — Paging
**Lesson:** virtual memory. 🔴 core logic.
- [ ] Identity-mapped paging enabled
- [ ] Higher-half kernel
- [ ] Page fault handler with useful diagnostics
- [ ] **Rewrite-from-memory check passed**

### Milestone 5 — FAT12 Read Driver
**Lesson:** on-disk filesystem structures. 🔴 core logic, 🟢 heavy use OK for "what does this field mean" against the FAT spec.
- [ ] Read boot sector / BPB
- [ ] Walk the FAT (cluster chains, 12-bit packed entries)
- [ ] Read root directory entries
- [ ] Read a file's contents given its name
- [ ] **Rewrite-from-memory check passed**

### Milestone 6 — Minimal Shell
**Lesson:** tying I/O + memory + filesystem together. 🔴 core logic.
- [ ] Read a line from keyboard into buffer
- [ ] Parse command + args
- [ ] Dispatch to built-ins (`echo`, `ls`, `cat`, etc.)
- [ ] **Rewrite-from-memory check passed**

### Milestone 7 — FAT12 Write Support
**Lesson:** persistence round-trip (or pivot to a simpler custom FS if FAT12 write proves too gnarly — that's a legitimate design decision, not a cop-out, document it either way). 🔴 core logic.
- [ ] Allocate free clusters
- [ ] Write file data + update FAT chain
- [ ] Update directory entry
- [ ] Write a file, reboot, read it back successfully
- [ ] **Rewrite-from-memory check passed**

### Milestone 8 — Real Hardware Boot
**Lesson:** the hardware/emulator gap is real and instructive. ⚪ for `dd`/partitioning scripts, 🔴 for any OS-side fix needed to make it work.
- [ ] `dd` image to USB
- [ ] Boot laptop via BIOS/Legacy boot menu
- [ ] Diagnose and fix whatever QEMU didn't warn you about (there will be something)
- [ ] **Rewrite-from-memory check passed** (for whatever code changed)

### Milestone 9 — UEFI Boot *(stretch)*
**Lesson:** modern boot path, much bigger surface.
- [ ] TBD once you get here — research first

### Milestone 10 — Framebuffer Graphics *(stretch)*
**Lesson:** "a graphic thing to see."
- [ ] TBD once you get here — research first

---

## Verification Log

*(Append entries here as concepts are verified against primary sources.)*

-

---

## Notes / Deviations

*(Use this space to record any deliberate rule-breaks or design pivots, with reasoning — e.g. "skipped writing own bootloader, using GRUB, because the lesson I want is OS internals not boot-sector assembly, documented as a conscious choice not a shortcut.")*

-

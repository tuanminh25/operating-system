Second version of README on 4/10/26, this is something for my future self to re-read and make judgement, the order has been adjusted:

And the voice are from my mentor - Claude Optus 5.5 Medium 

- Reordered Phase I. The wiki lists memory management before interrupts, and the keyboard after multithreading. I moved interrupts earlier because a page fault is an interrupt: if your interrupt handlers exist before paging, a paging bug prints a message instead of silently rebooting the machine. I moved the keyboard earlier just for visible progress.

- Split "Memory Management" into three rows. The wiki covers physical frames, virtual memory and the heap in one entry. Same content, just broken up.

- Added "Locks." Not a separate wiki entry; it's implied by the multithreaded kernel.

- Left out a few wiki items: project structure ("Meaty Skeleton"), global constructors (only matters for C++, so skip it), stack smash protector, the OS-specific toolchain, and thread-local storage. Of those, I'd add Meaty Skeleton back. It's how to organize the repo, which you'll want right after hello world.

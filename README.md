# Gentoo wine-esync

Gentoo ebuild patchset(s), for **app-emulation/wine-staging** and **app-emulation/wine-vanilla**.
wine-esync uses eventfd-based synchronization to improve the performance, and reduce latency,
of both Wine and Wine Staging.

Developed by Zebediah Figura. The idea behind the patchset is to move many synchronization
primitives out of the **wineserver** process, as this single-threaded process is very vulnerable to
becoming a global Wine bottleneck. The aim is to execute all synchronization operations in "user-space",
that is, without going through **wineserver**. This is done using Linux's eventfd
facility. The main impetus to using eventfd is so that we can poll multiple
objects at once; in particular we can't do this with any currently implemented, alternative solutions.
A practical solution to the problem of waiting multiple objects is to use select/poll/epoll to wait on
multiple fds, and eventfd gives us those fds in a quite usable way.

This patchset was inspired by Daniel Santos' "hybrid synchronization"
patchset. Zebediah's idea was build on this initial work.
He created a framework whereby even contended waits could
be executed in userspace, eliminating a lot of the complexity that Daniel's
synchronization primitives used.

## ```eventfd_synchronization/wine-staging/```

Contains wine-esync patchsets, rebased for Wine Staging, separated into directories by Wine Git commits. These rebased wine-esync patchsets are guaranteed to apply to all child Wine Git commits, on which Wine Staging has been rebased. When a subsequent wine-esync rebase snapshot is necessary, then a new patchset directory is created for this (and so on).

## ```eventfd_synchronization/wine-vanilla/```

Contains wine-esync patchsets, rebased for Wine, separated into directories by Wine Git commits. These rebased wine-esync patchsets are guaranteed to apply to all child Wine Git commits. When a subsequent wine-esync rebase snapshot is necessary, then a new patchset directory is created for this (and so on).

## ```wine-esync-common.awk wine-esync-preprocess.awk esync_generate_rebasing_patchsets.sh```

Awk scripts that can be used to rebase the stock 83 wine-esync patches, so that these apply on any version of **>=app-emulation/wine-vanilla-3.0_rc1** or **>=app-emulation/wine-staging-3.3**.
A BASH script that uses the Awk scripts to generate multiple rebased directories. These are separated hierarchically by:

1. intermediate directory: package name
2. leaf directory: Wine Git commit (rebase point for this patchset)

The leaf directories contain patchsets that can be directly applied to all current Wine (≥3.0-rc1) and Wine Staging (≥3.3) releases.

# wine-esync (aka eventfd-synchronization)

Full credit, for developing this patchset, must go to the original author Zebediah Figura [@zfigura](https://github.com/zfigura).
See: [Github: zfigura / wine : README.esync](https://github.com/zfigura/wine/blob/esync/README.esync).
Also see: [Github: daniel-santos / wine](https://github.com/daniel-santos/wine/tree/hybrid-sync).

Thanks also to the Arch Linux packaging work done by: **Etienne Juvigny** [@Tk-Glitch](https://github.com/Tk-Glitch).

Paludis repository w/ my collection of ebuilds and sets.

To add this overlay to your paludis configuration add `zaufi-overlay.conf` w/ appropriate contents to `/etc/paludis/repositories/`.

    master_repository = gentoo
    location = ${ROOT}/var/paludis/repositories/zaufi-overlay
    sync = git://github.com/zaufi/zaufi-overlay.git
    format = e

Note that here some fields are missed cuz I have the following `/etc/paludis/repository_default.conf`:

    names_cache = ${ROOT}/var/cache/paludis/names
    write_cache = ${ROOT}/var/cache/paludis/metadata
    builddir = /storage/tmp/paludis
    distdir = /storage/soft/gentoo/distfiles

So, one have to edit this configs according particular paths in his system.

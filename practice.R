library(tidyverse)
library(archive)

archive_write_files("write_files.tar.gz", 
    c("data/ghcnd_all/ASN00008255.dly",
      "data/ghcnd_all/ASN00017066.dly",
       "data/ghcnd_all/ASN00040510.dly")
)

#Put multiple files from the data/ghcnd_all dir into their own tarball. 
archive_write_dir("write_dir.tar.gz",
                    "data/ghcnd_all")


archive("write_dir.tar.gz")
#Show all files in an archive
archive("data/ghcnd_all.tar.gz")

read_tsv(archive_read("write_dir.tar.gz", "ASN00008255.dly"))
read_tsv(archive_read("write_dir.tar.gz", "ASN00017066.dly"))
read_tsv(archive_read("write_dir.tar.gz", "ASN00040510.dly"))


archive("write_dir.tar.gz") %>%
    pull(path) %>%
    map_dfr(., ~read_tsv(archive_read("write_dir.tar.gz", .x)))

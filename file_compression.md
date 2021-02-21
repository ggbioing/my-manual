[7z](#7z)

[tar](#tar)

[zip](#zip)

### 7z
```bash
7z a bookcopy.pdf.7z bookcopy.pdf
7z d file.x.7z
# folder
tar -c <folder> | 7z a -si <folder>.tar.7z
```

### TAR
```bash
sudo apt-get install lbzip2 pigz pbzip2
export TAR_OPTIONS="--use-compress-program=pbzip2"
tar -cjf --use-compress-program=pbzip2 myfile.tar.bz2 mysubdir/
tar -c fileToCompress | pbzip2 -c > outName.tbz2
# from file list
tar -cvf allfiles.tar --files-from mylist.txt

tar -x -f bfiles.tar --wildcards --no-anchored 'b*' --strip-components=NUMBER -C /target/directory
tar xjvf 02-MRIT1-PT-001-T00-001.long.base_T00-T06_02-MRIT1-PT-001.tar.bz2 --wildcards --no-anchored '*stats/'

pbzip2 -dc 02-MRIT1-PT-001-T00-001.long.base_T00-T06_02-MRIT1-PT-001.tar.bz2 | tar xf - --wildcards --no-anchored '*stats/'
!! i file non compressi con pbzip2 non possono essere decompressi in multithread

pbzip2 -dkc file.tar.bz2 | tar xf - -C EXTRACTION_DIR --wildcards --no-anchored '*stats/' '*mri/orig.mgz'
# compress and send
tar czf - -C /path/to/source files-and-folders | ssh user@target-host "cat - > /path/to/target/backup.tar.gz"
tar -c hubiC | pbzip2 -c | ssh hug "cat - > /home/pandora_user9/test.tar.bz2"

# split files
tar cvzf - dir/ | split -b 200MB - sda1.backup.tar.gz. # -b 4294967295 for FAT32 fs
tar cjf - /cvmfs/neugrid.egi.eu/software/x86_64/leap-2013/ | split -b 4294967295 - ${JobName}.tar.bz2.
tar -c FOTO | pbzip2 -c | split -b 4294967295 - FOTO.tar.bz2.
cat sda1.backup.tar.gz.* | tar xzvf - # to recompose
```

### ZIP
```bash
zip STATS/csv.zip -@ < csvlist
```


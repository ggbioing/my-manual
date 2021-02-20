[adni](#adni) 

[ants](#ants) 

[dicombrowser](#dicombrowser) 

[DTI Prep](#dti-prep)

[Explore DTI](#explore-dti)

### ADNI
adnimerge on R:
```R
install.packages("Hmisc")
install.packages("/path/to/ADNIMERGE_0.0.1.tar.gz", repos = NULL, type = "source")
library("ADNIMERGE")
help(package = "ADNIMERGE")
?adas
```

### ANTs
```bash
git clone git://github.com/stnava/ANTs.git
mkdir antsbin && cd antsbin
sudo apt-get install gcc g++ zlib1g-dev
ccmake ../ANTs
# press c [confiure] t [toggle to advanced and turn off] and g [generate]
make -j 4
```
To run the scripts, you need to copy the `Scripts/*` to `antsbin/bin/`.
Set the `ANTSPATH` to point to the `antsbin/bin/` directory. e.g. in your profile add:
```bash
ANTSPATH=/home/myname/mycode/antsbin/bin/
```

### DicomBrowser
```bash
wget ftp://ftp.nrg.wustl.edu/pub/DicomBrowser/DicomBrowser-1.5.2.tgz
wget https://bitbucket.org/nrg/dicombrowser/downloads/DicomBrowser-1.7.0b5-bin-with-dependencies.jar
# https://wiki.xnat.org/xnat-tools/dicomedit/dicomedit-4-2-language-reference
DicomRemap -d anon.das -o /path/to/dest/ source/
```

### DTI Prep
```bash
DWIConvert --inputVolume 01011-t1w.nrrd --conversionMode NrrdToFSL --outputVolume testout.nii --outputBVectors testout.bvecs --outputBValues testout.bvals
```

### EXPLORE-DTI
```bash
wget www.exploredti.com/ExploreDTI/Linux/64/ExploreDTI_v4.8.6.zip # standalone
wget http://www.exploredti.com/ExploreDTI/Pcode/ExploreDTI_Pcode.zip
export LD_LIBRARY_PATH="/home/luigi/matlab/Source/MD_cor_E/linux64:$LD_LIBRARY_PATH"
sudo ln -s /home/luigi/matlab/ExploreDTI_v4.8.6/Source/MD_cor_E/linux64/libANNlib.so /usr/lib/libANNlib.so
```

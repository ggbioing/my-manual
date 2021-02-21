[adni](#adni) 

[ants](#ants) 

[dicombrowser](#dicombrowser) 

[DTI Prep](#dti-prep)

[Explore DTI](#explore-dti)

[FreeSurfer](#freesurfer)

[FSL](#fsl)

[NeuGrid](#neugrid)

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

### FreeSurfer
[website](https://surfer.nmr.mgh.harvard.edu/)
```bash
# CROSSECTIONAL
recon-all -i file.nii.gz [-i file2.nii.gz] -s subjectname -all -hippo-subfields
#TEMPLATE
recon-all -base ${sub}_template -tp out_${sub}_T00_001 -tp out_${sub}_T06_001 -all
#LONG
recon-all -long out_11_002_VO_T02_MPRAGE_1 11_002_VO_MPRAGE_template -all -hippo-subfields
```


### FSL
```bash
FSLVERSION='fsl-5.0.10'
wget -c http://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
activate python2.x
python fslinstaller.py
wget -c http://fsl.fmrib.ox.ac.uk/fsldownloads/${FSLVERSION}-centos6_64.tar.gz
wget -c http://fsl.fmrib.ox.ac.uk/fsldownloads/md5sums/${FSLVERSION}-centos6_64.tar.gz.md5
./fslinstaller.py -f ${FSLVERSION}-centos6_64.tar.gz -C `cat ${FSLVERSION}-centos6_64.tar.gz.md5` -d /usr/local/
sudo ./fslinstaller.py
sudo python fslinstaller.py -f fsl-5.0.10-centos6_64.tar.gz -C 064abae9083e69fafd114dedd9add465 -T md5 -d /home/luigi/Software/fsl-5.0.10 # the directory must not exists
```
To use FSLView please install the PNG12 and MNG libraries with: `sudo yum install libpng12 libmng`.

### NeuGrid
[website](https://neugrid4you.eu/)
```bash
lcg-info --vo 'VOMS:/vo.neugrid.eu*' --list-ce --attrs OS,OSRelease,TotalCPUs,FreeCPUs,RunningJobs,FreeJobSlots,WaitingJobs
lcg-tags --ce ng-hug-server5.neuro.hcuge.ch --vo vo.neugrid.eu --list
lcg-tags --ce ng-ki-server5.ki.se --vo vo.neugrid.eu --list
lcg-info --vo VOMS:/vo.neugrid.eu\* --list-ce --query 'Tag=*VO-vo.neugrid.eu-freesurfer-5.1.0*'
```

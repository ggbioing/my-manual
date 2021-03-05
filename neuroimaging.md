[adni](#adni) 

[ants](#ants) 

[dicombrowser](#dicombrowser) 

[DTI Prep](#dti-prep)

[Explore DTI](#explore-dti)

[fmri-prep](#fmri-prep)

[FreeSurfer](#freesurfer)

[FSL](#fsl)

[MRIcro](#mricro)

[NeuGrid](#neugrid)

[SPM](#spm)

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

### fmri-prep
```bash
# Install DOCKER
# Follow Instruction on website
# pip install future

# No underscores in subj id
fmriprep-docker --fs-license-file $FREESURFER_HOME/license.txt [--anat-only  --longitudinal --fs-no-reconall --participant_label PARTICIPANT_LABEL '0040043MACL'] --work-dir <full path to WD> <full path to BIDS> <full path to OUT dir>
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

### MRIcro
```bash
wget http://www.mccauslandcenter.sc.edu/mricro/mricro/mricrox.tar.gz
sudo mkdir /usr/local/mricro
sudo tar xzf mricrox.tar.gz -C /usr/local/mricro
apt-get install ia32-libs
cd /usr/local/mricro/mricro && ldd libborqt-6.9-qt2.3.so && install missing libraries
sudo ln -s /usr/lib/i386-linux-gnu/libjpeg.so.8.0.2 /usr/lib/i386-linux-gnu/libjpeg.so.62
```

### NeuGrid
[website](https://neugrid4you.eu/)
```bash
# Available N4U CE nodes:
lcg-info --vo 'VOMS:/vo.neugrid.eu*' --list-ce --attrs OS,OSRelease,TotalCPUs,FreeCPUs,RunningJobs,FreeJobSlots,WaitingJobs
# List the software packages available on the N4U grid:
lcg-info --list-ce --attr Tag --vo 'VOMS:/vo.neugrid.eu*'
# List the software packages available on a specific N4U node:
lcg-info --vo 'VOMS:/vo.neugrid.eu*' --list-ce --query 'CE=*srv5.fatebenefratelli.it*' --attrs Tag | grep -E 'CE:|neugrid'
# List the N4U nodes where a specific software package is available:
lcg-info --vo 'VOMS:/vo.neugrid.eu*' --list-ce --query 'Tag=*VO-vo.neugrid.eu-freesurfer-5.1.0*'
# To check the tags available on a CE:
lcg-tags --ce ng-maat-server9.gnubila.fr --list 
# EXPRESSLANE
export EXPRESSLANE_DEBUG=1 # debug mode
export EXPRESSLANE_VERBOSE=1 # verbose mode
## software on seed resources:
lcg-info --vo 'VO:vo.neugrid.eu' --list-ce --query 'Tag=*VO-vo.neugrid.eu-cmtk-20140723*' --attrs TotalCPUs,FreeCPUs,RunningJobs
# Delete files in folder:
for i in $(lfc-ls $PANDORA_GRID_HOME/adaboost/output); do echo $i; lcg-del -a lfn:$PANDORA_GRID_HOME/adaboost/output/$i & sleep 0.1; done
# PERUSAL:
# To enable the perusal mechanism two parameters need to be added to your .ext file:
PerusalFileEnable=true
PerusalTimeInterval=1000
# Submit your job
# Execute the following command to enable the functionality:
glite-wms-job-perusal --set -f myOutputFile1 -f myOutputFile2 JOB_ID
# Execute the following command to retrieve the output:
glite-wms-job-perusal --get -f myOutputFile1 -f myOutputFile2 --dir MyOutputFolder JOB_ID
# (If the folder does not exist it will be created automatically)
```

```bash
lcg-info --vo 'VOMS:/vo.neugrid.eu*' --list-ce --attrs OS,OSRelease,TotalCPUs,FreeCPUs,RunningJobs,FreeJobSlots,WaitingJobs
lcg-tags --ce ng-hug-server5.neuro.hcuge.ch --vo vo.neugrid.eu --list
lcg-tags --ce ng-ki-server5.ki.se --vo vo.neugrid.eu --list
lcg-info --vo VOMS:/vo.neugrid.eu\* --list-ce --query 'Tag=*VO-vo.neugrid.eu-freesurfer-5.1.0*'
```

### SPM
```bash
wget http://www.fil.ion.ucl.ac.uk/spm/download/restricted/eldorado/spm12.zip
# Standalone
wget http://www.fil.ion.ucl.ac.uk/spm/download/restricted/utopia
```

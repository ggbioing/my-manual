[adni](#adni) 

[ants](#ants) 

[dicombrowser](#dicombrowser) 

[dcmtk](#dicmtk) 

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


### dcmtk

**STORE-SCP**

Light up a STORE-SCP that receives dicom files.
The service will run on localhost an will listen on port 5678
```cmd
storescp +xa 5678
```

**Worklist**
[usage example here](https://groups.google.com/g/comp.protocols.dicom/c/oc5XglBUWG0)

    Hi,
    
    supposing that you have installed dcmtk352 and are able to run the new
    worklist SCP implementation "wlmscpfs" (which replaces the former "wlistctn"
    application (which may be used analogously in case you have an earlier
    version of dcmtk)) as well as the "findscu" application, do the following:
    
    1. use dump2dcm to convert all "*.dump" files in dcmtk/dcmwlm/wlistdb/OFFIS
    to "*.wl" files (DICOM format). Note that these files have to have the
    extension "*.wl", otherwise wlmscpfs will not find these files. These files
    represent your worklist database.
    2. use dump2dcm to convert all "*.dump" files in dcmtk/dcmwlm/wlistqry to
    "*.dcm" files (DICOM format). These files represent possible queries that
    can be used to query the worklist database.
    3. in one shell go "wlmscpfs -v -dfp dcmtk/dcmwlm/wlistdb 1234" (start the
    worklist management SCP)
    4. in another shell go "findscu -v --call OFFIS localhost 1234
    dcmtk/dcmwlm/wlistqry/wlistqry0.dcm" (send a certain query to the WLM SCP)
    
    Step 3 will start the worklist management SCP which will listen on port 1234
    for incoming C-FIND RQ messages. The "-dfp dcmtk/dcmwlm/wlistdb" option
    specifies that the worklist database can be found in folder
    "dcmtk/dcmwlm/wlistdb". Note that the worklist database can be organized in
    different storage areas. Subfolder "OFFIS" below "dcmtk/dcmwlm/wlistdb" is
    one (the only one in this case) storage area. In an incoming C-FIND RQ, an
    SCU has to tell wlmscpfs which storage area shall be queried; this is done
    by sending a certain "called AE title" to wlmscpfs.
    
    Step 4 will send the query in file "dcmtk/dcmwlm/wlistqry/wlistqry0.dcm"
    using a C-FIND-RQ message to the wlmscpfs application (which is running on
    "localhost" and listening on port "1234"). Option "--call OFFIS" specifies
    that the called AE title is "OFFIS" which in turn tells the wlmscpfs
    application to query the storage area "OFFIS" in its worklist database.
    
    The two programs should then dump information that shows their internal
    processings (C-FIND RQ - C-FIND RSP). You can also use a different query
    file in folder "dcmtk/dcmwlm/wlistqry/" for querying the worklist database.
    
    In case you have more questions, dont hesitate to ask.
    
    
    Regards,
    Thomas Wilkens
    OFFIS

More info from:
[dcmwlm/data/wlistdb](https://github.com/InsightSoftwareConsortium/DCMTK/tree/master/dcmwlm/data/wlistdb)

DCMWLM - EXAMPLE MODALITY WORKLIST DATABASE

Within this directory and its subdirectories is an example of a worklist database as supported by the `wlmscpfs` application.

Each subdirectory within this directory represents an Application Entity (AE) title for `wlmscpfs`.
e.g. requestsing an association with the AE title of OFFIS would allow `wlmscpfs` to search the worklist entities contained in the OFFIS sub-directory.

You can create a subdirectory for you own company and copy the example worklist entities found in the OFFIS subdirectory into your own subdirectory.

The databases of worklist entities to be searched by `wlmscpfs` have a very simple format.  Each database consists of zero or more dicom files.
Each dicom file represents a single worklist entity.

`wlmscpfs` locks the worklist database while performing a search to indicate that other processes should not update the database. 
Locking is achieved by locking a lockfile within each worklist database.
A file `lockfile` must exist within each worklist database directory.
The lockfile can be empty.

If no processes are accessing the worklist database then new worklist entities can be added by creating a dicom files containing worklist attributes and worklist entities can be removed by deleting worklist files.  

Files containing worklist entities must have the suffix ".wl".

If the "*.wl" files do not yet exist, you can create them using
the `dump2dcm` command, e.g.
	`dump2dcm -g wklist2.dump wklist2.wl`

New worklist files can be easily adapted from existing files using the following procedure (`wklist1.wl` is an existing worklist file):

Step 1: create an ascii dump of the worklist file wklist1.wl
```cmd
dcmdump wklist1.wl > wklist2.dump
```

Step 2: edit the text file by modifying the value fields within square brackets([]).  
```cmd
vim wklist2.dump 
```

Step 3: convert the text file into a dicom file.
```cmd
dump2dcm -g wklist2.dump wklist2.wl
```

See the documentation in `dcmtk/dcmdata/docs` for more information
on the `dcmdump` and `dump2dcm` utilities.


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

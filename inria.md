### OAR
```ash
# --property=""
gpu='YES'
gpucapability>='5.2'
cluster='dellt630gpu'
host='nefgpu20.inria.fr'
dedicated='epione'

# -l
/nodes=1/core=1,walltime=0:30:0
/gpunum=1

# associate JOBID to COMMAND
oarstat -u lantelmi | grep effort | awk '{print $1}' | while read i; do oarstat -fj $i | grep -E 'command|Job_Id:' | rev | cut -d' ' -f1 | rev | tr '\n' ' '; echo; done | tee submitted.txt
# Interactive mode for 30 minutes
oarsub -I -l /nodes=1/core=1,walltime=0:30:0
oarsub -I -t besteffort --property="(gpu='YES' AND cluster='dellt630gpu' and dedicated='epione')" -l /gpunum=1,walltime=01:00:00
oarsub -I -t besteffort --property="(gpu='YES' AND gpucapability='5.2' AND ibswitch='ibswc2nef' AND cluster='dellt630gpu' and cpuarch='x86_64' and dedicated='asclepios')" -l /gpunum=1,walltime=12:00:00

# reservation mode
oarsub --property="(host='nefgpu29.inria.fr' AND cluster='dellt640gpu')" -l /gpunum=1,walltime=24:00:00 -r "2020-01-20 17:21:00"

# node	cluster	gpucapability
dedicated	host	cluster	capability	cpu
mathneuro	nefgpu01	dellr730gpu	3.7	Xeon 2600 # eddy_cuda OK (Matrox Electronics Systems Ltd. G200eR2 rev 01)
_NO_	nefgpu03	carrigpu	2.0	Xeon 2667
_NO_	nefgpu04
_NO_	nefgpu05	dellc6100gpu	2.0	Xeon 2667 # eddy_cuda OK (ASPEED Technology, Inc. ASPEED Graphics Family rev 10)
_NO_	nefgpu06	dellc6100gpu	2.0	Xeon 2667

epione	nefgpu07	dellt630gpu	5.2	Xeon 2400 # 4x GPU GTX1080Ti (eddy_cuda OK )
zenith	nefgpu08	dellt630gpu 	6.1	Xeon 2400 # eddy_cuda doesn't work
graphdeco	nefgpu09	dellt630gpu	5.2	Xeon 2200
stars	nefgpu10	dellt630gpu	5.2	Xeon 2200
stars	nefgpu11	dellt630gpu	6.1	Xeon 2200
stars	nefgpu12	dellt630gpu	6.1	Xeon
graphdeco	nefgpu13	dellt630gpu	6.1	Xeon 2200
stars	nefgpu14	dellt630gpu	6.1	Xeon
stars	nefgpu15	dellt630gpu	6.1	Xeon
epione	nefgpu16	dellt630gpu	6.1	Xeon 2200 # 4x GPU GTX1080Ti + 2x (E5-2630v4 CPU 10 cores 20 threads) + 128GB RAM + 1.6TB SSD disk under /local
zenith	nefgpu17	dellt630gpu	6.1	xeon
_NO_	nefgpu18	dellt630gpu	6.1	xeon
_NO_	nefgpu19	dellt630gpu	6.1	xeon
_NO_	nefgpu20	dellt630gpu	6.1	xeon
stars	nefgpu21	dellt630gpu	6.1	xeon
stars	nefgpu22	dellt630gpu	6.1	xeon
tititane-epitome	nefgpu23        dellt630gpu     6.1     xeon

epione	nefgpu24	dellt640gpu	6.1	xeon	# 4x GPU GTX1080Ti
zenith	nefgpu25	dellt640gpu 	6.1
wimmics	nefgpu26	dellt640gpu 	6.1
zenith	nefgpu27	dellt640gpu 	7.5	xeon
graphdeco	nefgpu28	dellt640gpu 	6.1	xeon
epione	nefgpu29	dellt640gpu	6.1	xeon
_NO_	nefgpu30	dellt640gpu	6.1	xeon
_NO_	nefgpu31	dellt640gpu	6.1	xeon
_NO_	nefgpu32	dellt640gpu	6.1	xeon
_NO_	nefgpu40	esc8kgpu	6.1	xeon

_NO_	nefgpu42	dellr740gpu	6.1	xeon
_NO_	nefgpu43	dellr740gpu	6.1	xeon
_NO_	nefgpu44	dellr740gpu	6.1	xeon
_NO_	nefgpu45	dellr740gpu	6.1	xeon

nef001-006	dellr815 	opteron 2200
nef007-008	dellc6145	opteron 2300

# Submit
oarsub -S "./script.sh var1 var2 ..."
oarsub -S <./script.sh> --array-param-file <args.txt>
oarsub -n <name> -t <queue> --property="(gpu='YES' AND gpucapability>='5.2')" -S <./script.sh> --array-param-file <args.txt>

# Request
oarsub -r "$(date '+%Y-%m-%d %H:%M:%S' --date='+1 week')"
oarsub -r "2018-12-29 18:30:00" -S $PWD/freesurfer_autorecon1_wrapper.sh
oarsub --property="(host='nefgpu24.inria.fr' AND cluster='dellt640gpu')" -l /gpunum=1,walltime=24:00:00 -r "2018-11-19 08:59:00"

# 200GB to reserve a full node :
oarsub -p 'mem > 200000' -l /nodes=1

## OARSTAT
oarstat --gantt "$(date '+%Y-%m-%d %H:%M:%S'),$(date '+%Y-%m-%d %H:%M:%S' --date='+1 week')"
oarstat --accounting "$(date '+%Y-%m-%d'), $(date '+%Y-%m-%d' --date='+1 week')"
oarstat --JSON | grep owner | ggSortUniqSort

# find asclepios members
ls -l $HOME/.. | grep asclepios | awk '{print $3}' | sort | uniq | sort -V | tr '\n' '|'

# QUOTA
quota -s -u lantelmi
ls -l $HOME/.. | grep epione | awk '{print $3}' | sort | uniq | sort -V | while read i; do sudo beegfs-ctl --getquota --uid $i | grep $i; done >> quotas && sed 's/|/\ /g' quotas | sort -k 4,4 -k 3,3 -r

# Find the Cluster Master in the last month
oarstat --accounting "$(date '+%Y-%m-%d' --date='-1 month'), $(date '+%Y-%m-%d')" | sort -r -k7 | awk '{print $0" \t Days "$7/86400" \t Years "$7/86400/365 }' | grep_asclepios

# matlab licences used
/opt/matlab2015a/etc/glnxa64/lmutil lmstat -c /opt/matlab2015a/licenses/network.lic -a | grep_asclepios | grep lantelmi

# filesystem
https://wiki.inria.fr/ClustersSophia/User_Guide_new_config#.E2.80.82Disk_space_management
/home  # Each user has a home directory in the /home storage. You can check you current disk occupation with the quota -s command
/data  # A distributed scalable file system is available under /data for several usages
/local (dedicated)   # SSD performance
/local/tmp (common)  # SSD performance
/tmp  # node local hard disk
/dev/shm  # RAM (memory) filesystem

# ENVIRONMENT
OARCONFFILE=/etc/oar/oar.conf
OARDIR=/usr/lib/oar
OARDO_UID=888
OARDO_USER=oar
OARUSER=oar
OARXAUTHLOCATION=/usr/bin/xauth
OAR_ARRAYID=5362183
OAR_ARRAYINDEX=1
OAR_ARRAY_ID=5362183
OAR_ARRAY_INDEX=1
OAR_CPUSET=/oar/lantelmi_5362183
OAR_FILE_NODES=/var/lib/oar/5362183
OAR_JOBID=5362183
OAR_JOB_ID=5362183
OAR_JOB_NAME=
OAR_JOB_WALLTIME=1:0:0
OAR_JOB_WALLTIME_SECONDS=3600
OAR_KEY=1
OAR_NODEFILE=/var/lib/oar/5362183
OAR_NODE_FILE=/var/lib/oar/5362183
OAR_O_WORKDIR=/data/asclepios/share/private/insight_bkp/PROCESSED/FREESURFER
OAR_PROJECT_NAME=default
OAR_RESOURCE_FILE=/var/lib/oar/5362183
OAR_RESOURCE_PROPERTIES_FILE=/var/lib/oar/5362183_resources
OAR_STDERR=OAR.5362183.stderr
OAR_STDOUT=OAR.5362183.stdout
OAR_USER=lantelmi
OAR_WORKDIR=/data/asclepios/share/private/insight_bkp/PROCESSED/FREESURFER
OAR_WORKING_DIRECTORY=/data/asclepios/share/private/insight_bkp/PROCESSED/FREESURFER
SUDO_COMMAND=OAR
```

#!/usr/bin/env bash
# submit command: oarsub -n cv -S ./oarsub_cpu.sh --array-param-file jobs.txt
# job example: myscript.py arguments

# GPU arguments for the scheduler
#OAR -l /gpunum=1,walltime=12:00:00
#OAR -p gpucapability>='5.2'
# Automatic: -p dedicated='NO' OR dedicated='epione'

# stdout and stderr initially in /tmp
#OAR -O /home/lantelmi/mnistLR.%jobid%.stdout
#OAR -E /home/lantelmi/mnistLR.%jobid%.stderr

# Redirect stdout and stderr
#exec > $1.${OAR_JOB_ID=0}.stdout 2> $1.${OAR_JOB_ID=0}.stderr

set -x

#handler() {
#	echo "Caught checkpoint signal at: `date`"
#	echo "Terminating."
#	touch "${1}.sigusr2"
#	exit 0
#}
#trap "handler ${1}" SIGUSR2

cat << EOF
Hostname: `hostname`
Pid: $$
Job: ${OAR_JOB_ID}
Starting job at: `date`
echo
EOF

echo "==== Debut du job ${OAR_JOB_ID} $(date)" >&2
echo "${OAR_JOB_ID} $0 $@"

##########
## MAIN ##
##########
shopt
if [ -z "${HOSTNAME##*gpu*}" ]; then
    GPU='True'
    module load cuda/9.2 cudnn/7.1-cuda-9.2
else
    GPU='False'
fi
CONDAENV='torch-1.4'
if [[ $HOSTNAME = nef* ]]; then
    export PYTHON="/data/epione/share/software/miniconda3/envs/${CONDAENV}/bin/python"
else
    export PYTHON="/home/lantelmi/Software/Python3/miniconda3/envs/${CONDAENV}/bin/python"
fi

#CONDAENV=$(conda info --envs | grep '*' | awk '{print $1}')
#if [ ! "$CONDAENV" == "py37" ]; then
#    echo "Loading conda py37 environment"
#    source activate py37
#fi
#SCRIPT_NAME="${0%.sh}"  # remove .sh from arg 0
$PYTHON $@

###########
## /MAIN ##
###########
echo "====   Fin du job ${OAR_JOB_ID} $(date)"
echo "====   Fin du job ${OAR_JOB_ID} $(date)" >&2
exit $?

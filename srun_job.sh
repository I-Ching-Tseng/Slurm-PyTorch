#!/bin/bash

#SBATCH -J env_var_test            # Job name
#SBATCH -o %j.out          # Name of stdout output  file (%j expands to jobId)
#SBATCH -t 00:30:00                # Run time (hh:mm:ss) -  0.5 hours
#SBATCH -p gp2d                    # partition
#SBATCH -A MST109216               # iService Project id
#SBATCH --nodes 2                  # Number of nodes
#SBATCH --ntasks-per-node 2        # Number of MPI process  per node
#SBATCH --gres=gpu:2               # Number of GPUs per node

module purge
module load compiler/gnu/7.3.0 singularity

MASTER_ADDR=$(scontrol show hostnames $SLURM_NODELIST | head -n 1)
cmd="singularity exec --nv pytorch_19.02-py3-horovod_0.16.0.sif python all_to_all.py --local_rank=$SLURM_NODEID"
srun $cmd

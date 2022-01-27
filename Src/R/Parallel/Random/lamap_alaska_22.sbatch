#!/bin/bash
#SBATCH --account=def-collard
#SBATCH --job-name=LAMAP_Alaska22
#SBATCH --mail-user=wcarleto@sfu.ca
#SBATCH --mail-type=ALL
#SBATCH --ntasks-per-node=8
#SBATCH --nodes=8
#SBATCH --time=10:00:00

module load r/3.4.0
module load openmpi/1.10.7

export R_LIBS=/home/carleton/R/x86_64-pc-linux-gnu-library/3.4/

mpirun -n 1 Rscript --vanilla /home/carleton/project/carleton/Alaska/R_scripts/lamap_go_graham_alaska_22.R $SLURM_NPROCS

#!/usr/bin/env bash

#SBATCH --job-name=021-us8k-classifier-train
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64GB
#SBATCH --time=7-0
#SBATCH --mail-type=ALL
#SBATCH --mail-user=justin.salamon@gmail.com
#SBATCH --output="021-classifier-train-%A-%a.out"
#SBATCH --err="021-classifier-train-%A-%a.err"


source ~/.bashrc
source activate l3cpu

SRCDIR=$HOME/dev/l3embedding
FEATURES_DIR=/scratch/hhw230/sonyc-usc/features/us8k/l3/short/music/cnn_L3_melspec1
OUTPUT_DIR=/scratch/js7561/l3_cls
MODEL_TYPE='mlp'
FEATURE_MODE='framewise'	
GOOGLE_DEV_APP_NAME='l3embeddingexperiments'
GSHEET_ID='1eyFv_jUWJeEuG1VKQNfAmhQUREMRDgEMxfVDffRaHDo'
FOLD_NUM=$SLURM_ARRAY_TASK_ID

module purge

python $SRCDIR/06_train_classifier.py \
    --random-state 20171021 \
    --model-type $MODEL_TYPE \
    --feature-mode $FEATURE_MODE \
    --num-epochs 150 \
    --train-batch-size 32 \
    --gsheet-id $GSHEET_ID \
    --google-dev-app-name $GOOGLE_DEV_APP_NAME \
    --verbose \
    --non-overlap \
    $FEATURES_DIR \
    $OUTPUT_DIR \
    $FOLD_NUM

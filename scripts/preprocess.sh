#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=kywon63@student.monash.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load python/3.6.2
source ../venv/bin/activate

PROJ_DIR=/home/kwong/da33_scratch/kwong/discNMT/HAN_NMT
INPUTS_DIR=$PROJ_DIR/inputs/Europarl-EOE/annotated
OUTPUTS_DIR=$PROJ_DIR/inputs/Europarl-EOE/processed
TRAIN_SRC=$INPUTS_DIR/train.en-de.sent.en
#TRAIN_SRC=$INPUTS_DIR/train.en-de.sent.deptag.en
TRAIN_TGT=$INPUTS_DIR/train.en-de.sent.de
TRAIN_DOC=$INPUTS_DIR/train.en-de.sent.idx
VALID_SRC=$INPUTS_DIR/dev.en-de.sent.en
#VALID_SRC=$INPUTS_DIR/dev.en-de.sent.deptag.en
VALID_TGT=$INPUTS_DIR/dev.en-de.sent.de
VALID_DOC=$INPUTS_DIR/dev.en-de.sent.idx
OUT_F=$OUTPUTS_DIR/deptag/Europarl-EOE-deptag

cd $PROJ_DIR/full_source/
python preprocess.py -train_src $TRAIN_SRC -train_tgt $TRAIN_TGT -train_doc $TRAIN_DOC \
-valid_src $VALID_SRC -valid_tgt $VALID_TGT -valid_doc $VALID_DOC -save_data $OUT_F
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
INPUTS_DIR=$PROJ_DIR/inputs/Europarl-EOE-doc-sample/annotated
OUTPUTS_DIR=$PROJ_DIR/inputs/Europarl-EOE-doc-sample/processed
#TRAIN_SRC=$INPUTS_DIR/train.en-de.doc.en
TRAIN_SRC=$INPUTS_DIR/train.en-de.doc.deptag.en
TRAIN_TGT=$INPUTS_DIR/train.en-de.doc.de
TRAIN_DOC=$INPUTS_DIR/train.en-de.doc.idx
#VALID_SRC=$INPUTS_DIR/dev.en-de.doc.en
VALID_SRC=$INPUTS_DIR/dev.en-de.doc.deptag.en
VALID_TGT=$INPUTS_DIR/dev.en-de.doc.de
VALID_DOC=$INPUTS_DIR/dev.en-de.doc.idx
OUT_F=$OUTPUTS_DIR/deptag/Europarl-EOE.doc.deptag

cd $PROJ_DIR/full_source/
python preprocess.py -train_src $TRAIN_SRC -train_tgt $TRAIN_TGT -train_doc $TRAIN_DOC \
-valid_src $VALID_SRC -valid_tgt $VALID_TGT -valid_doc $VALID_DOC -save_data $OUT_F \
-src_seq_length 1100 -tgt_seq_length 1100 -src_seq_length_trunc 1100 -tgt_seq_length_trunc 1100

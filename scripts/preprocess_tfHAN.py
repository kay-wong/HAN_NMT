# Preprocess input files into TF-HAN input format
import numpy as np
import itertools as it
import os, sys

#===========================================================================

def split_docs(fname):
    docs = []
    # Split by doc boundary
    with open(fname,'r') as f:
        for key,group in it.groupby(f,lambda line: line.startswith('<d>')):
            if not key:
                group = list(group)
                docs.append("".join(group))
    return docs

def preprocess_formatHAN(src_f, src_depf, tgt_f, outdir):
    docs_src = split_docs(src_f)
    docs_tgt = split_docs(tgt_f)
    docs_src_dep = split_docs(src_depf)
    fname = os.path.splitext(os.path.basename(src_f))[0]
    src_outf = os.path.join(outdir, os.path.basename(src_f))
    src_deptagf = os.path.join(outdir, os.path.basename(src_depf))
    tgt_outf = os.path.join(outdir, os.path.basename(tgt_f))
    idx_outf = os.path.join(outdir, fname+'.idx')

    f_src = open(src_outf, 'a')
    f_srcdep = open(src_deptagf, 'a')
    f_tgt = open(tgt_outf, 'a')
    f_idx = open(idx_outf, 'a')
    f_idx.write('0\n')

    idx_cnt = 0
    for i, (src, dep, tgt) in enumerate(zip(docs_src, docs_src_dep, docs_tgt)):
        f_src.write(src)
        f_srcdep.write(dep)
        f_tgt.write(tgt)
        idx_cnt+= len(src.split('\n'))-1
        if i< len(docs_src)-1:
            f_idx.write(str(idx_cnt))
            f_idx.write('\n')

    f_src.close()
    f_srcdep.close()
    f_tgt.close()
    f_idx.close()

def doc_idx_file(infname, outfname):
    with open(infname, 'r') as fin:
        doc = fin.readlines()
    
    with open(outfname, 'w') as fout:
        for i in range(len(doc)):
            fout.write(str(i)+"\n")
    
    with open(outfname, 'w') as fout:
        for i in range(20000):
            fout.write(str(i)+"\n")

if __name__ == "__main__":
    SRC_F=sys.argv[1]
    SRC_DEP=sys.argv[2]
    TGT_F=sys.argv[3]
    OUT_DIR=sys.argv[4]
    
    preprocess_formatHAN(SRC_F, SRC_DEP, TGT_F, OUT_DIR)

# chelicerate_mcscanx
mcscanx runs for chelicerates

if you want to rerun this you will need the gene_order.tsv and fasta files from the djleite/Ohnologs repo

- wohomology* - contains the runs in the ms that do not use orthofinder homology from ohnolog prediction
- whomology*  - contains the runs in the ms that do use orthofinder homology from ohnolog prediction
- get_circos_kar_highlights_links.py - script to get the links for circos plotting
- get_overlap_plot.py - script to plot overlap with ohnologs
- get_overlap_simple.py - script to plot simple overlap with ohnologs
- run_all_mcscanx_w_homology.sh - scrip to run the mcscanx (modify to run wo homology)
- run_all_mcscanx_overlap_plot.sh - wrapper script to make all plots from python scripts

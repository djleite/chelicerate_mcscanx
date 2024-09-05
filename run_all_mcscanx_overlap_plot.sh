# run mcscanx

fastas='/work/WGD/synteny/mcscanx/data/from_braker/for_paper/fastas'
gorder='/work/WGD/synteny/mcscanx/data/from_braker/for_paper/gene_order'


for i in DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA CARROT TACGIG
	do
	cp /work/WGD/GO/from_braker/ohno_list/${i}_1.5_C.txt /work/WGD/synteny/mcscanx/data/from_braker/for_paper/whomology_1.5/${i}/${i}_ohnologs.txt
	cp /work/WGD/GO/from_braker/ohno_list/${i}_1.5_C.txt /work/WGD/synteny/mcscanx/data/from_braker/for_paper/wohomology_1e-10/${i}/${i}_ohnologs.txt
	python get_overlap_plot.py /work/WGD/synteny/mcscanx/data/from_braker/for_paper/whomology_1.5/${i}/${i}
	python get_overlap_plot.py /work/WGD/synteny/mcscanx/data/from_braker/for_paper/wohomology_1e-10/${i}/${i}

done


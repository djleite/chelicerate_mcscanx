# run mcscanx

fastas='/work/WGD/synteny/mcscanx/data/from_braker/for_paper/fastas'
gorder='/work/WGD/synteny/mcscanx/data/from_braker/for_paper/gene_order'

run='wohomology'

for x in 1e-2 1e-10 1e-20
	do
	mkdir ${run}_${x}

	for i in HAELON DERSIL DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA CARROT TACGIG
		do

		# make species folder
		mkdir ${run}_${x}/${i}

		# make gff
		cat ${gorder}/${i}_gene_order.tsv | awk '{print $3"\t"$1"\t"$4"\t"$5}' > ${run}_${x}/${i}/${i}.gff

		# diamond blast
		diamond makedb --in ${fastas}/${i}_prot_t1.fasta --db ${run}_${x}/${i}/${i}
		diamond blastp -e ${x} --query ${fastas}/${i}_prot_t1.fasta --db ${run}_${x}/${i}/${i}.dmnd -p 60 -o ${run}_${x}/${i}/${i}.blast

		# copy paralogs file from ohnolog pipeline
		#cat /work/WGD/ohnolog_prediction/spiders_ohnologs/runs/braker_final_for_paper/*/run_${x}/paralogs/${i}*.tsv | awk '{print $1"\t"$2}' >  ${run}_${x}/${i}/${i}.blast


		# MCScanX_h
		printf "\n############ Running MCScanX for: "${run}_${x}/${i}"\n"
		# -s 4 -k 1000 -g -1 -u 1000000 -m 50 -b 1
		/work/software/MCScanX/MCScanX ${run}_${x}/${i}/${i} -b 1 &> ${run}_${x}/${i}/${i}.log

		printf "\n############ Running dup gene classifier: "${run}/${i}"\n"
		/work/software/MCScanX/duplicate_gene_classifier ${run}_${x}/${i}/${i} &> ${run}_${x}/${i}/${i}_classes.txt 

		cat ${run}_${x}/${i}/${i}.gene_type | awk '{ if ($2=="0") print $1}' > ${run}_${x}/${i}/${i}_singleton.txt
		cat ${run}_${x}/${i}/${i}.gene_type | awk '{ if ($2=="1") print $1}' > ${run}_${x}/${i}/${i}_dispersed.txt
		cat ${run}_${x}/${i}/${i}.gene_type | awk '{ if ($2=="2") print $1}' > ${run}_${x}/${i}/${i}_proximal.txt
		cat ${run}_${x}/${i}/${i}.gene_type | awk '{ if ($2=="3") print $1}' > ${run}_${x}/${i}/${i}_tandem.txt
		cat ${run}_${x}/${i}/${i}.gene_type | awk '{ if ($2=="4") print $1}' > ${run}_${x}/${i}/${i}_segmental.txt
	done

	# build summary file
	printf "Species\tSingleton\tDispersed\tProximal\tTandem\tSegmental-WGD\n" > ${run}_${x}/${run}_${x}_summary.txt
	for i in HAELON DERSIL DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA CARROT TACGIG
		do 
		printf ${i}'\t' >> ${run}_${x}/${run}_${x}_summary.txt
		grep Singleton ${run}_${x}/${i}/${i}_classes.txt | awk '{print $3}' | tr '\n' '\t' >> ${run}_${x}/${run}_${x}_summary.txt
		grep Dispersed ${run}_${x}/${i}/${i}_classes.txt | awk '{print $3}' | tr '\n' '\t' >> ${run}_${x}/${run}_${x}_summary.txt
		grep Proximal ${run}_${x}/${i}/${i}_classes.txt | awk '{print $3}' | tr '\n' '\t' >> ${run}_${x}/${run}_${x}_summary.txt
		grep Tandem ${run}_${x}/${i}/${i}_classes.txt | awk '{print $3}' | tr '\n' '\t' >> ${run}_${x}/${run}_${x}_summary.txt
		grep WGD ${run}_${x}/${i}/${i}_classes.txt | awk '{print $5}' >> ${run}_${x}/${run}_${x}_summary.txt
	done




#cat /work/WGD/ohnolog_prediction/spiders_ohnologs/runs/braker_final_for_paper/*/run_${x}









done





#printf "\n############ Running get ohnolog and rbh files\n"
# get ohnologs
#for i in DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA
#do
#cp /work/WGD/GO/from_braker/ohno_list/${i}_1.5_C.txt ${run}/${i}/${i}_ohnologs.txt
#done

# get RBH
#for i in DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA
#do
#cat /work/WGD/RBH/outgroup_single_copy_with_wgd_spider_matches.txt | tr '\t' '\n' | grep ${i} > ${run}/${i}/${i}_rbh.txt
#done

#printf "\n############ Running overlap plot\n"
# plot overlap
#for i in DYSSIL ECTDAV ARGBRU TRIANT TRICLA PARTEP LATELE ULODIV OEDGIB HYLGRA
#do
#python get_overlap_plot.py /work/WGD/synteny/mcscanx/data/from_braker/whomology/${i}/${i}
#done


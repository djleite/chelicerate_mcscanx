import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import sys

input_dir_sp = sys.argv[1]

def file2list(wkdir, tag):
    outlist = []
    with open(wkdir + "_" + tag + ".txt", 'r') as infile:
        for line in infile:
            line = line.strip("\n")
            outlist.append(line)
    outlist.sort()
    return outlist

# Replace these with your own lists of terms
list1 = file2list(input_dir_sp, "ohnologs")
#list2 = file2list(input_dir_sp, "rbh")
list3 = file2list(input_dir_sp, "singleton")
list4 = file2list(input_dir_sp, "dispersed")
list5 = file2list(input_dir_sp, "proximal")
list6 = file2list(input_dir_sp, "tandem")
list7 = file2list(input_dir_sp, "segmental")

#lists = [list1, list2, list3, list4, list5, list6, list7]
#list_names = ['ohnologs','rbh', 'singleton', 'dispersed', 'proximal', 'tandem', 'segmental']
lists = [list1,  list3, list4, list5, list6, list7]
list_names = ['ohnologs','singleton', 'dispersed', 'proximal', 'tandem', 'segmental']

# Initialize an empty matrix to store the number of overlapping terms
overlap_matrix = np.zeros((len(lists), len(lists)), dtype=int)

# Calculate the number of overlapping terms for each pair of lists
for i in range(len(lists)):
    for j in range(len(lists)):
        set1 = set(lists[i])
        set2 = set(lists[j])
        overlap_count = len(set1.intersection(set2))
        overlap_matrix[i][j] = overlap_count
mask = np.triu(np.ones(overlap_matrix.shape), k=1)

# Create a heatmap using Seaborn with integer formatting and increased margins
sns.set()
plt.figure(figsize=(6, 5))
ax = sns.heatmap(overlap_matrix, mask=mask, annot=True, fmt='d', xticklabels=[f"{name}\n({len(list)})" for name, list in zip(list_names, lists)], yticklabels=[f"{name}\n({len(list)})" for name, list in zip(list_names, lists)], cmap="YlOrRd")

# Adjust the margins using tight_layout and add padding
plt.tight_layout(rect=[0, 0, 1, 1])
plt.subplots_adjust(left=0.15, right=0.99, top=0.99, bottom=0.2)

# Rotate the x-axis labels for better readability
plt.xticks(rotation=90, ha='right')
plt.yticks(rotation=0, ha='right')


plt.savefig(input_dir_sp+"_heatmap.png")

#plt.show()

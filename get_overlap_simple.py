import matplotlib.pyplot as plt
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
    
    
# Sample lists
# Replace these with your own lists of terms
list1 = file2list(input_dir_sp, "ohnologs")
list2 = file2list(input_dir_sp, "singleton")
list3 = file2list(input_dir_sp, "dispersed")
list4 = file2list(input_dir_sp, "proximal")
list5 = file2list(input_dir_sp, "tandem")
list6 = file2list(input_dir_sp, "segmental")

# Creating sets from lists
set1 = set(list1)

# Creating a dictionary to store the overlap percentage with each list
overlap_percentage_dict = {}

# Finding the overlap percentage with each list
for i in range(2, 7):
    list_name = f"list{i}"
    current_list = globals()[list_name]
    current_set = set(current_list)
    
    # Finding the overlap
    overlap = set1.intersection(current_set)
    
    # Calculating the overlap percentage
    overlap_percentage = len(overlap) / len(set1) * 100
    
    # Storing the result in the dictionary
    overlap_percentage_dict[list_name] = overlap_percentage

# Plotting the data
lists = list(overlap_percentage_dict.keys())
percentages = list(overlap_percentage_dict.values())

plt.bar(lists, percentages, color='blue')
plt.xlabel('Lists')
plt.ylabel('Overlap Percentage')
plt.title('Percentage of List1 Shared by Each Other List')
plt.ylim(0, 100)  # Set the y-axis limit to 0-100 for percentage

# Display the percentage values on top of the bars
for i, value in enumerate(percentages):
    plt.text(i, value + 1, f'{value:.2f}%', ha='center', va='bottom')

plt.show()


import sys 
import csv
import numpy as np 

#file_csv = "A.csv"
#reader = csv.reader(open(file_csv, "rb"), delimiter = ",")
#x = list(reader)
#result = np.array(x).astype("float") 
#print(result)

a_file = open("A.csv") 
a_numpy_array = np.genfromtxt(a_file, delimiter = ",", skip_header = 1 ) 

print(a_numpy_array) 
print("\n")

print(a_numpy_array[1])
print("\n")

print(a_numpy_array[0][1])
print("\n")


#IT WORKS AS 2D ARRAY 

b_file = open("B.csv")
b_numpy_array = np.genfromtxt(b_file, delimiter = ",", skip_header = 1) 

print(b_numpy_array)
print("\n")

print(b_numpy_array[1])
print("\n")

print(b_numpy_array[0][1])
print("\n") 

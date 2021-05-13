import os 
import sys 
import csv
import math 
import codecs
import numpy as np
class Error(Exception):
    pass
class Load_Error(Error):
    pass

def loadA(fileA): #loads file A.csv into a nparray
    global a_numpy_array
    #a_file = open("TEST.csv")
    a_file = open("A.csv") 
    a_numpy_array = np.genfromtxt(a_file, delimiter = ",")     
    print "file A"
    print a_numpy_array    

def loadB(fileB): #loads file B.csv into a nparray
    global b_numpy_array
    b_file = open("B.csv")
    b_numpy_array = np.genfromtxt(b_file, delimiter = ",")
    print "file B"
    print b_numpy_array     

def create_list(array): # converts a numpy array into an array list          
    global list_array
    list_array = list()    
    for row in array: # iterates thru the array converts item into an int before append
        for item in row:
            list_array.append(int(item))
def idmatrix(size,choice): # creates an identity matrix based on the dimensions passed
    identity_matrix = [[0]*size for i in range(size) # initialize identity_matrix 
    for i in range(size): # fills the identity_matrix array 
        identity_matrix[i][i] = 1
            for rows in identity_matrix:
              dummy = 0
    identity_matrix = np.array(identity_matrix) #converts matrix back to a nparray
    if choice==3:
        print "The identity matrix of A is:"
     else:
        print "The identity matrix of B is:"
        print identity_matrix
              
def square(array,choice): # verifies the array passed is square and up to 10X10                          
    create_list(array)              
    No_elements = len(list_array)   
    root = math.sqrt(No_elements)
    print " "
    if int(root + 0.5) ** 2 == No_elements or No_elements > 100:
        size = int(root)
        square_array = np.array(list_array) #converts list_array into an np array
        square_array = square_array.reshape(size,size) #reshape matrix to square dimensions        
        if choice in (3,7):            
            print "file A square identity matrix of ",np.shape(square_array)
        elif choice in (4,8):
            print "file B square identity matrix of ",np.shape(square_array)
        print square_array
        return True
    else:    
        if array == a_numpy_array:
            f = "A"
        else:
            f = "B"       
        print "Can't proceed, file",f,"is not a squared matrix or is beyond the scope of a matrix of 10X10"
        print array
        return False

def scalar(array,choice,n): # calculates the scalar n times the passed array    
    numOfRow = np.size(array,0)
    numOfCol = np.size(array,1)
    scalar_array = [[0 for x in range(numOfRow)] for i in range(numOfCol)] #initialiaze scalar array
    r = 0
    c = 0
    for row in array: # iterates thru the array and multiplies by n 
        for column in array:
            scalar_array[r][c] = n * array[r][c]
            c = c + 1
        r = r+1
        c = 0
    print " "
    if choice == 5: 
        print "file A"
        print array
        print "scalar",n,"times array A is:"
    elif choice == 6: 
        print "file B"
        print array
        print "scalar",n,"times B is:"
    scalar_array = np.array(scalar_array) 
    print scalar_array

def det(array): # calculates the determinant of passed array   
    # if given matrix is of order 2*2 then simply return det
    # value by cross multiplying elements of matrix.
    if(len(array) == 2):
        value = array[0][0] * array[1][1] - array[1][0] * array[0][1]        
        return value    
    Sum = 0  
    for current_column in range(len(array)): # loops to traverse each column of matrix array
        # calculates the sign corresponding to co-factor of that sub matrix.
        sign = (-1) ** (current_column)
        # calls the function recursily to get determinant value of
        # sub matrix obtained.
        sub_det = det(getcofactor(array, 0, current_column))
        # adds the calculated determinant value of particular column
        # into the matrix to total Sum.
        if sub_det == None:
            sub_det = 0        
        Sum += (sign * array[0][current_column] * sub_det)
    # returns the final Sum
    return Sum    

def getcofactor(m, i, j): # subroutine of the determinant to get the cofactor
    return [row[: j] + row[j+1:] for row in (m[: i] + m[i+1:])]

def sumAB(array1,array2): # calculates the addition of arrays passed 
    numOfRow = np.size(array1,0)
    numOfCol = np.size(array1,1)
    array_sum = [[0 for x in range(numOfRow)] for i in range(numOfCol)]
    r = 0
    c = 0 
    for row in a_numpy_array: # loops thru to obtain the sumation  
        for column in b_numpy_array:
            array_sum[r][c] = a_numpy_array[r][c] + b_numpy_array[r][c]
            c = c + 1
        r = r + 1
        c = 0       
    array_sum = np.array(array_sum)
    print "file A"
    print array1
    print "file B"
    print array2
    print "The addition of A + B is:" 
    print array_sum

def subAB(array1,array2,choice): # calculates the substraction of passed arrays
    #initilize sub_array and counters
    numOfRow = np.size(array1,0)
    numOfCol = np.size(array1,1)    
    array_sub = [[0 for x in range(numOfRow)] for i in range(numOfCol)]
    r = 0
    c = 0
    if choice == 8:   
        for row in array1: # substracts B - A 
            for column in array2:
                array_sub[r][c] = array2[r][c] - array1[r][c]
                c = c + 1
            r = r + 1
            c = 0
        print "file A"
        print array1
        print "file B"
        print array2
        print "The subtraction of A - B is:"        
    elif choice == 9:        
        for row in array1: # substracts array A - B 
            for column in array2:
                array_sub[r][c] = array1[r][c] - array2[r][c]
                c = c + 1
            r = r + 1
            c = 0
        print "file B"
        print array2
        print "file A"
        print array1
        print "The subtraction of B - A is:"    
    array_sub = np.array(array_sub) #converts to np array
    print array_sub

def multiplyAB(array1,array2,choice): # calculates the multiplication of passed arrays 
    r = 0
    c = 0
    if choice == 18:
        #initilize sub_array and counters
        numOfRow = np.size(array1,0)
        numOfCol = np.size(array2,1)                
        array_mul = [[0 for x in range(numOfCol)] for i in range(numOfRow)]
        array_mul = np.array(array_mul)    
        #multiply array A X B
        #iterating by row of A
        for i in range(len(array1)):
            # iterating by coloum by B 
            for j in range(len(array2[0])):
                # iterating by rows of A
                for k in range(len(array2)):
                    array_mul[i][j] += array1[i][k] * array2[k][j]
        print "file A"
        print array1
        print "file B"
        print array2
        print "The Multiplicatiion of AB is:"
    elif choice == 19:
        #initilize sub_array and counters
        numOfRow = np.size(array2,0)
        numOfCol = np.size(array1,1)
        array_mul = [[0 for x in range(numOfRow)] for i in range(numOfCol)]
        #multiply array B X A        
        #iterating by row of B
        for i in range(numOfRow):
            #iterating by coloum by A
            for j in range(numOfCol):
                #iterating by rows of A
                for k in range(len(array1)):
                    array_mul[i][j] += array2[i][k] * array1[k][j]
        print "file B"
        print array2
        print "file A"
        print array1        
        print "The Multiplication of BA is:"
    array_mul = np.array(array_mul)
    print array_mul
           
def dimensions(array1,array2,choice): # verifies the dimensions of passed arrays
    print " " 
    if choice in (15,16,17):    
        if np.shape(array1)==np.shape(array2):
            print "matrices are of the same dimensions"            
            return True
        else:
            print "can't proceed matrices A and B are not of the same dimensions"           
            return False
    elif choice == 18:
        Col1 = array1.shape[1]
        Row2 = array2.shape[0]       
        if Col1 == Row2:
            print "matrices can be multiplied"             
            return True
        else:
            print "matrices can't be multiplied"
            print "As columns must equal B's rows"        
            return False
    elif choice == 19:
        Col1 = array2.shape[1]
        Row2 = array1.shape[0]
        if Col1 == Row2:
            print "matrices can be multiplied"    
            return True
        else:
            print "matrices can't be multiplied"
            print "B's columns must equal A's rows"
    return False

def Copy(array, choice): 
    global array_copy
    #allocating space for a manipulatable matrix  
    #num_col = 0
    #num_row = 0
    #array_copy = []
    if choice is 20 or choice is 21:
        num_col = np.size(array, 1)
        num_row = np.size(array,0)
        array_copy = [[0 for x in range(num_col)] for i in range(num_row)]
        array_copy = np.array(array_copy)
        #itr row
        for i in range(num_row):
            #itr col
            for j in range(num_col):
                array_copy[i][j] = array[i][j]
        # array_copy[:] = array
        print "\nCopied Array: \n" 
        print(array_copy)
        print "\nOriginal Array: \n" 
        print(array)
        array[0][0] = 22
        print("\n Testing adding 22 to array\n") 
        print(array)
        print("\ncopied array:\n")  
        return array_copy
    elif(choice):
        num_col = np.size(array, 1)
        num_row = np.size(array,0)
        array_copy = [[0 for x in range(num_col)] for i in range(num_row)]
        array_copy = np.array(array_copy)
        #itr row
        for i in range(num_row):
            #itr col
            for j in range(num_col):
                array_copy[i][j] = array[i][j]
        return array_copy
    else:
        return 0 
        

def Swap(array_a, array_b): 
    
    print "\narray_a:\n" 
    print array_a
    print "\n array_b:\n"
    print array_b

    #create a temp for array_a
    num_col = np.size(array_a,1)
    num_row = np.size(array_a,0) 
    array_temp = [[0 for x in range(num_col)] for i in range(num_row)] 
    array_temp = np.array(array_temp) 
    #iterate per row
    for i in range(num_row):
        #iterate per col
        for j in range(num_col): 
            array_temp[i][j] = array_a[i][j]
    #copy b into a
    for i in range(num_row): 
        array_a = np.delete(array_a, 0, 0) 
    
    num_col = np.size(array_b,1) 
    num_row = np.size(array_b,0) 
    array_a = [[0 for x in range(num_col)] for i in range(num_row)] 
    array_a = np.array(array_a) 
    #iterate per row
    for i in range(num_row):
        #iterate per col
        for j in range(num_col): 
            array_a[i][j] = array_b[i][j]
    for i in range(num_row):
        array_b = np.delete(array_b, 0, 0) 
    
    num_col = np.size(array_temp,1)
    num_row = np.size(array_temp,0)
    array_b = [[0 for x in range(num_col)] for i in range(num_row)]
    array_b = np.array(array_b)
    #iterate per row
    for i in range(num_row):
        #iterate per col
        for j in range(num_col): 
            array_b[i][j] = array_temp[i][j]
    
    print "\n\n SWAPPED: \n"
    print "\narray_a:\n" 
    print array_a
    print "\n array_b:\n"
    print array_b

def Transpose(array, choice):

    if choice == 9 or choice == 10:
        num_col = np.size(array, 1)
        num_row = np.size(array,0)
        array_copy = [[0 for x in range(num_row)] for i in range(num_col)]
        array_copy = np.array(array_copy)
        #itr row
        for i in range(num_row):
            #itr col
            for j in range(num_col):
                array_copy[j][i] = array[i][j]
        print "\nOriginal Matrix:\n"
        print array
        print "\nTransposed Matrix:\n"
        print array_copy
        print "\n"
        return array_copy
    else: 
        num_col = np.size(array, 1)
        num_row = np.size(array,0)
        array_copy = [[0 for x in range(num_row)] for i in range(num_col)]
        array_copy = np.array(array_copy)
        #itr row
        for i in range(num_row):
            #itr col
            for j in range(num_col):
                array_copy[j][i] = array[i][j]
        return array_copy

def Inverse(array):
    #temp_array = create_list(array)
    determinant = det(array)

    num_col = np.size(array, 1)
    num_row = np.size(array,0)
    array_inverse = [[0 for x in range(num_row)] for i in range(num_col)]
    array_inverse = np.array(array_inverse, dtype = 'f' ) 
    if num_col == 2 and num_row == 2: 
        return [[array[1][1]/determinant, -1*array[0][1]/determinant], 
                [-1*array[1][0]/determinant, array[0][0]/determinant]]
    
    cofactors = []
    for r in range(len(array)):
        cofactorRow = []
        for c in range(len(array)):
            minor = getcofactor(array,r,c)
            cofactorRow.append(((-1)**(r+c)) * det(minor))
        cofactors.append(cofactorRow)
    for r in range(len(cofactors)):
        for c in range(len(cofactors)):
            cofactors[r][c] = cofactors[r][c]/determinant
    for i in range(len(cofactors)):
        for j in range(len(cofactors)):
            array_inverse[i][j] = cofactors[i][j]
    return array_inverse

def Integer_power(array): 
    user_input = input("Enter Desired Power 1-10:\n")
    try: 
        test = int(user_input) 
    except ValueError: 
        print "\nUser input is not a number/type int!\n"

    while user_input < 1 or user_input >10:
        print "\nUser input is above 10 or less than 1!\n"
        user_input = input("\nEnter Desired Power 1-10:\n")
    
    #array_copy is now the inputed array
    if user_input is 1: 
        print array
    else:
        Copy(array, 99)
    
        num_col = np.size(array, 1)
        num_row = np.size(array,0)
        array_temp = [[0 for x in range(num_row)] for i in range(num_col)]
        array_temp = np.array(array_temp)
        #itr row
        for i in range(num_row):
            #itr col
            for j in range(num_col):
                array_temp[j][i] = array[i][j]

        
        for count in user_input: 
            array_temp = multiplyAB(array_temp, array_copy, 0)    
    
        print array_temp
        return 0
def MainMenu():
    global choice
    print "                    M A T R I X    C A L C U L A T O R  (Python)   "
    print "    Unirary Operations                                        Binary Operations"
    print "  "                    
    print "1: Load matrix A: [Load A]                               17: Add A and B: [A + B]"
    print "2: Load matrix B: [Load B]                               18: Substract A from B: [B - A]"
    print "3: Square id matrix A up 10x10: [A to I]                 19: Substract B from A: [A - B]"
    print "4: Square id matrix B up to 10x10: [B to I]              20: Multiply A and B: [A * B]"
    print "5: Scalar n times matrix A: [nA, n=Int]                  21: Multiply B and A: [B * A]"
    print "6: Scalar n times matrix B: [nA, n=Int]                  22: copy A into B: [A to B]"
    print "7: Determinant of A: [det(A)]                            23: Copy B into A: [B to A]"
    print "8: Determinant of B: [det(B)]                            24: Swap A and B: [A to B]"
    print "9: A Transpose: [AT]"
    print "10: B Transpose: [BT]]"
    print "11: Inverse of A: [A-1]"
    print "12: Inverse of B: [B-1]"
    print "13: Int pwr of A, A is an square matrix: [An, 1<=n<=10]"
    print "14: Int pwr of B, B is an square matrix: [Bn, 1<=n<=10"
    print "15: Print A" 
    print "16: Print B:"                      
    print "                             ENTER 0 TO EXIT  "
    while True:
        try: 
            choice = int(input("Enter choice: "))   
            print " " 
            if choice==1:           #loads file A
                loadA("A.csv")
                
            elif choice==2:         #loads file B
                loadB("B.csv")
           
            elif a_numpy_array.all() is None or b_numpy_array.all() is None: # test flag
                    raise Load_Error
           
            elif choice==3:         # identity matrix A                
                if square(a_numpy_array,choice):
                    idmatrix(dimensions,choice)

            elif choice==4:         # identity matrix B
                if square(b_numpy_array,choice):
                    idmatrix(dimensions,choice)
                       
            elif choice==5:         # scalar n times A
                n = int(input("Enter an integer number:"))
                scalar(a_numpy_array,choice,n)    

            elif choice==6:         # scalar n times B
                n = int(input("Enter an integer number:"))
                scalar(b_numpy_array,choice,n)    
            
            elif choice==7:         #determinant A
                if square(a_numpy_array,choice):
                    array = a_numpy_array.tolist()
                    print "The determinant of A is: ",det(array)

            elif choice ==8:        #determinant B
                if square(b_numpy_array,choice):
                    array = b_numpy_array.tolist()
                    print "The determinant of B is: ",det(array)

            elif choice==9:         #transpose A
                print "Transposing A:"  
                Transpose(a_numpy_array,9)
            
            elif choice==10:        #transpose B
                print "Transposing B:"  
                Transpose(b_numpy_array,10) 
            
            elif choice==11:        #inverse A
                if square(a_numpy_array,choice):
                    array = a_numpy_array.tolist()
                    print "The Inverse of A is" , Inverse(array)
                else: 
                    print "Matrix A is not a Square Matrix:"
            
            elif choice==12:        #inverse B
                if square(b_numpy_array,choice):
                    array = b_numpy_array.tolist()
                    print "The Inverse of B is" , Inverse(array)
                else: 
                    print "Matrix B is not a Square Matrix:"
            
            elif choice==13:        #integer power A
                print "Integer Power Using Matrix A:\n"
                Integer_power(a_numpy_array)
            
            elif choice==14:        #integer power B
                print "Integer Power Using Matrix B:\n"
                Integer_power(b_numpy_array)      
                       
                       
            elif choice==15:
                print A
            
            elif choice==16:
                print B 
                       
            elif choice==17:         # addition A + B  
                if dimensions(a_numpy_array,b_numpy_array,choice):
                    sumAB(a_numpy_array,b_numpy_array)

            elif choice==18:         # substraction A - B
                if dimensions(a_numpy_array,b_numpy_array,choice):
                    subAB(a_numpy_array,b_numpy_array,choice)

            elif choice==19:         # substration B - A
                if dimensions(a_numpy_array,b_numpy_array,choice):
                    subAB(a_numpy_array,b_numpy_array,choice)
           
            elif choice==20:        # multiplication A X B
                if dimensions(a_numpy_array,b_numpy_array,choice):
                    multiplyAB(a_numpy_array,b_numpy_array,choice)

            elif choice==21:        # multiplication B X A
                if dimensions(a_numpy_array,b_numpy_array,choice):
                    multiplyAB(a_numpy_array,b_numpy_array,choice)

            elif choice==22:        #copy A into B 
                # if(Copy(a_numpy_array,choice).all() == 0):
                #    print "Error occured in copy routine\n" 

                print "Duplicating Matrix A: " , Copy(a_numpy_array, choice)

            elif choice==23:        #copy B into A
                # if(Copy(b_numpy_array,choice) == 0):
                #    print "Error occured in copy routine\n" 

                print "Duplicating Matrix B: " , Copy(b_numpy_array, choice)

            # secret combo to check the 'stored'/'3rd' matrix
            elif choice==69:
                print array_copy 

            elif choice==99: 
                print MatrixMinor(a_numpy_array, 9, 9)
            
            elif choice==24:        #swap A and B 
                print "Swapping Matrixes"
                Swap(a_numpy_array, b_numpy_array)
            
            elif choice==0:         # exit 
                break
            
            else: 
                print "Invalid choice. Enter 1-22"                 
            
        except Load_Error:
                print "Invalid choice or forgot load file A or B" 
                
#***** MAIN SCRIPT******
MainMenu() 


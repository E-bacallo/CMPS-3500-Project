#!/usr/bin/env ruby
################################
#NAME: TEAM 9 
#MEMBERS: Edgar Bacallo, Frankie Sanchez, Rodolfo Velasquez 
#PROJECT: Matrix Calculator
#ORGN: CSUB - CMPS 3500 
#FILE:  
#DATE: 5/14/2021
###############################

require 'csv'
require "matrix"

#Defining loadA method, loads file A.csv into a 2D matrix
def loadA(fileNameA)
  begin
    $arrayA = CSV.parse(File.read(fileNameA), converters: :numeric)        
    rescue StandardError
      print "file #{fileNameA} doesn't exist"
  end  
end 

#Defining loadB method, loads file B.csv into a 2D matrix
def loadB(fileNameB)         
  begin
    $arrayB = CSV.parse(File.read(fileNameB), converters: :numeric)  
    rescue StandardError 
      print "file #{fileNameB} doesn't exist"    
    end   
end 

#Definig identity matrix method 
def idmatrix(size)
  identity_array = Array.new(size){Array.new(size,0)}
  k=0
  for i in 0..size-1 do
    identity_array[k][k] = 1
    k=k+1
  end
  print_double(identity_array)
end

#Defining scalar n times a matrix method 
def scalar(array,choice,n)
  row = array.length
  col = array[0].length 
  scalar_array = Array.new(row){Array.new(col,0)}
  (0..row-1).each do |i|
    (0..col-1).each do |j|
      scalar_array[i][j] = n * array[i][j]
    end 
  end
  print " "
  if choice == '5'
    puts "matrix A"
    print_double(array)
    puts "scalar #{n} times A is:"    
  elsif choice == '6'
    puts "matrix B"
    print_double(array)
    puts "scalar #{n} times B is:"    
  end 
  print_double(scalar_array)
end 

#Defining determinant of an square matrix method
def det(array) 
  a = Marshal.load(Marshal.dump(array))
  size = a.length
  last = size - 1  
  no_pivot = Proc.new{ return 0 }
  sign = +1
  pivot = 1
  size.times do |k|
    previous_pivot = pivot
    if (pivot = a[k][k]) == 0
      switch = (k+1 ... size).find(no_pivot) {|row|
        a[row][k] != 0
      }
      a[switch], a[k] = a[k], a[switch]
      pivot = a[k][k]
      sign = -sign
    end
    (k+1).upto(last) do |i|
      ai = a[i]
      (k+1).upto(last) do |j|        
        ai[j] =  (pivot * ai[j] - ai[k] * a[k][j]) / previous_pivot
      end
    end
  end
  d = sign * pivot
  puts d
end

#Defining addition of two matrices method
def sumAB(array1,array2)
  #initilize sum_array and counters 
  row = array1.length
  col = array1[0].length
  array_sum = Array.new(row){Array.new(col,0)}
  r = 0
  c = 0
  #sumation of array A + B
  array1.each do |row|
    array2.each do |col|
      array_sum[r][c] = array1[r][c] + array2[r][c]
      c = c + 1
    end
    r = r + 1
    c = 0
  end
  puts " "
  puts "matrix A"
  print_double(array1)
  puts "matrix B"
  print_double(array2)
  puts "the addition of A + B is: "
  print_double(array_sum)
end 

#Defining substraction of two matrices method
def subAB(array1,array2,choice)
  #initilize sub_array and counters
  row = array1.length
  col = array1[0].length
  array_sub = Array.new(row){Array.new(col,0)}
  r = 0
  c = 0
  #sustraction of array B - A
  if choice == '18'
    array1.each do |row|
      array2.each do |col|
        array_sub[r][c] = array1[r][c] - array2[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end
    puts " "
    puts "matrix A"
    print_double(array1)
    puts "matrix B"
    print_double(array2)
    puts "the substraction of A - B is: "  
  elsif choice == '19'
    #sustraction of array A - B
    array2.each do |row|
      array1.each do |col|
        array_sub[r][c] = array2[r][c] - array1[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end 
    puts " "
    puts "matrix B"
    print_double(array2)
    puts "matrix A"
    print_double(array1)
    puts "the substraction of B - A is: "
  end 
  print_double(array_sub)  
end 

#Defining multiplication of two matrices method 
def multiplyAB(array1,array2,choice)   
  #initilize sub_array and counters
  row1 = array1.length
  col1 = array1[0].length
  row2 = array2.length
  col2 = array2[0].length
  if choice == '20'
    array_mul = Array.new(row1){Array.new(col2,0)} 
    c = row1.times.map { |x| [] }
    (0..row1-1).each do |i|
      (0..col2-1).each do |j|
        c[i] << 0
        (0..row2-1).each do |k|
          array_mul[i][j] += array1[i][k] * array2[k][j]                                        
        end 
      end
    end
    puts " "
    puts "matrix A"
    print_double(array1)
    puts "matrix B"
    print_double(array2)
    puts "the multiplication of A * B is:"
  end 
  if choice == '21'
    array_mul = Array.new(row2){Array.new(col1,0)}
    c = row2.times.map { |x| [] }    
    (0..row2-1).each do |i|
      (0..col1-1).each do |j|
        c[i] << 0
        (0..row1-1).each do |k|
          array_mul[i][j] += array2[i][k] * array1[k][j]
        end
      end
    end
    puts " "
    puts "matrix B"
    print_double(array2)
    puts "matrix A"
    print_double(array1)
    puts "the multiplication of B * A is:"
  end
  print_double(array_mul)
end 

#Defining square matrix method 
def square(array,choice)      
  $row = array.length
  $col = array[0].length 
  if choice == '3' || choice == '7' 
    f = 'A' 
  elsif choice == '4' || choice == '8'1 
    f = 'B'
  end 
  if $row == $col    
    puts "matrix #{f} has the same dimensions (#{$row},#{$col})"        
    print_double(array)  
    return true 
  else   
    puts "matrix #{f}"
    puts print_double(array)
    puts "can't proceed matrix #{f} does not have same dimensions (#{$row},#{$col})" 
    print " " 
    puts
  end 
end

#Defining dimensions of two matrices method
def dimensions(array1,array2,choice)  
  rows1 = array1.length
  cols1 = array1[0].length
  rows2 = array2.length
  cols2 = array2[0].length
  if choice == '17' || choice == '18' || choice == '19'
    if rows1 == rows2 and cols1 == cols2
      puts "matrices A B are of the same dimensions"
      return true
    else
      puts "can't proceed matrices A and B are not of the same dimensions"
      return false
    end
  elsif choice == '20'
    if cols1 == rows2
      puts "matrices A and B can be multiplied" 
      return true
    else
      puts "matrices A and B can't be multiplied"
      puts "A's columns must equal B's rows"
      return false
    end 
  elsif choice == '21'
    if cols2 == rows1
      puts cols2
      puts rows1
      puts "matrices B and A can be multiplied"
      return true
    else
      puts "matrices B and A can't be multiplied"
      puts "B's columns must equal A's rows"
      return false
    end 
  end 
end 

#Defining print out to screen method
def print_double(array)
  width = array.flatten.max.to_s.size + 2
  puts puts array.map { |a| a.map { |i| i.to_s.rjust(width)}.join}
  print " " 
end 

#Defining MainMenu, interactive matrix calculator's main menu  
def MainMenu()
  while 1
    puts "
                       M A T R I X  C A L C U L A T O R  (Ruby) 
    Uninary Operations                                           Binary Operations

 1: Load matrix A: [Load A]                               17: Add A and B: [A + B]
 2: Load matrix B: [Load B]                               18: Substract A from B: [B - A]
 3: Square id matrix A up 10x10: [A to I]                 19: Substract B from A: [A - B]
 4: Square id matrix B up to 10x10: [B to I]              20: Multiply A and B: [A * B]
 5: Scalar n times matrix A: [nA, n=Int]                  21: Multiply B and A: [B * A]
 6: Scalar n times matrix B: [nA, n=Int]                  22: copy A into B: [A to B]
 7: Determinant of A: [det(A)]                            23: Copy B into A: [B to A]
 8: Determinant of B: [det(B)]                            24: Swap A and B: [A to B]
 9: A Transpose: [AT]                                        
10: B Transpose: [BT]]                                
11: Inverse of A: [A-1] 
12: Inverse of B: [B-1]
13: Int pwr of A, A is an square matrix: [An, 1<=n<=10]
14: Int pwr of B, B is an square matrix: [Bn, 1<=n<=10
15: Print A
16: Print B
             "
     puts "Input 0 to EXIT. Enter choice:" 
     choice = gets.chomp
     puts " " 
     begin
       case choice 
          when '1'       #load file A
          puts "enter file A: "
          fileNameA = gets.chomp
          if loadA(fileNameA)
            puts "file #{fileNameA} loaded successfully"
          end
          when '2'       #load file B
          puts "enter file B: "
          fileNameB = gets.chomp
          if loadB(fileNameB)
            puts "file #{fileNameB} loaded successfully"
          end      
          when '3'       # identity matrx file A                          
             if square($arrayA,choice)
               puts "the identity matrix of A is:"
               idmatrix($row)                            
             end                      
           when '4' # identity matrx file B          
             if square($arrayB,choice)
               puts "the identity matrix of B is:"
               idmatrix($row)
             end 
           when 5       # scalar n times file A
             puts "enter a integer number "
             n = gets.chomp.to_i
             scalar($arrayA,choice,n)
           when '6'       # scalar n times file A
             puts "enter a integer number "
             n = gets.chomp.to_i
             scalar($arrayB,choice,n)
           when '7'       # determinant of matrix A     
             if square($arrayA,choice)
               puts "The determinant of A is: "
               det($arrayA)           
             end 
           when '8'       # determinant of matrix B
             if square($arrayB,choice)
               puts "The determinant of B is: "
               det($arrayB)
             end 
           when '9'
             puts "Insert function call here"
         
           when '10'
              puts "Insert function call here"

           when '11'
              puts "Insert function call here"

           when '12'
              puts "Insert function call here"

           when '13'
              puts "Insert function call here"

           when '14'
              puts "Insert function call here"

           when '15'     # screen output matrix A   
             puts "matrix A"
             print_double($arrayA)
  
           when '16'       # screen output matrx B
             puts "matrix B"
             print_double($arrayB)

           when '17'       # addition matrices A + B
             if dimensions($arrayA,$arrayB,choice)
               sumAB($arrayA,$arrayB)
             end 
           when '18'       # substraction matrices B - A 
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end 

           when '19'        # matrices substraction A - B
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end 

           when '20'         # matrices multiplication A * B
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
             end 

           when '21'         # matrices multiplication B * A
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
             end 

           when '22'
              puts "Insert function call here"   
   
           when '23'                      
              puts "Insert function call here"
   
           when '24'
             puts "Insert function call here"

           when '0'
             break        

           else              
             puts "Invalid selection.Enter 1-24 or 0 to EXIT"                      
         
           end 
     rescue ArgumentError
       puts "can't be processed it contains invalid entries or non-numeric values"
     
     rescue NoMethodError
       puts "Error: Please, load matrix or matrices"    
     end 
  end 
end 

#*******Main Script*********
MainMenu()


=======
#!/usr/bin/env ruby
################################
#NAME: TEAM 9 
#MEMBERS: Edgar Bacallo, Frankie Sanchez, Rodolfo Velasquez 
#PROJECT: Matrix Calculator
#ORGN: CSUB - CMPS 3500 
#FILE:  
#DATE: 5/14/2021
###############################

require 'csv'
require "matrix"

#Defining loadA method, loads file A.csv into a 2D matrix
def loadA()
  begin
    $arrayA = CSV.parse(File.read("A.csv"), converters: :numeric)     
    puts "file 'A.csv' loaded successfully"
    print_double($arrayA)
    rescue StandardError
      print "file 'A.csv' doesn't exist or it contains non-numeric values"
  end  
end 

#Defining loadB method, loads file B.csv into a 2D matrix
def loadB()         
  begin
    $arrayB = CSV.parse(File.read("B.csv"), converters: :numeric)
    puts "file 'B.csv' loaded successfully"  
    print_double($arrayB) 
    rescue StandardError 
      print "file 'B.csv' doesn't exist or it contains non-numeric values"
    end  
end 

#Definig identity matrix method 
def idmatrix(size)
  identity_array = Array.new(size){Array.new(size,0)}
  k=0
  for i in 0..size-1 do
    identity_array[k][k] = 1
    k=k+1
  end
  print_double(identity_array)
end


#Defining scalar n times a matrix method 
def scalar(array,choice,n)
  row = array.length
  col = array[0].length 
  scalar_array = Array.new(row){Array.new(col,0)}
  (0..row-1).each do |i|
    (0..col-1).each do |j|
      scalar_array[i][j] = n * array[i][j]
    end 
  end
  print " "
  if choice == 5
    puts "matrix A"
    print_double(array)
    puts "scalar #{n} times A is:"    
  elsif choice == 6
    puts "matrix B"
    print_double(array)
    puts "scalar #{n} times B is:"    
  end 
  print_double(scalar_array)
end 

#Defining determinant of an square matrix method
def det(array) 
  a = Marshal.load(Marshal.dump(array))
  size = a.length
  last = size - 1
  #a = to_a 
  no_pivot = Proc.new{ return 0 }
  sign = +1
  pivot = 1
  size.times do |k|
    previous_pivot = pivot
    if (pivot = a[k][k]) == 0
      switch = (k+1 ... size).find(no_pivot) {|row|
        a[row][k] != 0
      }
      a[switch], a[k] = a[k], a[switch]
      pivot = a[k][k]
      sign = -sign
    end
    (k+1).upto(last) do |i|
      ai = a[i]
      (k+1).upto(last) do |j|        
        ai[j] =  (pivot * ai[j] - ai[k] * a[k][j]) / previous_pivot
      end
    end
  end
  d = sign * pivot
  puts d
end

#Defining addition of two matrices method

def sumAB(array1,array2)
  #initilize sum_array and counters 
  row = array1.length
  col = array1[0].length
  array_sum = Array.new(row){Array.new(col,0)}
  r = 0
  c = 0
  #sumation of array A + B
  array1.each do |row|
    array2.each do |col|
      array_sum[r][c] = array1[r][c] + array2[r][c]
      c = c + 1
    end
    r = r + 1
    c = 0
  end
  puts " "
  puts "matrix A"
  print_double(array1)
  puts "matrix B"
  print_double(array2)
  puts "the addition of A + B is: "
  print_double(array_sum)
end 

#Defining substraction of two matrices method
def subAB(array1,array2,choice)
  #initilize sub_array and counters
  row = array1.length
  col = array1[0].length
  array_sub = Array.new(row){Array.new(col,0)}
  r = 0
  c = 0
  #sustraction of array B - A
  if choice == 18
    array1.each do |row|
      array2.each do |col|
        array_sub[r][c] = array1[r][c] - array2[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end
    puts " "
    puts "matrix A"
    print_double(array1)
    puts "matrix B"
    print_double(array2)
    puts "the substraction of A - B is: "  
  elsif choice == 19
    #sustraction of array A - B
    array2.each do |row|
      array1.each do |col|
        array_sub[r][c] = array2[r][c] - array1[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end 
    puts " "
    puts "matrix B"
    print_double(array2)
    puts "matrix A"
    print_double(array1)
    puts "the substraction of B - A is: "
  end 
  print_double(array_sub)  
end 

#Defining multiplication of two matrices method 
def multiplyAB(array1,array2,choice)   
  #initilize sub_array and counters
  row1 = array1.length
  col1 = array1[0].length
  row2 = array2.length
  col2 = array2[0].length
  if choice == 20
    array_mul = Array.new(row1){Array.new(col2,0)} 
    c = row1.times.map { |x| [] }
    (0..row1-1).each do |i|
      (0..col2-1).each do |j|
        c[i] << 0
        (0..row2-1).each do |k|
          array_mul[i][j] += array1[i][k] * array2[k][j]                                        
        end 
      end
    end
    puts " "
    puts "matrix A"
    print_double(array1)
    puts "matrix B"
    print_double(array2)
    puts "the multiplication of A * B is:"
  end 
  if choice == 21
    array_mul = Array.new(row2){Array.new(col1,0)}
    c = row2.times.map { |x| [] }    
    (0..row2-1).each do |i|
      (0..col1-1).each do |j|
        c[i] << 0
        (0..row1-1).each do |k|
          array_mul[i][j] += array2[i][k] * array1[k][j]
        end
      end
    end
    puts " "
    puts "matrix B"
    print_double(array2)
    puts "matrix A"
    print_double(array1)
    puts "the multiplication of B * A is:"
  end
  print_double(array_mul)
end 

#Defining square matrix method 
def square(array,choice)      
  $row = array.length
  $col = array[0].length 
  if choice == 3 || choice == 7 
    f = 'A' 
  elsif choice == 4 || choice == 8 
    f = 'B'
  end 
  if $row == $col    
    puts "matrix #{f} has the same dimensions (#{$row},#{$col})"        
    print_double(array)  
    return true 
  else   
    puts "matrix #{f}"
    puts print_double(array)
    puts "can't proceed matrix #{f} does not have same dimensions (#{$row},#{$col})" 
    print " " 
    puts
  end 
end

#Defining dimensions of two matrices method

def dimensions(array1,array2,choice)  
  rows1 = array1.length
  cols1 = array1[0].length
  rows2 = array2.length
  cols2 = array2[0].length
  if choice == 17 || choice == 18 || choice == 19
    if rows1 == rows2 and cols1 == cols2
      puts "matrices A B are of the same dimensions"
      return true
    else
      puts "can't proceed matrices A and B are not of the same dimensions"
      return false
    end
  elsif choice == 20
    if cols1 == rows2
      puts "matrices A and B can be multiplied" 
      return true
    else
      puts "matrices A and B can't be multiplied"
      puts "A's columns must equal B's rows"
      return false
    end 
  elsif choice == 21
    if cols2 == rows1
      puts cols2
      puts rows1
      puts "matrices B and A can be multiplied"
      return true
    else
      puts "matrices B and A can't be multiplied"
      puts "B's columns must equal A's rows"
      return false
    end 
  end 
end 

def copy(cop_array,tar_array, choice)
  cop_rows = cop_array.length
  cop_cols =  cop_array[0].length 
  if choice == 1
  print "Original Arrays:\n", "\n 1st Array:\n"
  print_double(cop_array)
  print "\n 2nd Array:\n" 
  print_double(tar_array) 
  end
  (0..cop_rows-1).each do |i|
    (0..cop_cols-1).each do |j|
      tar_array[i][j] = cop_array[i][j]
    end
  end
  if choice == 1
  print "\nCopied Array:\n"
  print_double(tar_array)
  end
end

def swap(arrayA, arrayB)
  a_rows = arrayA.length
  a_cols =  arrayA[0].length 
  b_rows = arrayB.length
  b_cols = arrayB[0].length
  temp_array = Array.new(a_rows){Array.new(a_cols,0)}
  print "Original Arrays:\n", "\n 1st Array:\n"
  print_double(arrayA)
  print "\n 2nd Array:\n" 
  print_double(arrayB) 
  (0..a_rows-1).each do |i|
    (0..a_cols-1).each do |j|
      temp_array[i][j] = arrayA[i][j]
    end
  end
  arrayA = Array.new(b_rows){Array.new(b_cols,0)}
  (0..b_rows-1).each do |i|
    (0..b_cols-1).each do |j|
      arrayA[i][j] = arrayB[i][j]
    end
  end
  arrayB = Array.new(a_rows){Array.new(a_cols,0)}
  (0..a_rows-1).each do |i|
    (0..b_cols-1).each do |j|
      arrayB[i][j] = temp_array[i][j]
    end
  end
  print "\nSwapped Array:\n 1st Array:\n"
  print_double(arrayA)
  print "2nd Array:\n" 
  print_double(arrayB) 
end

def transpose(array)
  rows = array.length
  cols =  array[0].length 
  print "Original Array:\n"
  print_double(array)
  temp_array = Array.new(rows){Array.new(cols,0)}
  (0..rows-1).each do |i|
    (0..cols-1).each do |j|
      temp_array[i][j] = array[i][j]
    end
  end
  (0..rows-1).each do |i|
    (0..cols-1).each do |j|
      array[j][i] = temp_array[i][j]
    end
  end    
  print "\nTranspose Array:\n"
  print_double(array)
end

def interger_power(array, num) 
  rows = array.length
  cols = array[0].length 
  array_power = Array.new(rows){Array.new(cols,0)} 
  array_temp = Array.new(rows){Array.new(cols,0)}
  #filling array_power with elements from the input array
  copy(array, array_temp, 0) 
  copy(array, array_power, 0) 
  if num == 2
    (0..rows-1).each do |i|
      (0..cols-1).each do |j|
        (0..rows-1).each do |k|
          array_power[i][j] += array[i][k] * array_temp[k][j]                                        
        end 
      end
   end  
    print_double(array_power) 
  else
  (0..num-1).each do 
   copy(array_power, array_temp, 0) 
    (0..rows-1).each do |i|
     (0..cols-1).each do |j| 
       (0..rows-1).each do |k|
       array_power[i][j] = array[i][k] * array_temp[k][j]
      end
    end
   end
  end
  print "\nInteger Power Array to Power:" , num , ":\n"
  print_double(array_power)  
  end
end

def inverse(array)
  det_num = det(array, 0)
  rows = array.length
  cols = array[0].length
  array_inverse = Array.new(rows){Array.new(cols,0)}
  array_cofactors = Array.new(rows){Array.new(cols,0)}
  if rows == 2 and cols == 2 
    return [[array[1][1]/det_num , -1*array[0][1]/det_num],
            [-1*array[1][0]/det_num, array[0][0]/det_num]]
  else 
    a = Marshal.load(Marshal.dump(array))
    size = a.length
    last = size - 1
    no_pivot = Proc.new{ return 0 }
    pivot = 1
    size.times do |k|
      previous_pivot = pivot
      if (pivot = a[k][k]) == 0
        switch = (k+1 ... size).find(no_pivot) {|row|
          a[row][k] != 0
        }
        a[switch], a[k] = a[k], a[switch]
        pivot = a[k][k]
      end
      (k+1).upto(last) do |i|
        ai = a[i]
        (k+1).upto(last) do |j|
          ai[j] = (pivot * ai[j] - ai[k] * a[k][j]) / previous_pivot
        end
      end
    end
  end
  # array_inverse = array_inverse.flatten.collect{|arr| arr.tap{|v| v.to_f}}
  (0..rows-1).each do |i|
    (0..cols-1).each do |j|
      array_inverse[i][j] = a[i][j] / det_num
    end
  end
  puts "Determinent" 
  puts det_num
  puts " cofactors" 
  print_double(a) 
  puts "inverse:\n"
  print_double(array_inverse)
  puts " test:" 
  puts "a[0][0]: ", a[0][0], " / det_num: ", det_num 
  puts a[0][0] / det_num
  #puts "a:\n"
  #print_double(a)
end

#Defining print out to screen method
def print_double(array)
  width = array.flatten.max.to_s.size + 2
  puts puts array.map { |a| a.map { |i| i.to_s.rjust(width)}.join}
  print " " 
end 

#Defining MainMenu, interactive matrix calculator's main menu  
def MainMenu()
  while 1
    puts "
                       M A T R I X  C A L C U L A T O R  (Ruby) 
    Uninary Operations                                           Binary Operations

 1: Load matrix A: [Load A]                               17: Add A and B: [A + B]
 2: Load matrix B: [Load B]                               18: Substract A from B: [B - A]
 3: Square id matrix A up 10x10: [A to I]                 19: Substract B from A: [A - B]
 4: Square id matrix B up to 10x10: [B to I]              20: Multiply A and B: [A * B]
 5: Scalar n times matrix A: [nA, n=Int]                  21: Multiply B and A: [B * A]
 6: Scalar n times matrix B: [nA, n=Int]                  22: copy A into B: [A to B]
 7: Determinant of A: [det(A)]                            23: Copy B into A: [B to A]
 8: Determinant of B: [det(B)]                            24: Swap A and B: [A to B]
 9: A Transpose: [AT]                                        
10: B Transpose: [BT]]                                
11: Inverse of A: [A-1] 
12: Inverse of B: [B-1]
13: Int pwr of A, A is an square matrix: [An, 1<=n<=10]
14: Int pwr of B, B is an square matrix: [Bn, 1<=n<=10
15: Print A
16: Print B
             "
     puts "Input 0 to EXIT. Enter choice:" 
     choice = gets.chomp.to_i
     puts " " 
     begin
       case choice
           when 1       #load file A             
             loadA() 
         
           when 2       #load file B      
             loadB() 
         
           when 3       # identity matrx file A                          
             if square($arrayA,choice)
               puts "the identity matrix of A is:"
               idmatrix($row)                            
             end     
         
           when 4 # identity matrx file B          
             if square($arrayB,choice)
               puts "the identity matrix of B is:"
               idmatrix($row)
             end
         
           when 5       # scalar n times file A
             puts "enter a integer number "
             n = gets.chomp.to_i
             scalar($arrayA,choice,n)
         
           when 6       # scalar n times file A
             puts "enter a integer number "
             n = gets.chomp.to_i
             scalar($arrayB,choice,n)

           when 7       # determinant of matrix A     
             if square($arrayA,choice)
               puts "The determinant of A is: "
               det($arrayA)           
             end 
         
           when 8       # determinant of matrix B
             if square($arrayB,choice)
               puts "The determinant of B is: "
               det($arrayB)
             end 
         
           when 9
             puts "A Transpose:\n"
             transpose($arrayA)

           when 10
              puts "B Transpose:\n"
              transpose($arrayB)

           when 11
             puts "Matrix A Inverse: "
             inverse($arrayA) 

           when 12
             puts "Matrix B Inverse:"
             inverse($arrayB) 

           when 13 
             puts "What power for A^n do you request from 1 - 10"
             num = gets.chomp.to_i
             while num < 1 || num > 10 
               puts "Invalid input for num! Must be 1 - 10!: " 
               num = gets.chomp.to_i
             end
             interger_power($arrayA, num) 

           when 14
             puts "What power for B^n do you request from 1 - 10"
             num = gets.chomp.to_i
             while num < 1 || num > 10 
               puts "Invalid input for num! Must be 1 - 10!: " 
               num = gets.chomp.to_i
             end
             interger_power($arrayB, num)

           when 15      # screen output matrix A   
             puts "matrix A"
             print_double($arrayA)
  
           when 16       # screen output matrx B
             puts "matrix B"
             print_double($arrayB)

           when 17       # addition matrices A + B
             if dimensions($arrayA,$arrayB,choice)
               sumAB($arrayA,$arrayB)
             end 
         
           when 18       # substraction matrices B - A 
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end  
         
           when 19        # matrices substraction A - B
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end 

           when 20         # matrices multiplication A * B
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
             end 

           when 21         # matrices multiplication B * A
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
             end 

           when 22
              puts "Copying A into B: A to B"   
              copy($arrayA, $arrayB, 1) 
         
           when 23                      
              puts "Copying B into A: B to A"
              copy($arrayB, $arrayA, 1) 
   
           when 24
             puts "Swapping A and B: "
             swap($arrayA, $arrayB) 
         
           when 0 
             break        

           else              
             puts "Invalid selection.Enter 1-22 0 to exit"                      
             MainMenu()
           end 
     rescue => e 
       puts "An error of type: #{e.class} happened"
       puts "The message is: #{e.message}. Backtrace:\n#{e.backtrace.join("\n")}"       
     end 
  end 
end 

#*******Main Script*********
MainMenu()

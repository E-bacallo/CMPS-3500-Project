#!/usr/bin/env ruby
################################
#NAME:  
#ASGT: Project Calculator
#ORGN: CSU - CMPS 3500 
#FILE: project.rb 
#DATE: 
###############################
#

require 'csv'
require 'matrix'

#Defining loadA method, loads file A.csv into a 2D matrix
def loadA()
  begin
    $arrayA = CSV.parse(File.read("A.csv"), converters: :numeric)     
    puts "file 'A' loaded into arrayA"
    print_double($arrayA)
    rescue StandardError
      print "file 'A' doesn't exist or it contains non-numeric values"
  end
  puts " "
end 

#Defining loadB method, loads file B.csv into a 2D matrix
def loadB()         
  begin
    $arrayB = CSV.parse(File.read("B.csv"), converters: :numeric)
    puts "file 'B' loaded into arrayB"  
    print_double($arrayB) 
    rescue StandardError 
      print "file 'B' doesn't exist or it contains non-numeric values"
    end 
  puts " "
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
    puts "file A"
    print_double(array)
    puts "scalar #{n} times A is:"    
  elsif choice == 6
    puts "file B"
    print_double(array)
    puts "scalar #{n} times B is:"    
  end 
  print_double(scalar_array)
end 

=begin
def det(array)
  #if given matrix is of order 2*2 then simply return det
  #value by cross multiplying elements of matrix.

  if(len(array) == 2)
    value = array[0][0] * array[1][1] - array[1][0] * array[0][1]
    return value

  #initialize Sum to zero
  Sum = 0

  #loop to traverse each column of matrix a.
  for current_column in range(len(array))
    #calculating the sign corresponding to co-factor of that sub matrix.
    sign = (-1) ** (current_column)

    #calling the function recursily to get determinant value of
    #sub matrix obtained.
    
    sub_det = det(getcofactor(array, 0, current_column))
    #adding the calculated determinant value of particular column
    #matrix to total Sum.

    if sub_det == None
    sub_det = 0
    Sum += (sign * array[0][current_column] * sub_det)

    #returning the final Sum

    return Sum

def getcofactor(m, i, j)i
  return [row[: j] + row[j+1:] for row in (m[: i] + m[i+1:])]
=end 

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
  puts "file A"
  print_double(array1)
  puts "file B"
  print_double(array2)
  puts "the addition of A + B is: "
  print_double(array_sum)
end 

def subAB(array1,array2,choice)
  #initilize sub_array and counters
  row = array1.length
  col = array1[0].length
  array_sub = Array.new(row){Array.new(col,0)}
  r = 0
  c = 0
  #sustraction of array B - A
  if choice == 16
    array1.each do |row|
      array2.each do |col|
        array_sub[r][c] = array2[r][c] - array1[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end
    puts " "
    puts "file A"
    print_double(array1)
    puts "file B"
    print_double(array2)
    puts "the substraction of A - B is: "  
  elsif choice == 17
    #sustraction of array A - B
    array2.each do |row|
      array1.each do |col|
        array_sub[r][c] = array1[r][c] - array2[r][c]
        c = c + 1
      end
      r = r + 1
      c = 0
    end 
    puts " "
    puts "file B"
    print_double(array2)
    puts "file A"
    print_double(array1)
    puts "the substraction of B - A is: "
  end 
  print_double(array_sub)  
end 

def multiplyAB(array1,array2,choice)   
  #initilize sub_array and counters
  row1 = array1.length
  col1 = array1[0].length
  row2 = array2.length
  col2 = array2[0].length
  puts row1
  puts col1
  puts row2
  puts col2

  if choice == 18
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
    puts "file A"
    print_double(array1)
    puts "file B"
    print_double(array2)
    puts "the multiplication of A * B is:"
  end 
  if choice == 19 
    array_mul = Array.new(row2){Array.new(col1,0)}
    c = row2.times.map { |x| [] }
    (0..row2-1).each do |i|
      (0..col1-1).each do |j|
        c[i] << 0
        (0..row1-1).each do |k|
          array_mul[i][j] += array1[i][k] * array2[k][j]
        end
      end
    end
    puts " "
    puts "file B"
    print_double(array2)
    puts "file A"
    print_double(array1)
    puts "the multiplication of B * A is:"
  end
  print_double(array_mul)
end 

#Defining square matrix method 
def square(array,option)      
  $row = array.length
  $col = array[0].length 
  if $row == $col    
    puts "file has the same dimensions"        
    print_double(array)  
    return true 
  else   
    puts "can't proceed file does not have same dimensions"     
  end 
end

#Defining dimensions of matrices method
def dimensions(array1,array2,choice)  
  rows1 = array1.length
  cols1 = array1[0].length
  rows2 = array2.length
  cols2 = array2[0].length
  if choice == 15 || choice == 16 || choice == 17
    if rows1 == rows2 and cols1 == cols2
      puts "matrices A B are of the same dimensions"
      return true
    else
      puts "can't proceed matrices A and B are not of the same dimensions"
      return false
    end
  elsif choice == 18 
    if cols1 == rows2
      puts "matrices A B can be multiplied" 
      return true
    else
      puts "matrices A B can't be multiplied"
      puts "B's columns must equal A's rows"
      return false
    end 
  elsif choice == 19
    if cols2 == rows1
      puts "matrices B A can be multiplied"
      return true
    else
      puts "matrices B A can't be multiplied"
      puts "A's columns must equal B's rows"
      return false
    end 
  end 
end 

def print_double(array)
  width = array.flatten.max.to_s.size + 2
  puts puts array.map { |a| a.map { |i| i.to_s.rjust(width)}.join}
end 

#Defining MainMenu, interactive matrix calculator's main menu  
def MainMenu()
  while 1
    puts " "
     puts "What would you like to do?
     1: Load matrix A: Load A
     2: Load matrix A: Load B
     3: Make A and square indentity matrix up to oder 10x10: A to I
     4: Make A and square indentity matrix up to oder 10x10: A to I
     5: Scalar n times A: nA where n is an integer
     6: Scalar n times B: nA where n is an integer
     7: Determinant of A: det(A)
     8: Determinant of B: det(B)
     9: A Transpose: AT
     10: B Transpose: BT
     11: Inverse of A: A-1
     12: Inverse of B: B-1
     13: Integer power of A when A is an sqaure matrix: An for 1  n  10
     14: Integer power of B when B is an sqaure matrix: Bn for 1  n  10
     15: Add A and B: A + B
     16: Substract A from B: B - A
     17: Substract B from A: A - B
     18: Multiply A and B: AB
     19: Multiply B and A: BA
     20: copy A into B: A to B
     21: copy B into A: B to A
     22: Swap A and B: A to B"  
     puts "Enter choice: "
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
             if square($arrayB,choice) == true 
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

           when 7            
             #if dimensions($arrayA,choice)
              # array = $arrayA.tolist()
               #puts "The determinant of A is: ",det(array)             

           when 8
             #if dimensions($arrayB,choice)
              # array = $arrayB.tolist()
               #puts "The determinant of B is: ",det(array)

           when 9
             puts "Insert function call here"

           when 10
              puts "Insert function call here"

           when 11
              puts "Insert function call here"

           when 12
              puts "Insert function call here"

           when 13
              puts "Insert function call here"

           when 14
              puts "Insert function call here"

           when 15
             if dimensions($arrayA,$arrayB,choice)
               sumAB($arrayA,$arrayB)
             end 
           when 16
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end 

           when 17
             if dimensions($arrayA,$arrayB,choice)
               subAB($arrayA,$arrayB,choice)
             end 

           when 18
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
              end 

           when 19
             if dimensions($arrayA,$arrayB,choice)
               multiplyAB($arrayA,$arrayB,choice)
             end 

           when 20
              puts "Insert function call here"   
   
           when 21                      
              puts "Insert function call here"
   
           when 22
             puts "Insert function call here"

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



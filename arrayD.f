C********************************************************************
C NAME: Stundent
C ASGT: Activity 2
C ORGN: CSUB - CMPS 3500
C FILE: arrayD.f
C DATE: 02/25/2021
C NAME: Edgar Bacallo
C CMPS 3500
C********************************************************************
C Stores User input into an array
C DEFINE VARIABLE NAMES:
C     array: stores user input into an array
C     i: counter
C     
C ********************************************************************
C
      REAL, dimension(5) :: array
      INTEGER i 
C
C ASK USER FOR A RADIUS, R:
      WRITE(6,*) ' Maximum elements for the array is 5 '
C LOOP FOR INPUT
      DO i = 1, 5
      WRITE(6,*) ' INPUT A VALUE FOR THE ELEMENTS, ARRAY NOW:'
      READ (5,*) array(i)
      END DO

C CALCULATIONS:
      WRITE(6,*)  ' ========================================'
      WRITE(6,*)  ' ELEMENTS IN ARRAY:'
C PRINT LOOP:
      DO i = 1, 5 
      WRITE(6,*)  array(i)
      END DO 
C
      END

C********************************************************************
C NAME: Edgar Bacallo
C ASGT: Activity 2
C ORGN: CSUB - CMPS 3500
C FILE: circleinputB.f
C DATE: 02/25/2021
C********************************************************************
C THIS PROGRAM CALCULATES THE CIRCUMFERENCE AND AREA OF A CIRCLE WITH
C RADIUS R.
C DEFINE VARIABLE NAMES:
C     R: RADIUS OF CIRCLE
C     PI: VALUE OF PI=3.14159
C     CIRCUM: CIRCUMFERENCE = 2*PI*R
C     AREA: AREA OF THE CIRCLE = PI*R*R
C ********************************************************************
C
      REAL R,CIRCUM,AREA
C
      PI = 3.14159
C
C ASK USER FOR A RADIUS, R:
 100  WRITE(6,*) ' INPUT A VALUE FOR THE RADIUS, R NOW'
      READ (5,*) R
C
C CALCULATIONS:
      CIRCUM = 2.*PI*R
      AREA = PI*R*R
C
C WRITE RESULTS:
      WRITE(6,*)  '  FOR A CIRCLE OF RADIUS', R,
     +            '  THE CIRCUMFERENCE IS', CIRCUM,
     +            '  AND THE AREA IS ', AREA
C
      GO TO 100
C
      END  

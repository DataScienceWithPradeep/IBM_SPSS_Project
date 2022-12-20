* Encoding: UTF-8.
* Introduction to SPSS software
* This is how write a comment in SPSS
*setting working directory

 cd "‪C:\Users\ilove\Desktop\SPSS files".
GET
  FILE='C:\Users\ilove\Desktop\HLTH1025_2016.sav'.
DATASET NAME HLTH1025_Practice window=FRONT.

SAVE
     OUTFILE= "HLTH1025_Practice"/COMPRESSED
 

* Inspection of data. 1. cookbook, 2. display, 3. Dictionary


DATASET ACTIVATE HLTH1025_Practice.
CODEBOOK  IDnumber [s] age [s] sex [n] workstat [n] increg [n] incmnth [s] incwk [s] housing [n] 
    living [n] homepay [n] homecost [s] homecostwk [s] mobile [n] mobilepay [n] mobilecost [s] 
    mobilecostwk [s] transport [s] food [s] entertain [s] privhlth [n] fs_illness [n] fs_accident [n] 
    fs_death [n] fs_mtlillness [n] fs_disability [n] fs_divsep [n] fs_nogetjob [n] fs_lossofjob [n] 
    fs_alcdrug [n] fs_witviol [n] fs_absvcrim [n] fs_police [n] fs_gambling [n] famstress [n] drivelic 
    [n] mvacc [n] mvaccinj [n] smokeyn [n] smokereg [n] smokestat [n] suffact [n] veg [s] fruit [s] 
    medication [n] sf1 [n] height [s] weight [s] asthma [n] cancer [n] cvcondition [n] arthritis [n] 
    osteop [n] diabetes [n] mtlstress [n] anxiety [n] depress [n] mtlother [n] mntlcond [n] mntlcurr [n]    
  /VARINFO POSITION LABEL TYPE FORMAT MEASURE ROLE VALUELABELS MISSING ATTRIBUTES
  /OPTIONS VARORDER=VARLIST SORT=ASCENDING MAXCATS=200
  /STATISTICS COUNT PERCENT MEAN STDDEV QUARTILES.

DISPLAY DICTIONARY.

VARIABLE LABELS sex Sex of respondent.

VALUE LABELS sex 1 'Male' 2 'female'.

*shorting data in assending and desending order

 SORT CASES by sex(A).
 
SORT CASES by sex (D).

*Merging File

 GET
  FILE = "C:\Users\ilove\Desktop\HLTH1025-2016-yr.sav".
 DATASET NAME Data_merg_yr WINDOW=FRONT.
 
DATASET ACTIVATE HLTH1025_Practice.
SORT CASES by IDnumber(A).
 
DATASET ACTIVATE Data_merg_yr.
SORT CASES by IDnumber(A).

DATASET ACTIVATE HLTH1025_Practice.

*Describe the data

FREQUENCIES smo
Descr

DATASET ACTIVATE HLTH1025_Practice.
CROSSTABS
  /TABLES=sex BY smokestat
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=sex BY smokestat
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

EXAMINE VARIABLES=age BY smokestat
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

DATASET ACTIVATE HLTH1025_Practice.


DATASET ACTIVATE HLTH1025_Practice.
CORRELATIONS
  /VARIABLES=sex age
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

STATS REGRESS PLOT YVARS=age XVARS=smokestat 
/OPTIONS CATEGORICAL=LINES GROUP=1 BOXPLOTS INDENT=15 YSCALE=75 
/FITLINES LINEAR APPLYTO=TOTAL.

*Modify Data

COMPUTE height = height/100.
EXECUTE.

COMPUTE bmi = weight/height**2.
EXECUTE.

*Recode

Recode bmi (SYSMIS = SYSMIS)
(LOWEST THRU 18.499999=1) (18.5 THRU 24.99999 = 2) (25.0 thru 29.99999 = 3) (30 thru HIGHEST = 4) into bmicat.
EXECUTE.


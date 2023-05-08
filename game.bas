10 GOSUB 1000 : ' Init
15 GOSUB 6000 : ' Menu display
30 WHILE quit = 0
40   GOSUB 3000 : ' Game loop
50 WEND
60 GOSUB 7000 ' End display
65 CLS
70 END



1000 ' Init
1010 MODE 1
1020 quit = 0
1025 score = 0
1026 apples = 0
1027 level = 0
1028 finalLevel = 2
1030 x=20 : y=12
1040 DIM map(40, 24)
1050 SYMBOL AFTER 200
1060 SYMBOL 240, &X100, &X1000, &X111100, &X1111110, &X11111111, &X11111111, &X1111110, &X111100
1065 ' Display config
1070 BORDER 0
1080 INK 0,  0 :  ' Black background
1090 INK 1, 22 :  ' Green walls
1100 INK 2,  6 :  ' Red apples
1110 INK 3, 26 :  ' White player
1200 RETURN


2000 '
2010 ' Set read values and map printing
2015 CLS
2020 FOR column=1 TO 24
2030   FOR row=1 TO 40
2040     READ map(row, column)
2050     IF map(row, column) = 1 THEN LOCATE row, column : PEN 1 : PRINT CHR$(207);
2060     IF map(row, column) = 2 THEN LOCATE row, column : PEN 2 : PRINT CHR$(240);
2070   NEXT row
2080 NEXT column
2100 RETURN


3000 '
3010 ' Game loop
3020 IF apples = 0 THEN GOSUB 5000 : ' Next level
3030 LOCATE x, y : PEN 3 : PRINT CHR$(248)
3040 IF INKEY(69) <> -1 OR JOY(0) = 4 THEN LOCATE x, y: PRINT " " : x=x-1
3050 IF INKEY(61) <> -1 OR JOY(0) = 8 THEN LOCATE x, y: PRINT " " : x=x+1
3060 IF INKEY(59) <> -1 OR JOY(0) = 1 THEN LOCATE x, y: PRINT " " : y=y-1
3070 IF INKEY(60) <> -1 OR JOY(0) = 2 THEN LOCATE x, y: PRINT " " : y=y+1
3080 IF INKEY(67) <> -1 THEN quit = 1 : GOSUB 4200 : ' Extra success sound / Crash  ' Q -> Quit
3090 IF map(x, y) = 1 THEN quit = 1  : GOSUB 4200 : ' Extra success sound / Crash
3100 IF map(x, y) = 2 THEN map(x, y) = 0 : score = score + 10 : apples = apples - 1 : LOCATE 1, 25 : PRINT "Score: "; score; : GOSUB 4000 : ' Success sound
3980 RETURN


3999 '
4000 ' Success sound
4020 ' Note values: C=1, D=2, E=3, F=4, G=5, A=6, B=7
4050 FOR I=3 TO 5
4070   SOUND 1, 30 + 20 * i, 5, 8
4080 NEXT I
4100 RETURN


4200 ' Extra success sound
4220 ' Note values: C=1, D=2, E=3, F=4, G=5, A=6, B=7
4250 FOR I=7 TO 1 STEP -2
4270   SOUND 1, 30 + 20 * i, 5, 8
4280   SOUND 3, 30 + 20 * i, 5, 8
4290 NEXT I
4300 RETURN


5000 ' Print next level
5001 IF level = finalLevel THEN quit = 1: RETURN
5002 x = 20 : y = 12
5003 level = level + 1
5006 GOSUB 6500 : ' Next level display
5007 GOSUB 2000 : ' Set read values and map printing
5008 RANDOMIZE TIME
5010 apples = 1
5020 xItem = 1 : yItem = 1
5030 FOR i=1 TO apples
5040   WHILE map(xItem, yItem) <> 0  ' Looking for a free position
5045     xItem = INT(RND*38) + 1 : yItem = INT(RND*22) + 1
5047   WEND
5050   LOCATE xItem, yItem : PEN 2 : PRINT CHR$(240); : map(xItem, yItem) = 2 : SOUND 1, 15, 15, 10
5060 NEXT i
5500 RETURN


6000 ' Main display
6010 LOCATE 16, 9 : PRINT "THE GAME"
6020 LOCATE 13, 12
6030 input "Nickname: ", nickname$
6100 RETURN


6500 ' Level display
6510 FOR i=1 TO 1500: NEXT ' Sleep
6515 CLS
6520 LOCATE 16, 12 : PRINT "Level"; level
6540 LOCATE 16, 15 : PRINT "Score: "; score
6540 LOCATE 1, 23
6550 FOR i=1 TO 2500: NEXT ' Sleep
6600 RETURN


7000 ' End display
7010 FOR i=1 TO 1500: NEXT ' Sleep
7020 CLS
7030 LOCATE 13, 10 : PRINT "G A M E  O V E R"
7035 LOCATE 13, 14 : PRINT nickname$; " score: "; score
7040 LOCATE 1, 23
7050 FOR i=1 TO 3000: NEXT ' Sleep
7100 RETURN



10000 ' Map 1
10010 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
10020 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10030 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10040 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10050 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10060 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1
10070 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
10080 DATA 1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
10090 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
10100 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
10110 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10120 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10130 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10140 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1
10150 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10160 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10170 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10180 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10190 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1
10200 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10210 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10220 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10230 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
10240 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

11000 ' Map 2
11010 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
11020 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1
11030 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11040 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11050 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11060 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1
11070 DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
11080 DATA 1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
11090 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
11100 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
11110 DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11120 DATA 1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11130 DATA 1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11140 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1
11150 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11160 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11170 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11180 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11190 DATA 1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1
11200 DATA 1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1
11210 DATA 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1
11220 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11230 DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
11240 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

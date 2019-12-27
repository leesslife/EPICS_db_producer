# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import sys
import csv
aistr=[]
aistr.append('file "../../db/'+sys.argv[3]+'" { pattern')
with open('./'+sys.argv[1],'r') as csvfile:
    read=csv.reader(csvfile)
    for i in read:
        i[0]="{"+i[0]
        i[-1]=i[-1]+"}"
        aistr.append(i)
print(aistr)
print(len(aistr))
aistr2=""
for i in range(len(aistr)):
    if i==0:
        aistr2=aistr2+aistr[i]+'\n'
    else:
        aistr2=aistr2+',    '.join(aistr[i])+'\n'
aistr2=aistr2+'}'
print(aistr2)
with open('./'+sys.argv[2],'w') as resultfile:
    resultfile.write(aistr2)

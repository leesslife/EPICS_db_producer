# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import sys
import os
import csv
print(sys.argv[0])
print(sys.argv[1])
def gen_sublist(name,type):
    aistr=[]
    aistr.append('file "../../db/'+type+'" { pattern')
    with open('./'+sys.argv[1]+'/csv/'+name+'.csv','r') as csvfile:
        read=csv.reader(csvfile)
        for i in read:
            if type=='aiFloat64.template' or type=='aoFloat64.template':
                if i[5]=="-1.00E+06":
                    i[5]="-1e6"
                if i[6]=="1.00E+06":
                    i[6]="1e6"
            i[0]="{"+i[0]
            i[-1]=i[-1]+"}"
            aistr.append(i)
    print(aistr)
    aistr2=""
    for i in range(len(aistr)):
        if i==0:
            aistr2=aistr2+aistr[i]+'\n'
        else:
            aistr2=aistr2+',    '.join(aistr[i])+'\n'
    aistr2=aistr2+'}'
    #print(aistr2)
    with open('./'+sys.argv[1]+'/sub/'+name+'.substitution','w') as resultfile:
        resultfile.write(aistr2)
subtype=""
def gen_sub(subname):
    try:
        subname.index('AX')
        subtype="aiFloat64.template"
        gen_sublist(subname,subtype)
    except ValueError:
        pass
    try:
        subname.index('DX')
        subtype="bi_bit.template"
        gen_sublist(subname,subtype)
    except ValueError:
        pass
    try:
        subname.index('AY')
        subtype="aoFloat64.template"
        gen_sublist(subname,subtype)
    except ValueError:
        pass
    try:
        subname.index('DY')
        subtype="bo_bit.template"
        gen_sublist(subname,subtype)
    except ValueError:
        pass
path_csv=sys.argv[1]+'/csv/'
path_sub=sys.argv[1]+'/sub/'
f_csv=os.listdir(path_csv)
for i in f_csv:
    j=i.split('.')
    gen_sub(j[0])
    
f_sub=os.listdir(path_sub)
headerstring_1="file \"/usr/local/epics/asyn4-29/db/asynRecord.db\" { pattern\n"
headerstring_2="{P,           R,       PORT,      ADDR,   IMAX,    OMAX}\n"
headerstring_3="{TMSR:,    DCS,    "+sys.argv[1]+",     0,      80,      80}\n"
headerstring_4="}\n"
headerstring_5="file \"../../db/statistics.template\" { pattern\n"
headerstring_6="{P,           R,         PORT,          SCAN}\n"
headerstring_7_be="{"+sys.argv[1]+":,    Mod1"
headerstring_7_af=",    \"10 second\"}\n"
headerstring_7=""
for i in f_sub:
    j=i.split('.')
    headerstring_7=headerstring_7+headerstring_7_be+j[0]+",     "+j[0]+headerstring_7_af
headerstring_8="}\n"
headerstring=headerstring_1+headerstring_2+headerstring_3+headerstring_4+headerstring_5+headerstring_6+headerstring_7+headerstring_8

with open(sys.argv[1]+"/"+sys.argv[1]+".substitutions","w") as result:
    result.write(headerstring+"\n")
with open(sys.argv[1]+"/"+sys.argv[1]+".substitutions","a") as result_a:
    for i in f_sub:
        result_a.write("\n\n\n")
        path_2=sys.argv[1]+'/sub/'+i
        with open(path_2,'r') as reader:
            writer_a=reader.readlines()
            for i in writer_a:
                result_a.write(i)

    
    

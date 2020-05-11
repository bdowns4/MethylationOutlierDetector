#!/bin/sh
mkdir ./Work
mkdir ./Input
input="./Input"
work="./Work"
mkdir ./Output
output="./Output"


tail -n+2 ./Case* | sed 's/"//g' > $input/No_ID_Case
tail -n+2 ./Control* | sed 's/"//g' > $input/No_ID_Control
head -1 ./Case* | sed 's/ /_/g' | sed 's/"//g' > $input/ID_Case
head -1 ./Control* | sed 's/ /_/g' | sed 's/"//g' > $input/ID_Control
awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $input/No_ID_Control $input/No_ID_Case  | sort > $input/No_ID_Case_Over
awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $input/No_ID_Case $input/No_ID_Control  | sort > $input/No_ID_Control_Over
cat $input/ID_Case $input/No_ID_Case_Over | sed 's/		/	NA	/g' | sed 's/	$/	NA/g' | sed 's/null/NA/g' > $input/Case
cat $input/ID_Control $input/No_ID_Control_Over | sed 's/		/	NA	/g' | sed 's/	$/	NA/g' | sed 's/null/NA/g' > $input/Control
rm $input/No_ID_Case | rm $input/No_ID_Control | rm $input/ID_Case | rm $input/ID_Control | rm $input/No_ID_Case_Over | rm $input/No_ID_Control_Over
tail -n+2 ./Case* | sed 's/"//g' | awk '{ $1="";print} BEGIN {OFS="\t"}' | awk '{ sub(/^[ \t]+/, ""); print }' > $input/No_ID_Case
tail -n+2 ./Control* | sed 's/"//g' |awk '{ $1="";print} BEGIN {OFS="\t"}' | awk '{ sub(/^[ \t]+/, ""); print }' > $input/No_ID_Control

awk '{
  split($0,a)
  asort(a)
  for(i=NF;i>0;i--){
    printf("%s ",a[i])
  }
  print ""
}'  $input/No_ID_Case  | sed 's/ /	/g' > $work/Case_Max

awk '{
  split($0,a)
  asort(a)
  for(i=1; i<=NF; i++){
    printf("%s ",a[i])
  }
  print ""
}'  $input/No_ID_Case | sed 's/ /	/g' > $work/Case_Min

awk '{
  split($0,a)
  asort(a)
  for(i=NF;i>0;i--){
    printf("%s ",a[i])
  }
  print ""
}'  $input/No_ID_Control  | sed 's/ /	/g' > $work/Control_Max

awk '{
  split($0,a)
  asort(a)
  for(i=1; i<=NF; i++){
    printf("%s ",a[i])
  }
  print ""
}'  $input/No_ID_Control | sed 's/ /	/g' > $work/Control_Min

rm $input/No_ID_Case | rm $input/No_ID_Control

head -67 ./Methylation_Outlier_Detector.sh | tail -6 | sed 's/#//g' > $work/make_All_1

#sort $work/SMin_R > $work/SSMin_R
#sort $work/SMin_F > $work/SSMin_F

#sort $work/SMax_R > $work/SSMax_R
#sort $work/SMax_F > $work/SSMax_F


head -104 ./Methylation_Outlier_Detector.sh | tail -35 | sed 's/#//g' > $work/make_All_2





#cat $work/Max_R_MaxCtrl_* | grep -v e |  grep -v NA > $work/List_More_NR
#cat $work/Min_R_MinCtrl_* | grep -v e |  grep -v NA > $work/List_Less_NR

#cat $work/Max_F_MaxCase_* | grep -v e |  grep -v NA > $work/List_More_R
#cat $work/Min_F_MinCase_*| grep -v e |  grep -v NA > $work/List_Less_R

#cat $work/Max_R_Max* | grep -v e |  grep -v NA | cut -f1 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/ /	/g' | sed 's/"//g' | awk '{ sub(/^[ \t]+/, ""); print }' > $work/output_More_NR
#cat $work/Max_F_Max* | grep -v e |  grep -v NA | cut -f1 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/ /	/g' | sed 's/"//g' | awk '{ sub(/^[ \t]+/, ""); print }' > $work/output_More_R
#cat $work/Min_R_Min* | grep -v e |  grep -v NA | cut -f1 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/ /	/g'  | sed 's/"//g' | awk '{ sub(/^[ \t]+/, ""); print }' > $work/output_Less_NR
#cat $work/Min_F_Min* | grep -v e |  grep -v NA | cut -f1 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/ /	/g' | sed 's/"//g' | awk '{ sub(/^[ \t]+/, ""); print }' > $work/output_Less_R

#awk '{ if ($2 <= .15) print $1, $2, $3, $3-$2} BEGIN {OFS=}' $work/List_More_R > $work/List_Nor_More_R_All2
#awk '{ if ($2 <= .15) print $1, $2, $3, $3-$2} BEGIN {OFS=}' $work/List_More_NR > $work/List_Nor_More_NR_All2
#awk '{ if ($3 <= .15) print $1, $2, $3, $2-$3} BEGIN {OFS=}' $work/List_Less_NR > $work/List_Nor_Less_NR_All2
#awk '{ if ($3 <= .15) print $1, $2, $3, $2-$3} BEGIN {OFS=}' $work/List_Less_R > $work/List_Nor_Less_R_All2

#awk '{ if ($3 >= .2) print $1, $2, $3, $4} BEGIN {OFS=}' $work/List_Nor_More_R_All2 > $work/List_Nor_More_R_All3
#awk '{ if ($3 >= .2) print $1, $2, $3, $4} BEGIN {OFS=}' $work/List_Nor_More_NR_All2 > $work/List_Nor_More_NR_All3
#awk '{ if ($2 >= .2) print $1, $2, $3, $4} BEGIN {OFS=}' $work/List_Nor_Less_NR_All2 > $work/List_Nor_Less_NR_All3
#awk '{ if ($2 >= .2) print $1, $2, $3, $4} BEGIN {OFS=}' $work/List_Nor_Less_R_All2 > $work/List_Nor_Less_R_All3

#cat $work/m7 $work/List_Nor_More_R_All3 | sort > $output/Hypermethylated_Cases_Characteristics.txt
#cat $work/m9 $work/List_Nor_More_NR_All3 | sort > $output/Hypermethylated_Controls_Characteristics.txt
#cat $work/m6 $work/List_Nor_Less_R_All3 | sort > $output/Hypomethylated_Cases_Characteristics.txt
#cat $work/m8 $work/List_Nor_Less_NR_All3 | sort > $output/Hypomethylated_Controls_Characteristics.txt
#cut -f1 $work/List_Nor_More_R_All3 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/^ //g' | sed 's/ /"	"/g' | sed 's/"//g' | sort -r -n | awk '{ sub(/^[ \t]+/, ""); print }' >  $work/Rank_High_Case
#cut -f1 $work/List_Nor_More_NR_All3 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/^ //g' | sed 's/ /"	"/g' | sed 's/"//g' | sort -r -n | awk '{ sub(/^[ \t]+/, ""); print }' >  $work/Rank_High_Control
#cut -f1 $work/List_Nor_Less_NR_All3 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/^ //g' | sed 's/ /"	"/g' | sed 's/"//g' | sort -r -n | awk '{ sub(/^[ \t]+/, ""); print }' >  $work/Rank_Low_Control
#cut -f1 $work/List_Nor_Less_R_All3 | sort | uniq -c | sed 's/    //g' | sed 's/   //g' | sed 's/  //g' | sed 's/^ //g' | sed 's/ /"	"/g' | sed 's/"//g' | sort -r -n | awk '{ sub(/^[ \t]+/, ""); print }' >  $work/Rank_Low_Case





head -1 $input/Case* | sed 's/ /_/g' > $work/head_Case
echo '-->------------------------------'
awk '{
for (i=1; i<=NF; i++)  {
a[NR,i] =i
}
}
NF>p { p = NF }
END {
for(j=1; j<=p; j++) {
str=a[1,j]
for(i=2; i<=NR; i++){
str=str" "a[i,j];
}
print str
}
}' $work/head_Case > $work/Tr_Case

head -1 $input/Cont* |sed 's/ /_/g' > $work/head_Control

awk '{
for (i=1; i<=NF; i++)  {
a[NR,i] =i
}
}
NF>p { p = NF }
END {
for(j=1; j<=p; j++) {
str=a[1,j]
for(i=2; i<=NR; i++){
str=str" "a[i,j];
}
print str
}
}' $work/head_Control > $work/Tr_Control
cut -f 2-  $work/head_Control > $work/head_Control_N_ID
cut -f 2-  $work/head_Case > $work/head_Case_N_ID
wc -l $work/Tr_Control > $work/wc_Control
sed 's/ //g' $work/wc_Control | sed 's/\// /g' > $work/wc_Control1
cut -d " " -f1 $work/wc_Control1 > $work/wc_Control2
awk '{ print(($1-1)*.95)} BEGIN {OFS="\t"}' $work/wc_Control2 > $work/wc_Control3
paste -d "\t" $work/wc_Control2 $work/wc_Control3 > $work/wc_Control4
awk '{ print(1,($1-$2+1))} BEGIN {OFS=","}' $work/wc_Control4 > $work/wc_Control5
cut -d "." -f1 $work/wc_Control5 > $work/wc_Control6

wc -l $work/Tr_Case > $work/wc_Case
sed 's/ //g' $work/wc_Case | sed 's/\// /g' > $work/wc_Case1
cut -d " " -f1 $work/wc_Case1 > $work/wc_Case2
awk '{ print(($1-1)*.95)} BEGIN {OFS="\t"}' $work/wc_Case2 > $work/wc_Case3
paste -d "\t" $work/wc_Case2 $work/wc_Case3 > $work/wc_Case4
awk '{ print(1,($1-$2+1))} BEGIN {OFS=","}' $work/wc_Case4 > $work/wc_Case5
cut -d "." -f1 $work/wc_Case5 > $work/wc_Case6
echo '---->----------------------------'
echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cut -f 1,$i $input/Case* > $work/Ca_$i" ; done > $work/make_Case1' > $work/m2
echo '); do echo "cut -f 1,$i $input/Control* > $work/Cont_$i" ; done > $work/make_Cont1' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head
paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

cat $work/head_Control_N_ID $work/Control_Min > $work/Control_Min_head
cat $work/head_Control_N_ID $work/Control_Max > $work/Control_Max_head
cut -f1 $input/Control* > $work/Control_ID
paste -d "\t" $work/Control_ID $work/Control_Min_head > $work/SMin_F_1
paste -d "\t" $work/Control_ID $work/Control_Max_head > $work/SMax_F_1

cat $work/head_Case_N_ID $work/Case_Min > $work/Case_Min_head
cat $work/head_Case_N_ID $work/Case_Max > $work/Case_Max_head
cut -f1 $input/Case* > $work/Case_ID
paste -d "\t" $work/Case_ID $work/Case_Min_head > $work/SMin_R_1
paste -d "\t" $work/Case_ID $work/Case_Max_head > $work/SMax_R_1

printf 'cut -f' > $work/cut
printf '$work/SMin_R_1 > $input/SMin_R' > $work/SMin_R_tail
printf '$work/SMin_F_1 > $input/SMin_F' > $work/SMin_F_tail
printf '$work/SMax_R_1 > $input/SMax_R' > $work/SMax_R_tail
printf '$work/SMax_F_1 > $input/SMax_F' > $work/SMax_F_tail

paste -d " " $work/cut $work/wc_Case6 $work/SMin_R_tail > $work/Make_SMin_R
paste -d " "  $work/cut $work/wc_Case6 $work/SMax_R_tail > $work/Make_SMax_R
paste -d " "  $work/cut $work/wc_Control6 $work/SMin_F_tail > $work/Make_SMin_F
paste -d " " $work/cut $work/wc_Control6 $work/SMax_F_tail > $work/Make_SMax_F

cat $work/sh_head $work/Make_SMin_R $work/Make_SMin_F $work/Make_SMax_R $work/Make_SMax_f > $work/CaseScript_2.sh

chmod u+x $work/CaseScript_2.sh
$work/CaseScript_2.sh


echo '); do echo "sort $work/Ca_$i > $work/Case_$i""RS" ; done > $work/make_Case2' > $work/m2

echo '); do echo "sort $work/Cont_$i > $work/Ctrl_$i""FS" ; done > $work/make_Cont2' > $work/m3

echo '------>--------------------------'
paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo '); do echo "awk NR==FNR{a[NR]=\$1\""\\\t"\"\$2; next} {print a[FNR], \$2 } BEGIN {OFS=""} $work/SSMax_F $work/Case_$i""RS > $work/Max_F_Case_$i""RS" ; done > $work/make_Case3' > $work/m4

echo '); do echo "awk NR==FNR{a[NR]=\$1\""\\\t"\"\$2; next} {print a[FNR], \$2} BEGIN {OFS=""} $work/SSMin_R $work/Ctrl_$i""FS > $work/Min_R_Ctrl_$i""FS" ; done > $work/make_Cont3' > $work/m5

sed "s/NR==/'NR==/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/NR==/'NR==/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo '-------->------------------------'
echo '); do echo "awk { if (\$2 <= \$3) print \$1, \$2, \$3, \$3-\$2} BEGIN {OFS=""} $work/Max_F_Case_$i""RS > $work/Max_F_MaxCase_$i""R" ; done > $work/make_Case4' > $work/m4

echo '); do echo "awk { if (\$2 >= \$3) print \$1, \$2, \$3, \$3-\$2} BEGIN {OFS=""} $work/Min_R_Ctrl_$i""FS > $work/Min_R_MinCtrl_$i""F" ; done > $work/make_Cont4' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo '----------->---------------------'

echo '); do echo "awk NR==FNR{a[NR]=\$1\""\\\t"\"\$2; next} {print a[FNR], \$2 } BEGIN {OFS=""} $work/SSMin_F $work/Case_$i""RS > $work/Min_F_Case_$i""RS" ; done > $work/make_Case5' > $work/m4

echo '); do echo "awk NR==FNR{a[NR]=\$1\""\\\t"\"\$2; next} {print a[FNR], \$2 } BEGIN {OFS=""} $work/SSMax_R $work/Ctrl_$i""FS > $work/Max_R_Ctrl_$i""FS" ; done > $work/make_Cont5' > $work/m5

sed "s/awk NR/awk 'NR/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/awk NR/awk 'NR/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh
echo '-------------->------------------'

echo '); do echo "awk { if (\$2 >= \$3) print \$1, \$2, \$3, \$3-\$2} BEGIN {OFS=""} $work/Min_F_Case_$i""RS > $work/Min_F_MinCase_$i""R" ; done > $work/make_Case6' > $work/m4

echo '); do echo "awk { if (\$2 <= \$3) print \$1, \$2, \$3, \$3-\$2} BEGIN {OFS=""} $work/Max_R_Ctrl_$i""FS > $work/Max_R_MaxCtrl_$i""F" ; done > $work/make_Cont6' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh
echo '----------------->---------------'

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


echo '-------------------->------------'

cat $work/sh_head $work/make_Cont1 $work/make_Case1 $work/make_All_1 $work/make_Cont2 $work/make_Case2 $work/make_Cont3 $work/make_Case3 $work/make_Cont4 $work/make_Case4 $work/make_Cont5 $work/make_Case5 $work/make_Cont6 $work/make_Case6 $work/make_All_2 > $work/Script_1.sh


sed 's/OFS=/OFS="\\\t"/g' $work/Script_1.sh > $input/Script_1.sh
rm -r $work
mkdir ./Work
echo 'ID\tControl_Min_95%\tCase_Outlier\tDelta' > $work/m6
echo 'ID\tControl_Max_95%\tCase_Outlier\tDelta' > $work/m7
echo 'ID\tCase_Min_95%\tControl_Outlier\tDelta' > $work/m8
echo 'ID\tCaseMax_95%\tControl_Outlier\tDelta' > $work/m9
mv $input/SMin_R $work/SMin_R
mv $input/SMin_F $work/SMin_F
mv $input/SMax_R $work/SMax_R
mv $input/SMax_F $work/SMax_F


chmod u+x $input/Script_1.sh
$input/Script_1.sh

echo '----------------------->---------'
sed 's/NA/0/g' $input/Case | sed 's/NULL/0/g' > $work/Case_1_NA
sed 's/NA/0/g' $input/Control | sed 's/NULL/0/g' > $work/Control_1_NA

cat $input/Case | perl -pe 's/\tNA//g' | perl -pe 's/\tNULL//g' > $work/Case_No_1_NA
cat $input/Control | perl -pe 's/\tNA//g' | perl -pe 's/\tNULL//g' > $work/Control_No_1_NA

head -1 $input/Case* | sed 's/ /_/g' > $work/head_Case

awk '{
for (i=1; i<=NF; i++)  {
a[NR,i] =i
}
}
NF>p { p = NF }
END {
for(j=1; j<=p; j++) {
str=a[1,j]
for(i=2; i<=NR; i++){
str=str" "a[i,j];
}
print str
}
}' $work/head_Case > $work/Tr_Case

head -1 $input/Cont* |sed 's/ /_/g'> $work/head_Control

awk '{
for (i=1; i<=NF; i++)  {
a[NR,i] =i
}
}
NF>p { p = NF }
END {
for(j=1; j<=p; j++) {
str=a[1,j]
for(i=2; i<=NR; i++){
str=str" "a[i,j];
}
print str
}
}' $work/head_Control > $work/Tr_Control

cat $work/Rank_High_Case $work/Rank_Low_Case $work/Rank_High_Control  $work/Rank_Low_Control | cut -f2 > $work/Rank_All_1
sort $work/Rank_All_1 | uniq > $work/Rank_All
awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_All $work/Case_1_NA > $work/Case_2_NA
awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_All $work/Control_1_NA > $work/Control_2_NA

awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_All $work/Case_No_1_NA  > $work/Case_No_2_NA
awk 'NR==FNR{a[$1];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_All $work/Control_No_1_NA  > $work/Control_No_2_NA

cat $work/head_Case $work/Case_2_NA > $work/Case_NA
cat $work/head_Control $work/Control_2_NA > $work/Control_NA

cat $work/head_Case $work/Case_No_2_NA > $work/Case_No_NA
cat $work/head_Control $work/Control_No_2_NA > $work/Control_No_NA

wc -l $work/Tr_Control > $work/wc_Control
sed 's/ //g' $work/wc_Control | sed 's/\// /g' > $work/wc_Control1
cut -d " " -f1 $work/wc_Control1 > $work/wc_Control2
awk '{ print(($1-1)*.95)} BEGIN {OFS="\t"}' $work/wc_Control2 > $work/wc_Control3
paste -d "\t" $work/wc_Control2 $work/wc_Control3 > $work/wc_Control4
awk '{ print(1,($1-$2+1))} BEGIN {OFS=","}' $work/wc_Control4 > $work/wc_Control5
cut -d "." -f1 $work/wc_Control5 > $work/wc_Control6
wc -l $work/Tr_Case > $work/wc_Case
sed 's/ //g' $work/wc_Case | sed 's/\// /g' > $work/wc_Case1
cut -d " " -f1 $work/wc_Case1 > $work/wc_Case2
awk '{ print(($1-1)*.95)} BEGIN {OFS="\t"}' $work/wc_Case2 > $work/wc_Case3
paste -d "\t" $work/wc_Case2 $work/wc_Case3 > $work/wc_Case4
awk '{ print(1,($1-$2+1))} BEGIN {OFS=","}' $work/wc_Case4 > $work/wc_Case5
cut -d "." -f1 $work/wc_Case5 > $work/wc_Case6

echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cut -f 1,$i $work/Case_NA* > $work/Ca_$i" ; done > $work/make_Case1' > $work/m2
echo '); do echo "cut -f 1,$i $work/Control_NA* > $work/Cont_$i" ; done > $work/make_Cont1' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head
paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo '-------------------------->------'


echo '); do echo "awk { if (\$2 >= 0.2) print \$1, 1} BEGIN {OFS=""} $work/Ca_$i > $work/Case_low_call_$i" ; done > $work/make_Case6' > $work/m4

echo '); do echo "awk { if (\$2 >= 0.2) print \$1, 1} BEGIN {OFS=""} $work/Cont_$i > $work/Cont_low_call_$i" ; done > $work/make_Cont6' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


echo '); do echo "awk { if (\$2 < 0.2) print \$1, 0} BEGIN {OFS=""} $work/Ca_$i > $work/Case_high_call_$i" ; done > $work/make_Case7' > $work/m4

echo '); do echo "awk { if (\$2 < 0.2) print \$1, 0} BEGIN {OFS=""} $work/Cont_$i > $work/Cont_high_call_$i" ; done > $work/make_Cont7' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh


paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cat $work/Case_low_call_$i $work/Case_high_call_$i  | sort > $work/Case_high_low_call_$i" ; done > $work/make_Case8' > $work/m2
echo '); do echo "cat $work/Cont_low_call_$i $work/Cont_high_call_$i | sort > $work/Cont_high_low_call_$i" ; done > $work/make_Cont8' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cut -f 2 $work/Case_high_low_call_$i > $work/Case_high_low_call_cut_$i" ; done > $work/make_Case9' > $work/m2
echo '); do echo "cut -f 2 $work/Cont_high_low_call_$i > $work/Cont_high_low_call_cut_$i " ; done > $work/make_Cont9' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


cat $work/sh_head $work/make_Cont1 $work/make_Case1 $work/make_Cont6 $work/make_Case6 $work/make_Cont7 $work/make_Case7 $work/make_Cont8 $work/make_Case8 $work/make_Cont9 $work/make_Case9 > $work/Script_1.sh

echo '---------------------------->----'

sed 's/OFS=/OFS="\\\t"/g' $work/Script_1.sh > $input/Script_1.sh

chmod u+x $input/Script_1.sh
$input/Script_1.sh
cut -f1 $work/Case_NA | sort > $work/Case_cut_NA_1
cut -f1 $work/Control_NA | sort > $work/Control_cut_NA_1


Paste -d '\t' $work/Control_cut_NA_1 $work/Cont_high_low_call_cut_1* $work/Cont_high_low_call_cut_2* > $work/Cont_high_low_call_Paste_1_2
Paste -d '\t' $work/Cont_high_low_call_cut_3* $work/Cont_high_low_call_cut_4* > $work/Cont_high_low_call_Paste_3_4
Paste -d '\t' $work/Cont_high_low_call_cut_5* $work/Cont_high_low_call_cut_6* > $work/Cont_high_low_call_Paste_5_6
Paste -d '\t' $work/Cont_high_low_call_cut_7* $work/Cont_high_low_call_cut_8* > $work/Cont_high_low_call_Paste_7_8
Paste -d '\t' $work/Cont_high_low_call_cut_9* > $work/Cont_high_low_call_Paste_9
Paste -d '\t' $work/Cont_high_low_call_Paste_1_2 $work/Cont_high_low_call_Paste_3_4 $work/Cont_high_low_call_Paste_5_6 $work/Cont_high_low_call_Paste_7_8 $work/Cont_high_low_call_Paste_9 >$work/Cont_LH_call_All

Paste -d '\t' $work/Case_cut_NA_1 $work/Case_high_low_call_cut_1* $work/Case_high_low_call_cut_2* > $work/Case_high_low_call_Paste_1_2
Paste -d '\t' $work/Case_high_low_call_cut_3* $work/Case_high_low_call_cut_4* > $work/Case_high_low_call_Paste_3_4
Paste -d '\t' $work/Case_high_low_call_cut_5* $work/Case_high_low_call_cut_6* > $work/Case_high_low_call_Paste_5_6
Paste -d '\t' $work/Case_high_low_call_cut_7* $work/Case_high_low_call_cut_8* > $work/Case_high_low_call_Paste_7_8
Paste -d '\t' $work/Case_high_low_call_cut_9* > $work/Case_high_low_call_Paste_9
Paste -d '\t' $work/Case_high_low_call_Paste_1_2 $work/Case_high_low_call_Paste_3_4 $work/Case_high_low_call_Paste_5_6 $work/Case_high_low_call_Paste_7_8 $work/Case_high_low_call_Paste_9 >$work/Case_LH_call_All

echo 'ID\tCase_Outlier\tCase_Non-Outlier\tTotal_Cases\tControl_Outlier\tControl_Non-Outlier\tTotal_Control\tOR' > $work/m10
echo 'ID\tControl_Outlier\tControl_Non-Outlier\tTotal_Controls\tCase_Outlier\tCase_Non-Outlier\tTotal_Cases\tOR' > $work/m11

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Case $work/Cont_LH_call_All > $work/Cont_LH_call_All_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Case $work/Case_LH_call_All > $work/Case_LH_call_All_Out

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Case $work/Control_No_NA  > $work/Cont_No_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Case $work/Case_No_NA  > $work/Case_No_Out


awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Cont_LH_call_All_Out > $work/Cont_Events
awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Case_LH_call_All_Out > $work/Case_Events

awk -F'\t' '{print NF-1}' $work/Cont_No_Out > $work/Cont_Total
awk -F'\t' '{print NF-1}' $work/Case_No_Out > $work/Case_Total

cut -f 1 $work/Cont_LH_call_All_Out > $work/Cont_LH_call_All_Out_cut

paste -d '\t' $work/Cont_LH_call_All_Out_cut $work/Case_Events $work/Case_Total $work/Cont_Events $work/Cont_Total > $work/Odds_Calc
awk '{ print($1,$2,$3-$2,$3,$4,$5-$4,$5)} BEGIN {OFS="\t"}' $work/Odds_Calc > $work/Odds_Calc_1

grep -v '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_NoZ
grep '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,(((0.5+$2))/(((0.5+$3))))/(((0.5+$5))/(((0.5+$6)))))} BEGIN {OFS="\t"}' $work/Odds_Calc_Z > $work/Odds_Ratio_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,(($2)/($3))/(($5)/($6)))} BEGIN {OFS="\t"}' $work/Odds_Calc_NoZ > $work/Odds_Ratio_NoZ

cat $work/Odds_Ratio_NoZ $work/Odds_Ratio_Z | sort -k8 -n -r > $work/Odds_Ratio_Z_Sort
cat $work/m10 $work/Odds_Ratio_Z_Sort >  $output/Hypermethylated_Cases_Odds_Ratio.txt

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Control $work/Cont_LH_call_All > $work/Cont_LH_call_All_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Control $work/Case_LH_call_All > $work/Case_LH_call_All_Out

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Control $work/Control_No_NA  > $work/Cont_No_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_High_Control $work/Case_No_NA  > $work/Case_No_Out


awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Cont_LH_call_All_Out > $work/Cont_Events
awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Case_LH_call_All_Out > $work/Case_Events

awk -F'\t' '{print NF-1}' $work/Cont_No_Out > $work/Cont_Total
awk -F'\t' '{print NF-1}' $work/Case_No_Out > $work/Case_Total

cut -f 1 $work/Cont_LH_call_All_Out > $work/Cont_LH_call_All_Out_cut

paste -d '\t' $work/Cont_LH_call_All_Out_cut $work/Cont_Events $work/Cont_Total $work/Case_Events $work/Case_Total > $work/Odds_Calc

awk '{ print($1,$2,$3-$2,$3,$4,$5-$4,$5)} BEGIN {OFS="\t"}' $work/Odds_Calc > $work/Odds_Calc_1
grep -v '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_NoZ
grep '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,(((0.5+$2))/(((0.5+$3))))/(((0.5+$5))/(((0.5+$6)))))} BEGIN {OFS="\t"}' $work/Odds_Calc_Z > $work/Odds_Ratio_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,(($2)/($3))/(($5)/($6)))} BEGIN {OFS="\t"}' $work/Odds_Calc_NoZ > $work/Odds_Ratio_NoZ

cat $work/Odds_Ratio_NoZ $work/Odds_Ratio_Z | sort -k8 -n -r  > $work/Odds_Ratio_Z_Sort
cat $work/m11 $work/Odds_Ratio_Z_Sort >  $output/Hypermethylated_Controls_Odds_Ratio.txt

#-----Low
echo '------------------------------>--'

echo '); do echo "awk { if (\$2 >= 0.15) print \$1, 1} BEGIN {OFS=""} $work/Ca_$i > $work/Case_low_call_$i" ; done > $work/make_Case6' > $work/m4

echo '); do echo "awk { if (\$2 >= 0.15) print \$1, 1} BEGIN {OFS=""} $work/Cont_$i > $work/Cont_low_call_$i" ; done > $work/make_Cont6' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


echo '); do echo "awk { if (\$2 < 0.15) print \$1, 0} BEGIN {OFS=""} $work/Ca_$i > $work/Case_high_call_$i" ; done > $work/make_Case7' > $work/m4

echo '); do echo "awk { if (\$2 < 0.15) print \$1, 0} BEGIN {OFS=""} $work/Cont_$i > $work/Cont_high_call_$i" ; done > $work/make_Cont7' > $work/m5

sed "s/{ if/'{ if/g" $work/m4 | sed "s/\"}/\"}'/g" > $work/m2
sed "s/{ if/'{ if/g" $work/m5 | sed "s/\"}/\"}'/g" > $work/m3

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh


paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cat $work/Case_low_call_$i $work/Case_high_call_$i  | sort > $work/Case_high_low_call_$i" ; done > $work/make_Case8' > $work/m2
echo '); do echo "cat $work/Cont_low_call_$i $work/Cont_high_call_$i | sort > $work/Cont_high_low_call_$i" ; done > $work/make_Cont8' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh

echo 'for i in $(seq 2'> $work/m1
echo '); do echo "cut -f 2 $work/Case_high_low_call_$i > $work/Case_high_low_call_cut_$i" ; done > $work/make_Case9' > $work/m2
echo '); do echo "cut -f 2 $work/Cont_high_low_call_$i > $work/Cont_high_low_call_cut_$i " ; done > $work/make_Cont9' > $work/m3

printf '#!/bin/sh \ninput="./Input" \nwork="./Work" \noutput="./Output"\n\n' > $work/sh_head

paste -d " " $work/m1 $work/wc_Case2 $work/m2 > $work/CaseScript

cat $work/sh_head $work/CaseScript > $work/CaseScript_1.sh

chmod u+x $work/CaseScript_1.sh
$work/CaseScript_1.sh

paste -d " " $work/m1 $work/wc_Control2 $work/m3 > $work/Control_Script

cat $work/sh_head $work/Control_Script > $work/Control_Script_1.sh

chmod u+x $work/Control_Script_1.sh
$work/Control_Script_1.sh


cat $work/sh_head $work/make_Cont1 $work/make_Case1 $work/make_Cont6 $work/make_Case6 $work/make_Cont7 $work/make_Case7 $work/make_Cont8 $work/make_Case8 $work/make_Cont9 $work/make_Case9 > $work/Script_1.sh



sed 's/OFS=/OFS="\\\t"/g' $work/Script_1.sh > $input/Script_1.sh

chmod u+x $input/Script_1.sh
$input/Script_1.sh
cut -f1 $work/Case_NA | sort > $work/Case_cut_NA_1
cut -f1 $work/Control_NA | sort > $work/Control_cut_NA_1

echo '-------------------------------->'
Paste -d '\t' $work/Control_cut_NA_1 $work/Cont_high_low_call_cut_1* $work/Cont_high_low_call_cut_2* > $work/Cont_high_low_call_Paste_1_2
Paste -d '\t' $work/Cont_high_low_call_cut_3* $work/Cont_high_low_call_cut_4* > $work/Cont_high_low_call_Paste_3_4
Paste -d '\t' $work/Cont_high_low_call_cut_5* $work/Cont_high_low_call_cut_6* > $work/Cont_high_low_call_Paste_5_6
Paste -d '\t' $work/Cont_high_low_call_cut_7* $work/Cont_high_low_call_cut_8* > $work/Cont_high_low_call_Paste_7_8
Paste -d '\t' $work/Cont_high_low_call_cut_9* > $work/Cont_high_low_call_Paste_9
Paste -d '\t' $work/Cont_high_low_call_Paste_1_2 $work/Cont_high_low_call_Paste_3_4 $work/Cont_high_low_call_Paste_5_6 $work/Cont_high_low_call_Paste_7_8 $work/Cont_high_low_call_Paste_9 >$work/Cont_LH_call_All

Paste -d '\t' $work/Case_cut_NA_1 $work/Case_high_low_call_cut_1* $work/Case_high_low_call_cut_2* > $work/Case_high_low_call_Paste_1_2
Paste -d '\t' $work/Case_high_low_call_cut_3* $work/Case_high_low_call_cut_4* > $work/Case_high_low_call_Paste_3_4
Paste -d '\t' $work/Case_high_low_call_cut_5* $work/Case_high_low_call_cut_6* > $work/Case_high_low_call_Paste_5_6
Paste -d '\t' $work/Case_high_low_call_cut_7* $work/Case_high_low_call_cut_8* > $work/Case_high_low_call_Paste_7_8
Paste -d '\t' $work/Case_high_low_call_cut_9* > $work/Case_high_low_call_Paste_9
Paste -d '\t' $work/Case_high_low_call_Paste_1_2 $work/Case_high_low_call_Paste_3_4 $work/Case_high_low_call_Paste_5_6 $work/Case_high_low_call_Paste_7_8 $work/Case_high_low_call_Paste_9 >$work/Case_LH_call_All

echo 'ID\tCase_Outlier\tCase_Non-Outlier\tTotal_Cases\tControl_Outlier\tControl_Non-Outlier\tTotal_Control\tOR' > $work/m10
echo 'ID\tControl_Outlier\tControl_Non-Outlier\tTotal_Controls\tCase_Outlier\tCase_Non-Outlier\tTotal_Cases\tOR' > $work/m11

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Case $work/Cont_LH_call_All > $work/Cont_LH_call_All_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Case $work/Case_LH_call_All > $work/Case_LH_call_All_Out

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Case $work/Control_No_NA  > $work/Cont_No_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Case $work/Case_No_NA  > $work/Case_No_Out


awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Cont_LH_call_All_Out > $work/Cont_Events
awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Case_LH_call_All_Out > $work/Case_Events

awk -F'\t' '{print NF-1}' $work/Cont_No_Out > $work/Cont_Total
awk -F'\t' '{print NF-1}' $work/Case_No_Out > $work/Case_Total

cut -f 1 $work/Cont_LH_call_All_Out > $work/Cont_LH_call_All_Out_cut

paste -d '\t' $work/Cont_LH_call_All_Out_cut $work/Case_Events $work/Case_Total $work/Cont_Events $work/Cont_Total > $work/Odds_Calc
awk '{ print($1,$3-$2,$2,$3,$5-$4,$4,$5)} BEGIN {OFS="\t"}' $work/Odds_Calc > $work/Odds_Calc_1
grep -v '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_NoZ
grep '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,((($2+.05)/($3+.5)))/(($5+.5)/($6+.5)))} BEGIN {OFS="\t"}' $work/Odds_Calc_Z > $work/Odds_Ratio_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,((($2)/($3)))/(($5)/($6)))} BEGIN {OFS="\t"}' $work/Odds_Calc_NoZ > $work/Odds_Ratio_NoZ

cat $work/Odds_Ratio_NoZ $work/Odds_Ratio_Z | sort -k8 -n -r > $work/Odds_Ratio_Z_Sort
cat $work/m10 $work/Odds_Ratio_Z_Sort >  $output/Hypomethylated_Cases_Odds_Ratio.txt


awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Control $work/Cont_LH_call_All > $work/Cont_LH_call_All_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Control $work/Case_LH_call_All > $work/Case_LH_call_All_Out

awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Control $work/Control_No_NA  > $work/Cont_No_Out
awk 'NR==FNR{a[$2];next}$1 in a{print $0} BEGIN {OFS="\t"}' $work/Rank_Low_Control $work/Case_No_NA  > $work/Case_No_Out


awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Cont_LH_call_All_Out > $work/Cont_Events
awk '{ for(i=1; i<=NF;i++) j+=$i; print j; j=0 }' $work/Case_LH_call_All_Out > $work/Case_Events

awk -F'\t' '{print NF-1}' $work/Cont_No_Out > $work/Cont_Total
awk -F'\t' '{print NF-1}' $work/Case_No_Out > $work/Case_Total

cut -f 1 $work/Cont_LH_call_All_Out > $work/Cont_LH_call_All_Out_cut

paste -d '\t' $work/Cont_LH_call_All_Out_cut  $work/Cont_Events $work/Cont_Total $work/Case_Events $work/Case_Total > $work/Odds_Calc
awk '{ print($1,$3-$2,$2,$3,$5-$4,$4,$5)} BEGIN {OFS="\t"}' $work/Odds_Calc > $work/Odds_Calc_1
grep -v '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_NoZ
grep '\t0\t' $work/Odds_Calc_1 > $work/Odds_Calc_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,((($2+.05)/($3+.5)))/(($5+.5)/($6+.5)))} BEGIN {OFS="\t"}' $work/Odds_Calc_Z > $work/Odds_Ratio_Z

awk '{ print($1,$2,$3,$4,$5,$6,$7,((($2)/($3)))/(($5)/($6)))} BEGIN {OFS="\t"}' $work/Odds_Calc_NoZ > $work/Odds_Ratio_NoZ

cat $work/Odds_Ratio_NoZ $work/Odds_Ratio_Z | sort -k8 -n -r > $work/Odds_Ratio_Z_Sort
cat $work/m11 $work/Odds_Ratio_Z_Sort >  $output/Hypomethylated_Controls_Odds_Ratio.txt


rm $input/Script_1.sh
rm -r $work

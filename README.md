Methylation Outlier Detector 
=======
This biomarker discovery program named the Methylation Outlier Detector can be used to identify promising methylation markers from Illumina methylation arrays. To identify the hypermethylated markers, the program first selects all markers that have a β value greater than 0.20 in the first dataset named "Cases". The markers will be filtered out if more than 5% of the second dataset named "Control" have a β value greater than 0.15. Finally, the markers will be sorted by their odds ratio. The hypermethylated markers in the Controls will also be identified using the same filtering rules.
This program will also identify hypomethylated markers by selecting all markers that have a β value less than 0.15 in the first data set "Cases". The markers will be filtered out if more than 5% of the "Control" samples have a β value less than 0.20. Again, the markers were sorted by their odds ratio. The hypomethylated markers in the Controls will also be identified using the same filtering rules.

This program will make two types of output files, an "Odds_Ratios" file with the number of outliers counted in the Case and Control files and a "Characteristics" file that show the beta values of the outlier samples.

This program can be modified for different methylation thresholds by changing lines:

80, 85, 428, and 450 (Hypermethylated Cases)

81, 86, 430, and 452 (Hypermethylated Controls)

83, 88, 602, and 624 (Hypomethylated Cases)

82, 87, 604, and 626 (Hypomethylated Controls)

The error rate can be modified by changing lines:
143, 151, 321-324, 394, and 401

---

## Changelog
[20200402] v0.01.0:Methylation_Outlier_Detector.

---

## Installation

The preferred method for downloading this script file is through github.


#### Step 1: Download the Methylation Outlier Detector file.

Please download the script file release [here] 

https://github.com/bdowns4/MethylationOutlierDetector.git

#### Step 2: Unzip the Methylation Outlier Detector file.
Double click the Methylation Outlier Detector file to unzip.

#### Step 3: Copy the Methylation Outlier Detector script file to a new folder.

Copy the script file "Methylation_Outlier_Detector.sh" into a new folder with the two dataset files labeled as “Case” and “Control”. 

#### Step 4: Set the Terminal directory.

In the Terminal window, set the new file as the current directory.

```
cd /pathToDirectory/
```
#### Step 5: Execute the program.

Execute the Methylation_Outlier_Detector.sh script file from the Terminal window.

```
./Methylation_Outlier_Detector.sh
```


## Usage

This script is designed to be executed in the same directory as the two tab delimited dataset files labeled "Case" and "Control". The dataset files should have a single header row. 

Once the script is executed, 3 new directories will be made; "Input", "Output", and "Work".
The processed Case and Control files will be moved to a new directory named "Input".
The outlier markers files will be saved in the directory named "Output".
After the program has completed, the working directory “Work” will be removed.

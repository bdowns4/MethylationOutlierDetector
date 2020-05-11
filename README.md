Methylation Outlier Detector 
=======
This biomarker discovery program named the Methylation Outlier Detector can be used to identify promising methylation markers from Illumina methylation arrays. To identify the hypermethylated markers, the program first selects all markers that have a β value greater than 0.20 in the first dataset named "Cases". The markers will be filtered out if more than 5% of the second dataset named "Control" have a β value greater than 0.15. Finally, the markers will be sorted by their odds ratio. The hypermethylated markers in the Controls will also be identified using the same filtering rules.
This program will also identify hypomethylated markers by selecting all markers that have a β value less than 0.15 in the first data set "Cases". The markers will be filtered out if more than 5% of the "Control" samples have a β value less than 0.20. Again, the markers were sorted by their odds ratio. The hypomethylated markers in the Controls will also be identified using the same filtering rules.

This program will make two types of output files, an "Odds_Ratios" file with the number of outliers counted in the Case and Control files and a "Characteristics" file that show the beta values of the outlier samples.

This program can be modified for different methylation thresholds by changing lines:

86, 91, 434, 436, 456, and 458 (Hypermethylated Cases)

87, 92, 434, 436, 456, and 458 (Hypermethylated Controls)

89, 94, 608, 610, 630, and 632 (Hypomethylated Cases)

88, 93, 608, 610, 630, and 632 (Hypomethylated Controls)

The error rate can be modified by changing lines:
149, 157, 327-330, 4000, and 407

---

## Changelog
[20200402] v0.01.0:Methylation Outlier Detector.

---

## Installation

The preferred method for downloading this script file is through github


#### Step 1: For the Mac OSX operating system, first install gwak.

To install gwak, execute the following command in the terminal.

```
brew install gawk
```

#### Step 2: Download Methylation Outlier Detector.

Please download the script file release [here] https://github.com/bdowns4/MethylationOutlierDetector/blob/master/Methylation_Outlier_Detector.sh

unzip the file
place the script file "MethylationOutlierDetector.sh" in a new folder with the two dataset files labeled as “Case” and “Control”.
In the Terminal window, set this directory as the current directory.

```
cd /pathToDirectory/
```

Execute the Methylation_Outlier_Detector.sh script file from the Terminal window.

```
./Methylation_Outlier_Detector.sh
```


## Usage

This script is designed to be executed in the same directory as the two tab delimited data files labeled "Case" and "Control". 

Once the script is executed, 3 new directories will be made; "Work", "Input", and "Output".
The processed Case and Control files will be moved to a new directory named "Input".
The outlier markers files will be saved in the directory named "Output".
After the program has completed, the working directory “Work” will be removed.

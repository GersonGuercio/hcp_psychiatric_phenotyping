
library(summarytools)
library(DataExplorer)
library(dplyr)

setwd("C:/Users/linds/Dropbox (Personal)/Neurohackademy")

# read in hcp resticted data
hcp_behav_res <- read.csv(file = "hcp_RESTRICTED_loliver4_8_6_2019_12_56_55.csv")
hcp_behav_res_sub <- hcp_behav_res[,c("Subject","SSAGA_Alc_D4_Ab_Dx","SSAGA_Alc_D4_Dp_Dx","SSAGA_Mj_Ab_Dep")]

# recode alc variables to 1 (yes) and 0 (no)
hcp_behav_res_sub$SSAGA_Alc_D4_Ab_Dx <- recode(hcp_behav_res_sub$SSAGA_Alc_D4_Ab_Dx, '1'=0, '5'=1)
hcp_behav_res_sub$SSAGA_Alc_D4_Dp_Dx <- recode(hcp_behav_res_sub$SSAGA_Alc_D4_Dp_Dx, '1'=0, '5'=1)

# create summary alc/mrj variable 
hcp_behav_res_sub$sub_use <- rowSums(hcp_behav_res_sub[,2:4])
hcp_behav_res_sub$sub_use[hcp_behav_res_sub$sub_use > 0] <- 1


# read in hcp open data
hcp_behav_open <- read.csv(file = "hcp_unrestricted_loliver4_8_5_2019_13_9_30.csv")

# keep variables of interest
hcp_behav_open_sub <- hcp_behav_open[,c(1,4,5,89,117,119,121,122:124,126,128,130,131:157,159,161,163,165,167,168:191,508:512)]

# merge alc/mrj data with variables of interest
hcp_behav_sub <- merge(hcp_behav_open_sub,hcp_behav_res_sub[,c(1,5)],by="Subject")

# remove participants with NAs for substance use variables and make sub_use a factor
hcp_behav_sub <- hcp_behav_sub[!is.na(hcp_behav_sub$sub_use),]
hcp_behav_sub$sub_use <- as.factor(hcp_behav_sub$sub_use)

write.csv(hcp_behav_sub,file="hcp_behav_sub_2019-08-06.csv", row.names=F)


# explore the data

create_report(hcp_behav_sub, output_file="hcp_behav_sub_report.pdf")

dfSummary(hcp_behav_sub)

freq(hcp_behav_sub)



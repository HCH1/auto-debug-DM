#input csv
diffdm = read.csv("28LPQ-RF_Rev1.0_6.0_DRC01D3vs28LPQ-RF_Rev1.0_5.0_20171027DRCTrack.csv", header = TRUE)
#extract 3 columns
diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
#filter Type 
diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"), ]
#order Section
diffdm2 <- diffdm2[order(diffdm2[1]), ]
#length(t(diffdm4_uni)) == 113
diffdm4_uni <- unique(diffdm2[1]) 
#create dummy 113*1
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) 

#write a loop, run 113ea
for ( i in 1:length(t(diffdm4_uni)) ){
#filter the i-th Scetion, e.g. i=1 to 113 
a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
#e.g. 1st Section, then extract columns of "Type & Rule"
#due to we want to merge them
a4 <- cbind( a3[2], a3[3] ) #n*2 matrix
a4t <- as.matrix( t(a4) ) #2*n matrix
a4t <- as.vector(a4t) #convert to 2 lines (~ 2*1)
#due to repeat "Added or Removed or Modified", so need to do de-duplicated in this vector
a4t <- a4t[!duplicated(a4t)]
#lines -> character
a5 <- paste( t(a4t),collapse=" " )
#save to i-th row
ans_o1[i] <- a5
}
#create opuput format
ans_o2 <- cbind( diffdm4_uni, ans_o1 )
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
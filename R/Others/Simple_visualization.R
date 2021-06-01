# Read the CSV file
Data <- read.csv (file.choose(), header = TRUE, row.names = 1, sep = ",")
# Function arguments:
#   * file.choose() --- choose the file
#   * header = TRUE --- read the header because the file contains the names of the variables as its first line
#   * row.names = 1 --- determine the number giving the column of the table which contains the row names
#   * sep = "," ------- the field separator character. Values on each line of the file are separated by this character.

#   1) barplot
#   2) pie chart

# 1) barplot

barplot(
  as.matrix(Data),
  col = c("goldenrod3","salmon3"),
  border = "black",
  beside = TRUE, 
  legend = c("Weiblich", "Männlich"),
  sub = "Platform",
  main = "Geschlechterverteilung bei Apps",
  ylab = "Anzahl",
  ylim = c(0,max(Data, na.rm=TRUE)+1)
)

# 2) pie chart
# Idea taken from: https://www.statmethods.net/graphs/pie.html

# Plot all 4 pie charts together
number_of_plots = dim(Data)[2]
par(mfrow=c(1,number_of_plots)) # set the plotting area into a 1*4 array
# Plot all 4 pie charts using a for loop
for (platform in 1:number_of_plots){
  # Pie Chart with Percentages
  slices <- Data[,platform]
  lbls <- rownames(Data)
  pct <- round(slices/sum(slices)*100) # calculate percentages
  lbls <- paste(lbls, pct) # add percentages to labels
  lbls <- paste(lbls,"%",sep="") # ad "%" sign to labels
  pie(slices,labels = lbls,
      col = c("goldenrod3","salmon3"),
      main = colnames(Data)[platform],
      cex=1.3
  )
}

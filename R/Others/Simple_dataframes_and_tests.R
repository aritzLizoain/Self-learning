# Steps:
#   1) Read the data
#   2) Form meaningful subgroups of the data
#   3) Perform χ² and Fisher tests
#   4) Determine the effect sizes using Cramérs V


# 1) Read the CSV file

Data <- read.csv (file.choose(), header = TRUE, row.names = 1, sep = ",")
# Function arguments:
#   * file.choose() --- choose the file
#   * header = TRUE --- read the header because the file contains the names of the variables as its first line
#   * row.names = 1 --- determine the number giving the column of the table which contains the row names
#   * sep = "," ------- the field separator character. Values on each line of the file are separated by this character


# 2) Form meaningful subgroups of the data. We want to know:

A <- Data[c(1,2),]
B <- Data[c(3,4),]
c1 <- Data[1][1:2,]
c2 <- Data[1][3:4,]
C <- data.frame(c1 = c1,
                c2 = c2,
                row.names = c("bestanden", "nichtbestanden"))
d1 <- Data[2][1:2,]
d2 <- Data[2][3:4,]
D <- data.frame(d1 = d1,
                d2 = d2,
                row.names = c("bestanden", "nichtbestanden"))


# 3) Perform χ² and Fisher tests

chisq.test(A)
chisq.test(B)
chisq.test(C)
chisq.test(D)
# Output: the probability (p) is below the standard significance level of 5% for all tests.

fisher.test(A)
fisher.test(B)
fisher.test(C)
fisher.test(D)


# 4) Determine the effect sizes using Cramérs V

# Install and load the lsr package which contains the cramersV() function
install.packages ("lsr")
library ("lsr")

cramersV(A) # Output (approx.): 0.02 --- very low effect 
cramersV(B) # Output (approx.): 0.08 --- very low effect
cramersV(C) # Output (approx.): 0.11 --- very low effect
cramersV(D) # Output (approx.): 0.06 --- very low effect


# EXTRA
# What is shown here? What do the individual attributes control?
plot (Data, pch = c (17,13), col = c ("darkgreen", "red"), cex = 2.5)

# Here the values of both the A and B are shown
# The nichtbestanden are identified by the red crosses
# The bestanden are identified by the green triangles
# The x axis defines the data for 1
# The y axis defines the data for 2
# In this plot we cannot know which sign corresponds to which year

# The attributes are the following:
#   * (Data) --- data to plot (a matrix in this case)
#   * pch ------ specification of symbols to use when plotting points. See all symbols here: https://www.google.com/search?q=r+plot+symbols&sxsrf=ALeKk02anCqZpqj1OGC61z5891V07ukUJQ:1622572195181&tbm=isch&source=iu&ictx=1&fir=lUw3nrgRKV8ynM%252CwN4QLuW8o2uXJM%252C_&vet=1&usg=AI4_-kQvsDmP3nwDK5S-ZmuPhRNqsEcM2w&sa=X&ved=2ahUKEwjEnsO6iPfwAhUKtRoKHe6aD7oQ9QF6BAgTEAE&biw=1536&bih=754#imgrc=lUw3nrgRKV8ynM
#   * col ------ plotting colors (two colors in this case, specified in a vector)
#   * cex ------ number indicating the amount by which plotting text and symbols should be scaled relative to the default. 1=default, 1.5 is 50% larger, 0.5 is 50% smaller, etc.

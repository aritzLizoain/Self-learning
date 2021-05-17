# Following: https://www.analyticsvidhya.com/blog/2016/02/complete-tutorial-learn-data-science-scratch/#three

# --------------------------------------------------------------------------------------------------------------
# SETUP WORKING DIRECTORY
# --------------------------------------------------------------------------------------------------------------
# Check working directory: getwd()
# Set working directory (do it only once)
# path <- "GitGub/Self-learning/R/BigMartSalesPrediction"
# setwd(path)

# --------------------------------------------------------------------------------------------------------------
# LOAD DATA
# --------------------------------------------------------------------------------------------------------------
# Load Datasets
train <- read.csv("Train.csv")
test <- read.csv("Test.csv")

# Check dimesions ( number of row & columns) in data set
dim(train)

# Check if the data has missing values
table(is.na(train))
# Check variables in which these values are missing
colSums(is.na(train))

# Get more inferences from the data
summary(train)
# Issues in the training data:
#   * Item_Fat_Content has mis-matched factor levels.
#   * Minimum value of item_visibility is 0. Practically, this is not possible. If an item occupies shelf space in a grocery store, it ought to have some visibility. We’ll treat all 0’s as missing values.
#   * Item_Weight has 1463 missing values (already explained above).
#   * Outlet_Size has a unmatched factor levels.

# --------------------------------------------------------------------------------------------------------------
# GRAPHICAL REPRESENTATION OF VARIABLES (Bivariate analysis)
# --------------------------------------------------------------------------------------------------------------
# Install ggplot1
# install.packages("tidyverse")
# install.packages("ggplot2")
# Load the library
library(ggplot2)

# points
plot <- ggplot(train, aes(x= Item_Visibility, y = Item_Outlet_Sales)) + geom_point(size = 2.5, color="navy") + xlab("Item Visibility") + ylab("Item Outlet Sales") + ggtitle("Item Outlet Sales vs. Item Visibility")
print(plot)

# bars
plot2 <- ggplot(train, aes(Outlet_Identifier, Item_Outlet_Sales)) + geom_bar(stat = "identity", color = "salmon") +theme(axis.text.x = element_text(angle = 70, vjust = 0.5, color = "navy"))  + ggtitle("Outlet vs Total Sales") + theme_bw()
print(plot2)

# bars2
plot3 <- ggplot(train, aes(Item_Type, Item_Outlet_Sales)) + geom_bar( stat = "identity", color = "salmon") +theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, color = "navy")) + xlab("Item Type") + ylab("Item Outlet Sales")+ggtitle("Item Type vs Sales")
print(plot3)

# box plot chart
plot4 <- ggplot(train, aes(Item_Type, Item_MRP)) +geom_boxplot(color = 'salmon') +ggtitle("Box Plot") + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, color = "black")) + xlab("Item Type") + ylab("Item MRP") + ggtitle("Item Type vs Item MRP")
print(plot4)

# --------------------------------------------------------------------------------------------------------------
# IMPUTE MISSING/WRONG VALUES
# --------------------------------------------------------------------------------------------------------------
# First combine the datasets (dataframes)
# Train has 12 columns and test 11 (Item_Outlet_Sales missing)
test['Item_Outlet_Sales'] <- 1
# OR: test$Item_Outlet_Sales <-  1
all_data <- rbind(train, test)

# Impute missing values (only appearing in Item_Weight) by median of corresponding column
all_data$Item_Weight[is.na(all_data$Item_Weight)] <- median(all_data$Item_Weight, na.rm = TRUE)

# Impute wrong continuous (= non-categorical) values (only appearing in Item_Visibility, where we find value 0) by median of corresponding column
# A <- ifelse(a == 0, x, y). A[i] takes value x if a == 0 TRUE, and value y if a == 0 FALSE.
all_data$Item_Visibility <- ifelse(all_data$Item_Visibility == 0,
                                median(all_data$Item_Visibility), all_data$Item_Visibility) 

# --------------------------------------------------------------------------------------------------------------
# OTHER SECTIONS
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# OTHER SECTIONS
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# OTHER SECTIONS
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# OTHER SECTIONS
# --------------------------------------------------------------------------------------------------------------




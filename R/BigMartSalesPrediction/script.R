# Following: https://www.analyticsvidhya.com/blog/2016/02/complete-tutorial-learn-data-science-scratch/#three

# Check working directory: getwd()
# Set working directory (do it only once)
# path <- ".R/Self-learning/BigMartSalesPrediction"
# setwd(path)

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
summary(data)
# Issues in the training data:
#   * Item_Fat_Content has mis-matched factor levels.
#   * Minimum value of item_visibility is 0. Practically, this is not possible. If an item occupies shelf space in a grocery store, it ought to have some visibility. We’ll treat all 0’s as missing values.
#   * Item_Weight has 1463 missing values (already explained above).
#   * Outlet_Size has a unmatched factor levels.




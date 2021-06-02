# Following: https://www.analyticsvidhya.com/blog/2016/02/complete-tutorial-learn-data-science-scratch/#three

# --------------------------------------------------------------------------------------------------------------
# SETUP WORKING DIRECTORY
# --------------------------------------------------------------------------------------------------------------
# Set working directory
current_path = getwd()
path <- "GitHub/Self-learning/R/BigMartSalesPrediction"
if (grepl(path, current_path, fixed = TRUE)){
  print('Working directory was already set')
} else {
  setwd(path)
}

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
# Install ggplot2
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

# Correct mismatched categorical levels
# Outlet_Size "" convert to "Other"
levels(all_data$Outlet_Size)[1] <- "Other"
# Correct "LF", "low fat" and "Low Fat", and "reg" and "Regular" to "Low Fat" and "Regular"
# Install plyr
# install.packages("plyr")
# Load the library
library(plyr)
all_data$Item_Fat_Content = revalue(all_data$Item_Fat_Content, c("LF" = "Low Fat", "low fat" = "Low Fat", "reg" = "Regular"))

# --------------------------------------------------------------------------------------------------------------
# DATA MANIPULATION - FEATURE ENGINEERING
# --------------------------------------------------------------------------------------------------------------
# Install dplyr
# install.packages("dplyr")
# Load the library
library(dplyr)

# Count of Outlet Identifiers
outlets <- all_data%>%group_by(all_data$Outlet_Identifier)%>%tally()
# OR outlets <- tally(group_by(all_data, all_data$Outlet_Identifier))
# Rename the second column of the table as "Outlet_Count"
names(outlets) <- c("Outlet_Identifier", "Outlet_Count")
# Add it to the data
all_data <- full_join(outlets, all_data, by = "Outlet_Identifier")

# Count of Item Identifiers (same as above)
items <- all_data%>%group_by(Item_Identifier)%>%tally()
names(items)[2] <- "Item_Count"
all_data <- full_join(items, all_data, by = "Item_Identifier")

# Outlet years
current_year <- 2021
outlet_age <- all_data%>%select(Outlet_Establishment_Year)%>%mutate(Outlet_Year = current_year - all_data$Outlet_Establishment_Year)
# OR mutate(select(all_data, Outlet_Establishment_Year), Outlet_Year = current_year - all_data$Outlet_Establishment_Year)
all_data <- full_join(all_data, outlet_age)

# In Item_Types "FD" correspods to food, "DR" to drinks and "NC" to non-consumable
# Use substr(), gsub() functions to extract and rename the variables respectively
code <- substr(all_data$Item_Identifier, 1, 2)
code <- gsub("FD", "Food", code)
code <- gsub("DR", "Drinks", code)
code <- gsub("NC", "Non-Consumable", code)
# with vectors doesn't work code <- gsub(c("FD", "DR", "NC"), c("Food", "Drinks", "Non-Consumable"), code) X
# Add the new info with a variable name "Item_description"
all_data$Item_Description <- code

# --------------------------------------------------------------------------------------------------------------
# LABEL ENCODING AND ONE HOT ENCODING
# --------------------------------------------------------------------------------------------------------------
# Label encoding: numerically encode Item_Fat_Content levels ("Low Fat" and "Regular") to 0, 1
all_data$Item_Fat_Content <- ifelse(all_data$Item_Fat_Content == 'Regular', 1, 0)

print(dim(train))
print(dim(test))

# One Hot Encoding for Outlet_Size, Outlet_Location_Type, Outlet_Type, Item_description
# install.packages("caret")
library(caret)
# Take useful features
# Item_Count, Outlet_Count, Item_Weight, Item_Fat_Content, Item_Visibility, Item_MRP, Item_Outlet_Sales, Outlet_Year unchanged
# Outlet_Size, Outlet_Location_Type, Outlet_Type, Item_Description one-hot encoded
# Item_Identifier, Outlet_Identifier, Item_Type, Outlet_Establishment_Year removed
useless_features <- c("Item_Identifier", "Outlet_Identifier", "Item_Type", "Outlet_Establishment_Year") 
useful_data <- select(all_data, -all_of(useless_features)) # or select(all_data, +useful_features)
dummy <- dummyVars(" ~ .", data=useful_data)
encoded_data <- data.frame(predict(dummy, newdata = useful_data))

# More one-hot encoding options: https://datatricks.co.uk/one-hot-encoding-in-r-three-simple-methods

# Divide the dataset (remember we combined train and test before) for training and testing
new_train <- encoded_data[1:nrow(train),]
new_test <- encoded_data[-(1:nrow(train)),]

# --------------------------------------------------------------------------------------------------------------
# PREDICTIVE MODELING WITH MACHINE LEARNING - First LINEAR (MULTIPLE) REGRESSION
# --------------------------------------------------------------------------------------------------------------
# Had the response variable been categorical, we would use Logistic Regression

# Build out first regression model on this data set
linear_model <- lm(Item_Outlet_Sales ~ ., data = new_train)

# Adjusted R² measures the goodness of fit of a regression model. Higher the R², better is the model. 
summary(linear_model)
# New variables aren’t helping much i.e. Item count, Outlet Count and Item_Type_New. 
# Neither of these variables are significant. Significant variables are denoted by ‘*’ sign.
# In this case, significant variables: (Intercept), Outlet_Count, Item_Weight, Item_Visibility, Item_MRP, Outlet_Size.Other

# Correlated predictor variables brings down the model accuracy. 
# Find out the amount of correlation present in our predictor variables.
cor(new_train)
# In the long list of correlation coefficients, you can find a deadly correlation coefficient:
cor(new_train$Outlet_Count, new_train$Outlet_Type.Grocery.Store) # Output: -0.999537
# Outlet_Count is highly correlated (negatively) with Outlet Type Grocery Store.

# Issues with this model:
#   * There are highly correlated predictor variables
#   * Doing one hot and label encoding was actually not necessary, since linear regression handles categorical variables by creating dummy variables intrinsically
#   * The new variables created in feature engineering are not significant

# --------------------------------------------------------------------------------------------------------------
# Robust LINEAR (MULTIPLE) REGRESSION
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# DECISION TREES
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# RANDOM FOREST
# --------------------------------------------------------------------------------------------------------------

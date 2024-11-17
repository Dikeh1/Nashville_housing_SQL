
## Nashville Housing Data for Data Cleaning using SQL Server

![housing](https://github.com/user-attachments/assets/73a97a7d-dd33-4543-a301-676a898635ed)

#### In this Project we take raw housing data and transform it in SQL Server to make it more usable for analysis. Some of the steps taken in cleaning the data are as follows:

#### 1. Standardize Date Format: The date column was formatted in a way that is consistent and suitable for analysis

#### 2. Populate Property Address Data: To prepare the address column for analysis, we first checked for missing data (NULL values). We filled these gaps by joining the data to itself using the 'ParcelID' as a reference. The dataset was then updated. We then proceeded to split the address column into separate columns for 'Address', 'City', and 'State'..

#### 3. Changing Y and N to 'yes' and 'no' in 'SoldAsVacant' Column: We used a CASE statement to convert the data in the 'SoldAsVacant' column into the desired format of 'yes' and 'no'.

#### 4. Remove Duplicates: We identified duplicate data in the Nashville housing data using the ROW_NUMBER() function and the PARTITION BY clause. These duplicates were then deleted.

#### 5. Delete Unused Columns: While deleting columns is generally not recommended, for the sake of this project, we removed unused columns to maintain a clean format suitable for further analysis and visualization.

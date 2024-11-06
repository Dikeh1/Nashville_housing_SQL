## Nashville Housing Data for Data Cleaning using SQL Server

![housing](https://github.com/user-attachments/assets/73a97a7d-dd33-4543-a301-676a898635ed)

#### In this Project we take raw housing data and transform it in SQL Server to make it more usable for analysis. Some of the steps taken in cleaning the data are as follows:

#### **1. Standardize Date format** : The date column was set in the write format that would be useful for analysis

#### **2. Populate Property Address data**: Inorder to make the address column ready for analysis, We began by checking for incomplete data ('NULL' values). We populated this spaces by joining the data to itself using the 'ParcelID' as a reference point. The dataset was updated. We then proceeded to break down the address column into individual columns including 'Address', 'City' and 'State'.

#### **3. Changing Y and N into 'yes' and 'no' in 'SoldAsVacant' column**: The Case statement was used to to change data into the appriopriate format in the 'SoldAsVacant' column 

#### **4. Remove duplicate**: ROW_NUMBER() and Partition by clause were used to identify duplicate data in the Nashville housing data. These data were deleted afterwards.

#### **5. Delete Unused Columns**: Although, this methd is not usually advised, but for the sake of the project, we deleted the unused columns and kept the the cleaned format which can then be used for futher analysis and visualization

--preview dataset
select *
FROM [Portfolio project].[dbo].[NashvilleHousing]

--standardize date format

select SaleDate
FROM [Portfolio project].[dbo].[NashvilleHousing]

select SaleDate, convert(date, SaleDate)
FROM [Portfolio project].[dbo].[NashvilleHousing]

Update NashvilleHousing
set SaleDate = convert(date, SaleDate)

alter table NashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing
set SaleDateConverted = convert(date, SaleDate)

select SaleDateConverted, convert(date, SaleDate)
FROM [Portfolio project].[dbo].[NashvilleHousing]

--poplate poperty address data

select PropertyAddress
FROM [Portfolio project].[dbo].[NashvilleHousing] 

select PropertyAddress
FROM [Portfolio project].[dbo].[NashvilleHousing] 
where PropertyAddress is null

select *
FROM [Portfolio project].[dbo].[NashvilleHousing]
where PropertyAddress is null

--since the propertyaddress hardly changes, we can populate the null values using ParcelID

select *
FROM [Portfolio project].[dbo].[NashvilleHousing]
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Portfolio project].[dbo].[NashvilleHousing] a
join [Portfolio project].[dbo].[NashvilleHousing] b
    on a.ParcelID = b.ParcelID
    And a.[UniqueID]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Portfolio project].[dbo].[NashvilleHousing] a
join [Portfolio project].[dbo].[NashvilleHousing] b
    on a.ParcelID = b.ParcelID
    And a.[UniqueID]<> b.[UniqueID ]
where a.PropertyAddress is null

--Breaking ut address into individual columns (Address, city, state)

select PropertyAddress
FROM [Portfolio project].[dbo].[NashvilleHousing] 

select SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM [Portfolio project].[dbo].[NashvilleHousing] 

alter table [Portfolio project].[dbo].[NashvilleHousing] 
add PropertySplitAddress Varchar (255);

Update [Portfolio project].[dbo].[NashvilleHousing] 
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

alter table [Portfolio project].[dbo].[NashvilleHousing] 
add PropertySplitCity Varchar (255);

Update [Portfolio project].[dbo].[NashvilleHousing] 
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

select *
from [Portfolio project].[dbo].[NashvilleHousing] 

select OwnerAddress
from [Portfolio project].[dbo].[NashvilleHousing] 

select 
PARSENAME(replace(ownerAddress, ',', '.'), 3),
PARSENAME(replace(ownerAddress, ',', '.'), 2),
PARSENAME(replace(ownerAddress, ',', '.'), 1)
from [Portfolio project].[dbo].[NashvilleHousing] 

alter table [Portfolio project].[dbo].[NashvilleHousing] 
add OwnerSplitAddress Varchar (255);

Update [Portfolio project].[dbo].[NashvilleHousing] 
set OwnerSplitAddress = PARSENAME(replace(ownerAddress, ',', '.'), 3)

alter table [Portfolio project].[dbo].[NashvilleHousing] 
add OwnerSplitCity Varchar (255);

Update [Portfolio project].[dbo].[NashvilleHousing] 
set OwnerSplitCity = PARSENAME(replace(ownerAddress, ',', '.'), 2)

alter table [Portfolio project].[dbo].[NashvilleHousing] 
add OwnerSplitState Varchar (255);

Update [Portfolio project].[dbo].[NashvilleHousing] 
set OwnerSplitState = PARSENAME(replace(ownerAddress, ',', '.'), 1)

select *
from [Portfolio project].[dbo].[NashvilleHousing] 

-- CHANGE Y AND N TO YES AND NO IN 'Sold as Vacant' field

select distinct (SoldAsVacant)
from [Portfolio project].[dbo].[NashvilleHousing] 

select distinct (SoldAsVacant), count(SoldASVacant)
from [Portfolio project].[dbo].[NashvilleHousing] 
group by SoldAsVacant
order by 2

select SoldAsVacant,
    CASE when SoldAsVacant ='Y' THEN 'Yes'
	     when SoldAsVacant ='N' THEN 'No'
		 Else SoldAsVacant
		 END
from [Portfolio project].[dbo].[NashvilleHousing] 

update [Portfolio project].[dbo].[NashvilleHousing] 
set SoldAsVacant =    CASE when SoldAsVacant ='Y' THEN 'Yes'
	     when SoldAsVacant ='N' THEN 'No'
		 Else SoldAsVacant
		 END

-- REMOVE DUPLICATE

With RowNumCTE as (select *,
    ROW_NUMBER() OVER(
	Partition by ParcelID,
				 Propertyaddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by UniqueID) row_num
from [Portfolio project].[dbo].[NashvilleHousing])
select *
from RowNumCTE 
where row_num >1

With RowNumCTE as (select *,
    ROW_NUMBER() OVER(
	Partition by ParcelID,
				 Propertyaddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by UniqueID) row_num
from [Portfolio project].[dbo].[NashvilleHousing])
Delete
from RowNumCTE 
where row_num >1


-- DELETE UNUSED COLUMNS

select *
from [Portfolio project].[dbo].[NashvilleHousing]

alter table [Portfolio project].[dbo].[NashvilleHousing]
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
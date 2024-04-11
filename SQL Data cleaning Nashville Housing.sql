--Standardised date format

Select *
FROM Portfolio.dbo.Nashville_Housing

SELECT SaleDate,Convert(Date,SaleDate) as SaleDateConverted
From Portfolio.dbo.Nashville_Housing
ALTER TABLE Nashville_Housing
Add SaleDateConverted DATE;
Update Nashville_Housing
Set SaleDateConverted = CONVERT(date,SaleDate)


--Populate Property Address data

Select *
FROM Portfolio.dbo.Nashville_Housing
--WHERE PropertyAddress is null
order by ParcelID

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio.dbo.Nashville_Housing a
JOIN Portfolio.dbo.Nashville_Housing b
     ON a.ParcelID = b.ParcelID
	 AND a.[UniqueID ]<>b.[UniqueID ]
	 WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio.dbo.Nashville_Housing a
JOIN Portfolio.dbo.Nashville_Housing b
     ON a.ParcelID = b.ParcelID
	 AND a.[UniqueID ]<>b.[UniqueID ]
	 WHERE a.PropertyAddress is null


--Breaking out Address into individual columns(Address,City,State)

Select PropertyAddress
FROM Portfolio.dbo.Nashville_Housing
--WHERE PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as Address
FROM Portfolio.dbo.Nashville_Housing

ALTER TABLE Nashville_Housing
Add PropertySplitAddress Nvarchar(250) 

Update Nashville_Housing
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 

ALTER TABLE Nashville_Housing
Add PropertySplitCity Nvarchar(250) 

Update Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))


Select *
FROM Portfolio.dbo.Nashville_Housing

Select OwnerAddress
FROM Portfolio.dbo.Nashville_Housing

Select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),PARSENAME(REPLACE(OwnerAddress,',','.'),2),PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM Portfolio.dbo.Nashville_Housing

ALTER TABLE Nashville_Housing
ADD OwnerSplitAddress Nvarchar(255)

UPDATE Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE Nashville_Housing
ADD OwnerSplitCity Nvarchar(255)

UPDATE Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE Nashville_Housing
ADD OwnerSplitState Nvarchar(255)

UPDATE Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

Select *
FROM Portfolio.dbo.Nashville_Housing


--Change Y and N and No in "Sold as Vacant" field

SELECT Distinct(SoldAsVacant),COUNT(SoldAsVacant)
FROM Portfolio.dbo.Nashville_Housing
Group by SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
     WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END
FROM Portfolio.dbo.Nashville_Housing

UPDATE Nashville_Housing
SET SoldAsVacant=CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
     WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END


--Remove Duplicates

WITH RowNumCTE AS 
(Select *,
       ROW_NUMBER() OVER(
	   PARTITION BY ParcelID,
	                PropertyAddress,
					SaleDate,
					SalePrice,
					LegalReference
				ORDER BY UniqueID
				) Row_num
FROM Portfolio.dbo.Nashville_Housing
--ORDER BY ParcelID
) 
--(SELECT *
--FROM  RowNumCTE
--WHERE Row_num > 1
--ORDER BY PropertyAddress)
DELETE--(NOT TO BE DONE ON REAL DATA)
FROM  RowNumCTE
WHERE Row_num > 1


--DELETE UNUSED COLUMNS


SELECT *
FROM Portfolio.dbo.Nashville_Housing

ALTER TABLE Portfolio.dbo.Nashville_Housing
DROP COLUMN OwnerAddress,TaxDistrict,PropertyAddress

ALTER TABLE Portfolio.dbo.Nashville_Housing
DROP COLUMN SaleDate

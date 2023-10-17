--Cleaning the data
Select * From NashvilleHousing

--First we convert de date 
Select SaleDate, CONVERT (Date, Saledate) As FormatedDate
From NashvilleHousing 
--We apply this change to the data table 
ALTER TABLE NashvilleHousing ALTER COLUMN SaleDate DATE
Select SaleDate From NashvilleHousing

--Populate the property Address data when 2 have the same Parcell ID
Select * From NashvilleHousing Where PropertyAddress is NULL

Select * From NashvilleHousing Where PropertyAddress is NULL order by ParcelID 

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, Isnull(a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is Null

Update a
Set ParcelID = Isnull (a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is Null

--Breaking out address info into: (Address, City and State) with substrings and character index

Select PropertyAddress
From NashvilleHousing

Select Substring(PropertyAddress, 1, Charindex(',',PropertyAddress)-1) as Address
, Substring(PropertyAddress, Charindex(',',PropertyAddress)+1, Len(PropertyAddress)) as Address2
From NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);
Update NashvilleHousing
Set PropertySplitAddress = Substring(PropertyAddress, 1, Charindex(',',PropertyAddress)-1) 

Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);
Update NashvilleHousing
Set PropertySplitCity = Substring(PropertyAddress, Charindex(',',PropertyAddress)+1, Len(PropertyAddress))

Select * 
FRom NashvilleHousing

--Breaking out Owner address using parsename

Select
PARSENAME(Replace(OwnerAddress, ',', '.'),3)
,PARSENAME(Replace(OwnerAddress, ',', '.'),2)
,PARSENAME(Replace(OwnerAddress, ',', '.'),1)
from NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'),3)

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'),2)

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'),1)

-- Change Y and N for Yes and No in "Sold as vacant"
Select Distinct (SoldAsVacant), COUNT (SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,Case When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	End
From NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	End

Select Distinct (SoldAsVacant), COUNT (SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
Order by 2

--Remove Duplicates using CTE

With RowNumCTE as(
Select *,
Row_number() Over (
	Partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	Order by UniqueID)
	row_nums

From NashvilleHousing
)

--Select*
Delete
From RowNumCTE
where row_nums > 1
--Order by PropertyAddress

-- Delete unsused columns

Select*
From NashvilleHousing
Alter table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress



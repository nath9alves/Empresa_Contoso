SELECT productkey,
productname,
DimProductSubcategory.ProductSubcategoryKey,
productsubcategoryname,
DimProductSubcategory.ProductCategoryKey,
DimProductCategory.ProductCategoryName
FROM DimProduct
INNER JOIN DimProductSubcategory
ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
INNER JOIN DimProductCategory
ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey ------ > Consulta com INNER JOIN 

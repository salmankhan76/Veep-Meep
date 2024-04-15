class ProductServiceEntity {
  String? productName;
  String? slogan;
  String productDescription;
  String? country;
  String? province;
  String? city;
  String? productType;
  String? nabourhoodName;

  ProductServiceEntity({
    this.productName,
    this.country,
    this.province,
    this.city,
    this.slogan,
    this.productDescription = '',
    this.productType,
    this.nabourhoodName,
  });
}

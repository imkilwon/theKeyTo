class ProductModel {
  final String url;
  final String productName;
  final int cost;
  final String category;
  final String context;
  final String sellerName;
  final String sellerUid;
  String productId;

  ProductModel({
    required this.url,
    required this.productName,
    required this.cost,
    required this.category,
    required this.context,
    required this.sellerName,
    required this.sellerUid,
    this.productId = '',
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'productName': productName,
      'cost': cost,
      'category':category,
      'context':context,
      'productId' : productId,
      'sellerName' : sellerName,
      'sellerUid' : sellerUid,

    };
  }

  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      url: json["url"],
      productName: json["productName"],
      cost: json["cost"],
      category: json["category"],
      context: json["context"],
      productId: json["productId"],
      sellerName: json["sellerName"],
      sellerUid: json["sellerUid"],
    );
  }}
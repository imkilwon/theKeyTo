class ProductModel {
  final String url;
  final String productName;
  final int cost;
  final String category;
  final String context;
  final String sellerName;
  final String sellerUid;
  final int buyCnt;//구매 건수
  final int favorite; //찜 수
  final int year;
  final int month;
  final int day;
  
  String productId;

  ProductModel({
    required this.url,
    required this.productName,
    required this.cost,
    required this.category,
    required this.context,
    required this.sellerName,
    required this.sellerUid,
    required this.buyCnt,
    required this.favorite,
    required this.year,
    required this.month,
    required this.day,
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
      'buyCnt' : buyCnt,
      'favorite':favorite,
      'year':year,
      'month':month,
      'day':day,
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
      buyCnt: json["buyCnt"],
      favorite: json["favorite"],
      year: json["year"],
      month: json["month"],
      day: json["day"],
    );
  }}
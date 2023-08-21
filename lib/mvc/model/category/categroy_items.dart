class Category {
  String? categoryName;
  int? cid;
  String? iconUrl;
  bool? isCustom;
  String? uid;

  Category.fromMap(Map<String, dynamic> items) {
    categoryName = items['categoryName'];
    cid = items['cid'];
    iconUrl = items['iconUrl'];
    isCustom = items['isCustom'];
    uid = items['uid'];
  }
}
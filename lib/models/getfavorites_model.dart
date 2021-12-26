
class GetFavoritesModel{
  bool? status;
  String? message;
  FavoritesDataModel? data;

  GetFavoritesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=FavoritesDataModel.fromJson(json['data']);
  }

}

class FavoritesDataModel{
  int? current_page;
  List<DataFavModel> data=[];
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  String? next_page_url;
  String? path;
  int? per_page;
  String? perv_page_url;
  int? to;
  int? total;

  FavoritesDataModel.fromJson(Map<String,dynamic>json){
    current_page=json['current_page'];

    json['data'].forEach((element){
      data.add(DataFavModel.fromJson(element));
    });

    first_page_url=json['first_page_url'];
    from=json['from'];
    last_page=json['last_page'];
    last_page_url=json['last_page_url'];
    next_page_url=json['next_page_url'];
    path=json['path'];
    per_page=json['per_page'];
    perv_page_url=json['perv_page_url'];
    to=json['to'];
    total=json['total'];

  }

}

class DataFavModel{
  int? id;
  late DataProFavModel product;

  DataFavModel.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    product=DataProFavModel.fromJson(json['product']);
  }
}

class DataProFavModel{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  DataProFavModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
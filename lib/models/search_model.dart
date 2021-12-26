
class SearchModel{
  bool? status;
  String? message;
  DataModel? data;

  SearchModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=DataModel.fromJson(json['data']);
  }

}

class DataModel{
  List<DataProModel> data=[];


  DataModel.fromJson(Map<String,dynamic>json){

    json['data'].forEach((element){
      data.add(DataProModel.fromJson(element));
    });
  }
}


class DataProModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  String? image;
  dynamic discount;
  String? name;
  String? description;

  DataProModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    discount = json['discount'];
    name = json['name'];
    description = json['description'];
  }
}
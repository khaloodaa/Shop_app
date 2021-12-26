
class CategoriesModel{
  bool? status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
  late int current_page;
  List<DataModel> data=[];
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

  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    current_page=json['current_page'];

    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
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

class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}
abstract class DataModel {
  DataModel();
  
  Map<String, dynamic> toMap();

  String toJson();

  DataModel.fromMap(Map<String, dynamic> map);

  DataModel.fromJson(String source);
}

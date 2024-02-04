class ModelClass {
  int? id;
  String? name;
  String? image;
  String? url;

  ModelClass({this.id, this.name, this.image, this.url});

  ModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String image;
  final String about;
  final String lastSeen;
  final String pushToken;
  final bool online;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.about,
    required this.lastSeen,
    required this.pushToken,
    required this.online,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      about: json['about'],
      lastSeen: json['last_seen'],
      pushToken: json['push_token'],
      online: json['online'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'image':image,
      'about':about,
      'last_seen':lastSeen,
      'push_token':pushToken,
      'online':online,
    };
  }
}
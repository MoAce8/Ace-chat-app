class GroupModel {
  final String id;
  final String name;
  final String img;
  final List members;
  final List admins;
  final String lastMessage;
  final String lastMessageTime;
  final String createdAt;


  GroupModel({
    required this.id,
    required this.name,
    required this.img,
    required this.members,
    required this.admins,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
  });

  factory GroupModel.fromJson(json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      img: json['image'],
      members: json['members'],
      admins: json['admins'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
      createdAt: json['created_at'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'image':img,
      'members':members,
      'admins':admins,
      'last_message':lastMessage,
      'last_message_time':lastMessageTime,
      'created_at':createdAt,
    };
  }
}

class MessageModel {
  final String id;
  final String fromId;
  final String toId;
  final String msg;
  final String createdAt;
  final String type;
  final bool read;

  MessageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.msg,
    required this.createdAt,
    required this.type,
    required this.read,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      id: json['id'],
      fromId: json['from_id'],
      toId: json['to_id'],
      msg: json['msg'],
      createdAt: json['created_at'],
      type: json['type'],
      read: json['read'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'from_id':fromId,
      'to_id':toId,
      'msg':msg,
      'created_at':createdAt,
      'type':type,
      'read':read,
    };
  }
}

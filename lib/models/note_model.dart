class NotesModel {
  String? uuid;
  String? name;
  String? message;
  String? timestamp;

  NotesModel({this.message, this.name, this.uuid, this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      uuid: json['uuid'],
      name: json['name'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}

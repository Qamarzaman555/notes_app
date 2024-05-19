class NotesModel {
  String? uuid;
  String? message;
  String? timestamp;

  NotesModel({this.message, this.uuid, this.timestamp});

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
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}

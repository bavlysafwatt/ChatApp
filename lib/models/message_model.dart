class MessageModel {
  final String text;
  final String senderEmail;
  final String recieverEmail;

  MessageModel({
    required this.text,
    required this.senderEmail,
    required this.recieverEmail,
  });

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      text: jsonData['message'],
      senderEmail: jsonData['senderEmail'],
      recieverEmail: jsonData['recieverEmail'],
    );
  }
}

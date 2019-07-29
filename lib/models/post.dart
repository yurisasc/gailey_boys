class Post {
  String id;
  String senderName;
  String senderImg;
  String senderId;
  DateTime timeStamp;
  String msg;

  Post(
      {this.id,
      this.senderName,
      this.senderImg,
      this.senderId,
      this.timeStamp,
      this.msg});

  factory Post.fromMap(Map data) {
    return Post(
      id: data['id'],
      msg: data['message'],
      timeStamp: data['timestamp'],
      senderId: data['user_id'],
      senderName: data['user_name'],
      senderImg: data['user_img'],
    );
  }
}
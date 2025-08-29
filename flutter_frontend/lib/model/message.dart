abstract class Message<T> {
  final String senderId;
  final DateTime createdAt;
  final T content;

  Message({
    required this.senderId,
    required this.createdAt,
    required this.content,
  });
}

class TextMessage extends Message<String> {
  TextMessage({
    required super.content,
    required super.senderId,
    required super.createdAt,
  });
}

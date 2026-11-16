class TicketModel {
  final int id;
  final String title;
  final String price;
  final String eventDate;

  TicketModel({
    required this.id,
    required this.title,
    required this.price,
    required this.eventDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      eventDate: json['event_date'] ?? '',
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/ticket_model.dart';

class TicketService {
  Future<List<TicketModel>> getTickets() async {
    final response = await http.get(Uri.parse(ApiConfig.ticketsUrl));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status'] == 'success') {
      final List list = data['data'];
      return list.map((e) => TicketModel.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat data tiket');
  }

  Future<bool> createTicket(String title, String price, String eventDate) async {
    final response = await http.post(
      Uri.parse(ApiConfig.ticketsUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'event_date': eventDate,
      }),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateTicket(int id, String title, String price, String eventDate) async {
    final response = await http.put(
      Uri.parse(ApiConfig.ticketsUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'title': title,
        'price': price,
        'event_date': eventDate,
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteTicket(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.ticketsUrl}?id=$id'),
    );
    return response.statusCode == 200;
  }
}

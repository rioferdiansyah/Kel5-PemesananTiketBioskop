import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/ticket_model.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../auth/login_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  final UserModel currentUser;
  const AdminDashboardScreen({super.key, required this.currentUser});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _ticketService = TicketService();
  final _authService = AuthService();

  List<TicketModel> _tickets = [];
  List<UserModel> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final tickets = await _ticketService.getTickets();
      final users = await _authService.getUsers();
      setState(() {
        _tickets = tickets;
        _users = users;
      });
    } catch (_) {}
    setState(() => _loading = false);
  }

  void _showTicketDialog({TicketModel? ticket}) {
    final titleCtrl = TextEditingController(text: ticket?.title ?? '');
    final priceCtrl = TextEditingController(text: ticket?.price ?? '');
    final dateCtrl = TextEditingController(text: ticket?.eventDate ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(ticket == null ? 'Tambah Tiket Baru' : 'Edit Tiket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Judul Event')),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Harga (misal: Rp 100.000)')),
            TextField(controller: dateCtrl, decoration: const InputDecoration(labelText: 'Tanggal (YYYY-MM-DD)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              if (ticket == null) {
                await _ticketService.createTicket(titleCtrl.text, priceCtrl.text, dateCtrl.text);
              } else {
                await _ticketService.updateTicket(ticket.id, titleCtrl.text, priceCtrl.text, dateCtrl.text);
              }
              if (!mounted) return;
              Navigator.pop(context);
              _loadData();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.confirmation_number), text: 'Kelola Tiket'),
              Tab(icon: Icon(Icons.people), text: 'Data Users & Admin'),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _authService.logout();
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showTicketDialog(),
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Tab 1: CRUD Tickets
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tickets.length,
                    itemBuilder: (_, i) {
                      final t = _tickets[i];
                      return Card(
                        child: ListTile(
                          title: Text(t.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${t.price}  •  ${t.eventDate}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showTicketDialog(ticket: t),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await _ticketService.deleteTicket(t.id);
                                  _loadData();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Tab 2: Monitoring Users & Admin
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _users.length,
                    itemBuilder: (_, i) {
                      final u = _users[i];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: u.isAdmin ? Colors.redAccent : Colors.blueGrey,
                            child: Icon(
                              u.isAdmin ? Icons.admin_panel_settings : Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(u.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(u.email),
                          trailing: Chip(
                            label: Text(u.role.toUpperCase()),
                            backgroundColor: u.isAdmin ? Colors.red.shade100 : Colors.grey.shade200,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

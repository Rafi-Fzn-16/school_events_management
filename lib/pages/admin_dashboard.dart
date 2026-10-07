import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/auth_service.dart';
import '../services/event_service.dart';
import '../widgets/event_card.dart';
import 'landing_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<EventModel> events = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final data = await EventService.getEvents();

    if (!mounted) return;

    setState(() {
      events = data;
      loading = false;
    });
  }

  Future<void> _logout() async {
    await AuthService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LandingPage(),
      ),
      (route) => false,
    );
  }

  Future<void> _showEventForm({EventModel? event}) async {
    final nameController =
        TextEditingController(text: event?.name ?? '');
    final dateController =
        TextEditingController(text: event?.date ?? '');
    final timeController =
        TextEditingController(text: event?.time ?? '');
    final locationController =
        TextEditingController(text: event?.location ?? '');
    final descriptionController =
        TextEditingController(text: event?.description ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event == null ? 'Add Event' : 'Edit Event'),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Event Name',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      hintText: 'YYYY-MM-DD',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: timeController,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      hintText: 'HH:MM',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) {
                  return;
                }

                final newEvent = EventModel(
                  id: event?.id ??
                      'event_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameController.text.trim(),
                  date: dateController.text.trim(),
                  time: timeController.text.trim(),
                  location: locationController.text.trim(),
                  description: descriptionController.text.trim(),
                );

                if (event == null) {
                  await EventService.addEvent(newEvent);
                } else {
                  await EventService.updateEvent(newEvent);
                }

                if (context.mounted) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(event == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    descriptionController.dispose();

    if (result == true) {
      _loadEvents();
    }
  }

  Future<void> _deleteEvent(EventModel event) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: Text(
            'Delete "${event.name}" and its participants?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await EventService.deleteEvent(event.id);
      _loadEvents();
    }
  }

  Future<void> _showParticipants(EventModel event) async {
    final participants =
        await EventService.getParticipants(event.id);

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Participants',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(event.name),
                  const SizedBox(height: 16),
                  if (participants.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'No students have registered yet.',
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: participants.length,
                        separatorBuilder: (_, __) =>
                            const Divider(),
                        itemBuilder: (context, index) {
                          final participant = participants[index];

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(participant.name),
                            subtitle: Text(
                              'Class: ${participant.studentClass}\n'
                              'Username: ${participant.username}',
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEventForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Event'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadEvents,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Total Events: ${events.length}'),
                  const SizedBox(height: 24),
                  if (events.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text('No events available.'),
                      ),
                    )
                  else
                    ...events.map(
                      (event) => EventCard(
                        event: event,
                        isAdmin: true,
                        onParticipants: () =>
                            _showParticipants(event),
                        onEdit: () => _showEventForm(event: event),
                        onDelete: () => _deleteEvent(event),
                        onChanged: _loadEvents,
                      ),
                    ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
    );
  }
}

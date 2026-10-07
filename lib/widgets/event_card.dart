import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final bool isAdmin;
  final VoidCallback? onChanged;
  final VoidCallback? onParticipants;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const EventCard({
    super.key,
    required this.event,
    required this.isAdmin,
    this.onChanged,
    this.onParticipants,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool registered = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _checkRegistration();
  }

  Future<void> _checkRegistration() async {
    if (widget.isAdmin) {
      setState(() => loading = false);
      return;
    }

    final result = await EventService.isRegistered(widget.event.id);

    if (mounted) {
      setState(() {
        registered = result;
        loading = false;
      });
    }
  }

  Future<void> _register() async {
    final success =
        await EventService.registerForEvent(widget.event.id);

    if (!mounted) return;

    setState(() => registered = success || registered);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Berhasil mendaftar ke event.'
              : 'Kamu sudah terdaftar di event ini.',
        ),
      ),
    );

    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _InfoRow(Icons.calendar_today, widget.event.date),
            _InfoRow(Icons.access_time, widget.event.time),
            _InfoRow(Icons.location_on, widget.event.location),
            const SizedBox(height: 10),
            Text(widget.event.description),
            const SizedBox(height: 16),
            if (widget.isAdmin)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: widget.onParticipants,
                    icon: const Icon(Icons.people),
                    label: const Text('Participants'),
                  ),
                  OutlinedButton.icon(
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: loading || registered ? null : _register,
                  icon: Icon(
                    registered ? Icons.check : Icons.how_to_reg,
                  ),
                  label: Text(
                    loading
                        ? 'Checking...'
                        : registered
                            ? 'Registered'
                            : 'Register',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 17),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

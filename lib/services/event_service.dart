import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import 'auth_service.dart';

class EventService {
  static const String _eventsKey = 'events';
  static const String _participantsKey = 'event_participants';

  static Future<List<EventModel>> getEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_eventsKey);

    if (data == null || data.isEmpty) {
      final defaults = [
        EventModel(
          id: 'event_1',
          name: 'Class Meeting',
          date: '2026-10-10',
          time: '09:00',
          location: 'Classroom',
          description: 'Class meeting and discussion.',
        ),
        EventModel(
          id: 'event_2',
          name: 'Student Expo',
          date: '2026-10-15',
          time: '10:00',
          location: 'School Hall',
          description: 'Student project exhibition.',
        ),
      ];

      await _saveEvents(defaults);
      return defaults;
    }

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => EventModel.fromMap(item)).toList();
  }

  static Future<void> _saveEvents(List<EventModel> events) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _eventsKey,
      jsonEncode(events.map((event) => event.toMap()).toList()),
    );
  }

  static Future<void> addEvent(EventModel event) async {
    final events = await getEvents();
    events.add(event);
    await _saveEvents(events);
  }

  static Future<void> updateEvent(EventModel event) async {
    final events = await getEvents();
    final index = events.indexWhere((item) => item.id == event.id);

    if (index != -1) {
      events[index] = event;
      await _saveEvents(events);
    }
  }

  static Future<void> deleteEvent(String id) async {
    final events = await getEvents();
    events.removeWhere((event) => event.id == id);
    await _saveEvents(events);

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_participantsKey);

    if (data != null) {
      final Map<String, dynamic> participants = jsonDecode(data);
      participants.remove(id);
      await prefs.setString(_participantsKey, jsonEncode(participants));
    }
  }

  static Future<bool> registerForEvent(String eventId) async {
    final student = await AuthService.getCurrentStudent();

    if (student == null) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_participantsKey);

    Map<String, dynamic> allParticipants = {};

    if (data != null && data.isNotEmpty) {
      allParticipants = jsonDecode(data);
    }

    final List<dynamic> participants =
        List<dynamic>.from(allParticipants[eventId] ?? []);

    if (participants.any((item) => item['username'] == student.username)) {
      return false;
    }

    participants.add({
      'name': student.name,
      'class': student.studentClass,
      'username': student.username,
    });

    allParticipants[eventId] = participants;
    await prefs.setString(
      _participantsKey,
      jsonEncode(allParticipants),
    );

    return true;
  }

  static Future<bool> isRegistered(String eventId) async {
    final username = await AuthService.getCurrentUsername();

    if (username == null) {
      return false;
    }

    final participants = await getParticipants(eventId);
    return participants.any((item) => item.username == username);
  }

  static Future<List<Participant>> getParticipants(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_participantsKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    final Map<String, dynamic> allParticipants = jsonDecode(data);
    final List<dynamic> participants =
        List<dynamic>.from(allParticipants[eventId] ?? []);

    return participants
        .map((item) => Participant.fromMap(item))
        .toList();
  }
}

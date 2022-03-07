part of 'notify_bloc.dart';

class NotifyEvent {
  EventType type = EventType.load;
  NotifyEvent.load() {
    type = EventType.load;
  }
}

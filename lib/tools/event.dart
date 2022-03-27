
abstract class Event {
  /// 目標對象
  dynamic getTarget();
}

class DefaultEvent extends Event {
  dynamic _target;
  dynamic _data;

  DefaultEvent(this._target, {dynamic data}) {
    this._data = data;
  }

  @override
  dynamic getTarget() {
    return _target;
  }

  dynamic getData() {
    return _data;
  }
}

typedef void EventFunc(Event event);

class EventManager {
  static Map<String, EventFunc> eventMap = Map();

  static void addEvent(String eventId, EventFunc eventFunc) {
    eventMap[eventId] = eventFunc;
  }

  static void removeEvent(String eventId) {
    eventMap.remove(eventId);
  }

  static void triggerEvent(String eventId, Event event) {
    if (eventMap[eventId] != null) {
      eventMap[eventId](event);
    } else {
      print("不存在事件【$eventId】！");
    }
  }
}

import 'package:uuid/uuid.dart';

abstract class Entity {
  final _uuid = const Uuid();

  Entity({String? id, DateTime? createdAt}) {
    id == null || id.isEmpty ? this.id = _uuid.v1() : this.id = id;
    createdAt == null ? _createdAt = DateTime.now() : _createdAt = createdAt;
  }

  String id = '';
  DateTime _createdAt = DateTime.now();

  get createdAt {
    DateTime formatedData = _createdAt.subtract(const Duration(hours: 3));
    return formatedData;
  }
}

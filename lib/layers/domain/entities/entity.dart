import 'package:uuid/uuid.dart';

abstract class Entity {
  final _uuid = const Uuid();

  Entity({String? id, DateTime? createdAt}) {
    id == null || id.isEmpty ? this.id = _uuid.v1() : this.id = id;
    createdAt == null
        ? this.createdAt = DateTime.now()
        : this.createdAt = createdAt;
  }

  String id = '';
  DateTime createdAt = DateTime.now();
}

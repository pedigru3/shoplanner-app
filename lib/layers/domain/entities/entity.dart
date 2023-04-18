// ignore_for_file: file_names

import 'package:uuid/uuid.dart';

abstract class Entity {
  final _uuid = const Uuid();

  Entity({this.id, this.createdAt}) {
    id == null ? id = _uuid.v1() : id = id;
    createdAt == null ? createdAt = DateTime.now() : createdAt = createdAt;
  }

  String? id;
  DateTime? createdAt;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String title,
    String? description,
    @Default('') String assignedToUserEmail, // email of user to whom task is assigned

    @Default('General') String category,
    @Default('pending') String status, 
    required DateTime startDate,
    required DateTime endDate,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

class TimestampConverter implements JsonConverter<Timestamp, dynamic> {
  const TimestampConverter();

  @override
  Timestamp fromJson(dynamic json) {
    if (json is Timestamp) return json;
    if (json is Map && json.containsKey('_seconds')) {
      return Timestamp(json['_seconds'] as int, json['_nanoseconds'] as int);
    }
    if (json is String) {
      return Timestamp.fromDate(DateTime.parse(json));
    }
    throw ArgumentError('Invalid timestamp format: $json');
  }

  @override
  dynamic toJson(Timestamp timestamp) => timestamp;
}

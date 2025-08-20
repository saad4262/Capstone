// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String? ?? '',
  userId: json['userId'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String?,
  assignedToUserEmail: json['assignedToUserEmail'] as String? ?? '',
  favouriteByUsers:
      (json['favouriteByUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  category: json['category'] as String? ?? 'General',
  status: json['status'] as String? ?? 'pending',
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  assignedUserTokens:
      (json['assignedUserTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'description': instance.description,
  'assignedToUserEmail': instance.assignedToUserEmail,
  'favouriteByUsers': instance.favouriteByUsers,
  'category': instance.category,
  'status': instance.status,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'assignedUserTokens': instance.assignedUserTokens,
  'position': instance.position,
};

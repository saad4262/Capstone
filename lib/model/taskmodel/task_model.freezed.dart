// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get userId; String get title; String? get description; String get assignedToUserEmail; List<String> get favouriteByUsers; String get category; String get status; DateTime get startDate; DateTime get endDate;@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt; List<String> get assignedUserTokens; int get position;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.assignedToUserEmail, assignedToUserEmail) || other.assignedToUserEmail == assignedToUserEmail)&&const DeepCollectionEquality().equals(other.favouriteByUsers, favouriteByUsers)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.assignedUserTokens, assignedUserTokens)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,description,assignedToUserEmail,const DeepCollectionEquality().hash(favouriteByUsers),category,status,startDate,endDate,createdAt,updatedAt,const DeepCollectionEquality().hash(assignedUserTokens),position);

@override
String toString() {
  return 'Task(id: $id, userId: $userId, title: $title, description: $description, assignedToUserEmail: $assignedToUserEmail, favouriteByUsers: $favouriteByUsers, category: $category, status: $status, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt, assignedUserTokens: $assignedUserTokens, position: $position)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String? description, String assignedToUserEmail, List<String> favouriteByUsers, String category, String status, DateTime startDate, DateTime endDate,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, List<String> assignedUserTokens, int position
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? assignedToUserEmail = null,Object? favouriteByUsers = null,Object? category = null,Object? status = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,Object? updatedAt = null,Object? assignedUserTokens = null,Object? position = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,assignedToUserEmail: null == assignedToUserEmail ? _self.assignedToUserEmail : assignedToUserEmail // ignore: cast_nullable_to_non_nullable
as String,favouriteByUsers: null == favouriteByUsers ? _self.favouriteByUsers : favouriteByUsers // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,assignedUserTokens: null == assignedUserTokens ? _self.assignedUserTokens : assignedUserTokens // ignore: cast_nullable_to_non_nullable
as List<String>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  String assignedToUserEmail,  List<String> favouriteByUsers,  String category,  String status,  DateTime startDate,  DateTime endDate, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  List<String> assignedUserTokens,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.assignedToUserEmail,_that.favouriteByUsers,_that.category,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt,_that.assignedUserTokens,_that.position);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  String assignedToUserEmail,  List<String> favouriteByUsers,  String category,  String status,  DateTime startDate,  DateTime endDate, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  List<String> assignedUserTokens,  int position)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.userId,_that.title,_that.description,_that.assignedToUserEmail,_that.favouriteByUsers,_that.category,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt,_that.assignedUserTokens,_that.position);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String? description,  String assignedToUserEmail,  List<String> favouriteByUsers,  String category,  String status,  DateTime startDate,  DateTime endDate, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  List<String> assignedUserTokens,  int position)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.assignedToUserEmail,_that.favouriteByUsers,_that.category,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt,_that.assignedUserTokens,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({this.id = '', this.userId = '', this.title = '', this.description, this.assignedToUserEmail = '', final  List<String> favouriteByUsers = const [], this.category = 'General', this.status = 'pending', required this.startDate, required this.endDate, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, final  List<String> assignedUserTokens = const [], this.position = 0}): _favouriteByUsers = favouriteByUsers,_assignedUserTokens = assignedUserTokens;
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String userId;
@override@JsonKey() final  String title;
@override final  String? description;
@override@JsonKey() final  String assignedToUserEmail;
 final  List<String> _favouriteByUsers;
@override@JsonKey() List<String> get favouriteByUsers {
  if (_favouriteByUsers is EqualUnmodifiableListView) return _favouriteByUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favouriteByUsers);
}

@override@JsonKey() final  String category;
@override@JsonKey() final  String status;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
 final  List<String> _assignedUserTokens;
@override@JsonKey() List<String> get assignedUserTokens {
  if (_assignedUserTokens is EqualUnmodifiableListView) return _assignedUserTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedUserTokens);
}

@override@JsonKey() final  int position;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.assignedToUserEmail, assignedToUserEmail) || other.assignedToUserEmail == assignedToUserEmail)&&const DeepCollectionEquality().equals(other._favouriteByUsers, _favouriteByUsers)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._assignedUserTokens, _assignedUserTokens)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,description,assignedToUserEmail,const DeepCollectionEquality().hash(_favouriteByUsers),category,status,startDate,endDate,createdAt,updatedAt,const DeepCollectionEquality().hash(_assignedUserTokens),position);

@override
String toString() {
  return 'Task(id: $id, userId: $userId, title: $title, description: $description, assignedToUserEmail: $assignedToUserEmail, favouriteByUsers: $favouriteByUsers, category: $category, status: $status, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt, assignedUserTokens: $assignedUserTokens, position: $position)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String? description, String assignedToUserEmail, List<String> favouriteByUsers, String category, String status, DateTime startDate, DateTime endDate,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, List<String> assignedUserTokens, int position
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? assignedToUserEmail = null,Object? favouriteByUsers = null,Object? category = null,Object? status = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,Object? updatedAt = null,Object? assignedUserTokens = null,Object? position = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,assignedToUserEmail: null == assignedToUserEmail ? _self.assignedToUserEmail : assignedToUserEmail // ignore: cast_nullable_to_non_nullable
as String,favouriteByUsers: null == favouriteByUsers ? _self._favouriteByUsers : favouriteByUsers // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,assignedUserTokens: null == assignedUserTokens ? _self._assignedUserTokens : assignedUserTokens // ignore: cast_nullable_to_non_nullable
as List<String>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

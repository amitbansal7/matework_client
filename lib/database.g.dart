// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Invite extends DataClass implements Insertable<Invite> {
  final int id;
  final String? message;
  final int createdAt;
  final int? userId;
  final String? userFirstName;
  final String? userLastName;
  final String? userAvatar;
  final bool seen;
  Invite(
      {required this.id,
      this.message,
      required this.createdAt,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.userAvatar,
      required this.seen});
  factory Invite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Invite(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      message:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}message']),
      createdAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      userFirstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_first_name']),
      userLastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_last_name']),
      userAvatar: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_avatar']),
      seen: boolType.mapFromDatabaseResponse(data['${effectivePrefix}seen'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String?>(message);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int?>(userId);
    }
    if (!nullToAbsent || userFirstName != null) {
      map['user_first_name'] = Variable<String?>(userFirstName);
    }
    if (!nullToAbsent || userLastName != null) {
      map['user_last_name'] = Variable<String?>(userLastName);
    }
    if (!nullToAbsent || userAvatar != null) {
      map['user_avatar'] = Variable<String?>(userAvatar);
    }
    map['seen'] = Variable<bool>(seen);
    return map;
  }

  InvitesCompanion toCompanion(bool nullToAbsent) {
    return InvitesCompanion(
      id: Value(id),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      createdAt: Value(createdAt),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      userFirstName: userFirstName == null && nullToAbsent
          ? const Value.absent()
          : Value(userFirstName),
      userLastName: userLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(userLastName),
      userAvatar: userAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(userAvatar),
      seen: Value(seen),
    );
  }

  factory Invite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Invite(
      id: serializer.fromJson<int>(json['id']),
      message: serializer.fromJson<String?>(json['message']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      userId: serializer.fromJson<int?>(json['userId']),
      userFirstName: serializer.fromJson<String?>(json['userFirstName']),
      userLastName: serializer.fromJson<String?>(json['userLastName']),
      userAvatar: serializer.fromJson<String?>(json['userAvatar']),
      seen: serializer.fromJson<bool>(json['seen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'message': serializer.toJson<String?>(message),
      'createdAt': serializer.toJson<int>(createdAt),
      'userId': serializer.toJson<int?>(userId),
      'userFirstName': serializer.toJson<String?>(userFirstName),
      'userLastName': serializer.toJson<String?>(userLastName),
      'userAvatar': serializer.toJson<String?>(userAvatar),
      'seen': serializer.toJson<bool>(seen),
    };
  }

  Invite copyWith(
          {int? id,
          String? message,
          int? createdAt,
          int? userId,
          String? userFirstName,
          String? userLastName,
          String? userAvatar,
          bool? seen}) =>
      Invite(
        id: id ?? this.id,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
        userAvatar: userAvatar ?? this.userAvatar,
        seen: seen ?? this.seen,
      );
  @override
  String toString() {
    return (StringBuffer('Invite(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('userFirstName: $userFirstName, ')
          ..write('userLastName: $userLastName, ')
          ..write('userAvatar: $userAvatar, ')
          ..write('seen: $seen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          message.hashCode,
          $mrjc(
              createdAt.hashCode,
              $mrjc(
                  userId.hashCode,
                  $mrjc(
                      userFirstName.hashCode,
                      $mrjc(userLastName.hashCode,
                          $mrjc(userAvatar.hashCode, seen.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Invite &&
          other.id == this.id &&
          other.message == this.message &&
          other.createdAt == this.createdAt &&
          other.userId == this.userId &&
          other.userFirstName == this.userFirstName &&
          other.userLastName == this.userLastName &&
          other.userAvatar == this.userAvatar &&
          other.seen == this.seen);
}

class InvitesCompanion extends UpdateCompanion<Invite> {
  final Value<int> id;
  final Value<String?> message;
  final Value<int> createdAt;
  final Value<int?> userId;
  final Value<String?> userFirstName;
  final Value<String?> userLastName;
  final Value<String?> userAvatar;
  final Value<bool> seen;
  const InvitesCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.userFirstName = const Value.absent(),
    this.userLastName = const Value.absent(),
    this.userAvatar = const Value.absent(),
    this.seen = const Value.absent(),
  });
  InvitesCompanion.insert({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    required int createdAt,
    this.userId = const Value.absent(),
    this.userFirstName = const Value.absent(),
    this.userLastName = const Value.absent(),
    this.userAvatar = const Value.absent(),
    required bool seen,
  })   : createdAt = Value(createdAt),
        seen = Value(seen);
  static Insertable<Invite> custom({
    Expression<int>? id,
    Expression<String?>? message,
    Expression<int>? createdAt,
    Expression<int?>? userId,
    Expression<String?>? userFirstName,
    Expression<String?>? userLastName,
    Expression<String?>? userAvatar,
    Expression<bool>? seen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (userId != null) 'user_id': userId,
      if (userFirstName != null) 'user_first_name': userFirstName,
      if (userLastName != null) 'user_last_name': userLastName,
      if (userAvatar != null) 'user_avatar': userAvatar,
      if (seen != null) 'seen': seen,
    });
  }

  InvitesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? message,
      Value<int>? createdAt,
      Value<int?>? userId,
      Value<String?>? userFirstName,
      Value<String?>? userLastName,
      Value<String?>? userAvatar,
      Value<bool>? seen}) {
    return InvitesCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userAvatar: userAvatar ?? this.userAvatar,
      seen: seen ?? this.seen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String?>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int?>(userId.value);
    }
    if (userFirstName.present) {
      map['user_first_name'] = Variable<String?>(userFirstName.value);
    }
    if (userLastName.present) {
      map['user_last_name'] = Variable<String?>(userLastName.value);
    }
    if (userAvatar.present) {
      map['user_avatar'] = Variable<String?>(userAvatar.value);
    }
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvitesCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('userFirstName: $userFirstName, ')
          ..write('userLastName: $userLastName, ')
          ..write('userAvatar: $userAvatar, ')
          ..write('seen: $seen')
          ..write(')'))
        .toString();
  }
}

class $InvitesTable extends Invites with TableInfo<$InvitesTable, Invite> {
  final GeneratedDatabase _db;
  final String? _alias;
  $InvitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedTextColumn message = _constructMessage();
  GeneratedTextColumn _constructMessage() {
    return GeneratedTextColumn(
      'message',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedIntColumn createdAt = _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedIntColumn userId = _constructUserId();
  GeneratedIntColumn _constructUserId() {
    return GeneratedIntColumn(
      'user_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userFirstNameMeta =
      const VerificationMeta('userFirstName');
  @override
  late final GeneratedTextColumn userFirstName = _constructUserFirstName();
  GeneratedTextColumn _constructUserFirstName() {
    return GeneratedTextColumn(
      'user_first_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userLastNameMeta =
      const VerificationMeta('userLastName');
  @override
  late final GeneratedTextColumn userLastName = _constructUserLastName();
  GeneratedTextColumn _constructUserLastName() {
    return GeneratedTextColumn(
      'user_last_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userAvatarMeta = const VerificationMeta('userAvatar');
  @override
  late final GeneratedTextColumn userAvatar = _constructUserAvatar();
  GeneratedTextColumn _constructUserAvatar() {
    return GeneratedTextColumn(
      'user_avatar',
      $tableName,
      true,
    );
  }

  final VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedBoolColumn seen = _constructSeen();
  GeneratedBoolColumn _constructSeen() {
    return GeneratedBoolColumn(
      'seen',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        message,
        createdAt,
        userId,
        userFirstName,
        userLastName,
        userAvatar,
        seen
      ];
  @override
  $InvitesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'invites';
  @override
  final String actualTableName = 'invites';
  @override
  VerificationContext validateIntegrity(Insertable<Invite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('user_first_name')) {
      context.handle(
          _userFirstNameMeta,
          userFirstName.isAcceptableOrUnknown(
              data['user_first_name']!, _userFirstNameMeta));
    }
    if (data.containsKey('user_last_name')) {
      context.handle(
          _userLastNameMeta,
          userLastName.isAcceptableOrUnknown(
              data['user_last_name']!, _userLastNameMeta));
    }
    if (data.containsKey('user_avatar')) {
      context.handle(
          _userAvatarMeta,
          userAvatar.isAcceptableOrUnknown(
              data['user_avatar']!, _userAvatarMeta));
    }
    if (data.containsKey('seen')) {
      context.handle(
          _seenMeta, seen.isAcceptableOrUnknown(data['seen']!, _seenMeta));
    } else if (isInserting) {
      context.missing(_seenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Invite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $InvitesTable createAlias(String alias) {
    return $InvitesTable(_db, alias);
  }
}

class ChatUser extends DataClass implements Insertable<ChatUser> {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final int inviteId;
  final int updatedAt;
  ChatUser(
      {required this.id,
      this.firstName,
      this.lastName,
      this.avatar,
      required this.inviteId,
      required this.updatedAt});
  factory ChatUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ChatUser(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      inviteId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}invite_id'])!,
      updatedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String?>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String?>(lastName);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String?>(avatar);
    }
    map['invite_id'] = Variable<int>(inviteId);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ChatUsersCompanion toCompanion(bool nullToAbsent) {
    return ChatUsersCompanion(
      id: Value(id),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      inviteId: Value(inviteId),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChatUser(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      inviteId: serializer.fromJson<int>(json['inviteId']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'avatar': serializer.toJson<String?>(avatar),
      'inviteId': serializer.toJson<int>(inviteId),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ChatUser copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? avatar,
          int? inviteId,
          int? updatedAt}) =>
      ChatUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
        inviteId: inviteId ?? this.inviteId,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ChatUser(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatar: $avatar, ')
          ..write('inviteId: $inviteId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          firstName.hashCode,
          $mrjc(
              lastName.hashCode,
              $mrjc(avatar.hashCode,
                  $mrjc(inviteId.hashCode, updatedAt.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ChatUser &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.avatar == this.avatar &&
          other.inviteId == this.inviteId &&
          other.updatedAt == this.updatedAt);
}

class ChatUsersCompanion extends UpdateCompanion<ChatUser> {
  final Value<int> id;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> avatar;
  final Value<int> inviteId;
  final Value<int> updatedAt;
  const ChatUsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatar = const Value.absent(),
    this.inviteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatUsersCompanion.insert({
    required int id,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatar = const Value.absent(),
    required int inviteId,
    required int updatedAt,
  })   : id = Value(id),
        inviteId = Value(inviteId),
        updatedAt = Value(updatedAt);
  static Insertable<ChatUser> custom({
    Expression<int>? id,
    Expression<String?>? firstName,
    Expression<String?>? lastName,
    Expression<String?>? avatar,
    Expression<int>? inviteId,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (avatar != null) 'avatar': avatar,
      if (inviteId != null) 'invite_id': inviteId,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatUsersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? avatar,
      Value<int>? inviteId,
      Value<int>? updatedAt}) {
    return ChatUsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      inviteId: inviteId ?? this.inviteId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String?>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String?>(lastName.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String?>(avatar.value);
    }
    if (inviteId.present) {
      map['invite_id'] = Variable<int>(inviteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatUsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatar: $avatar, ')
          ..write('inviteId: $inviteId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatUsersTable extends ChatUsers
    with TableInfo<$ChatUsersTable, ChatUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ChatUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedTextColumn firstName = _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedTextColumn lastName = _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedTextColumn avatar = _constructAvatar();
  GeneratedTextColumn _constructAvatar() {
    return GeneratedTextColumn(
      'avatar',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inviteIdMeta = const VerificationMeta('inviteId');
  @override
  late final GeneratedIntColumn inviteId = _constructInviteId();
  GeneratedIntColumn _constructInviteId() {
    return GeneratedIntColumn(
      'invite_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedIntColumn updatedAt = _constructUpdatedAt();
  GeneratedIntColumn _constructUpdatedAt() {
    return GeneratedIntColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, avatar, inviteId, updatedAt];
  @override
  $ChatUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'chat_users';
  @override
  final String actualTableName = 'chat_users';
  @override
  VerificationContext validateIntegrity(Insertable<ChatUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('invite_id')) {
      context.handle(_inviteIdMeta,
          inviteId.isAcceptableOrUnknown(data['invite_id']!, _inviteIdMeta));
    } else if (isInserting) {
      context.missing(_inviteIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ChatUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ChatUser.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ChatUsersTable createAlias(String alias) {
    return $ChatUsersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $InvitesTable invites = $InvitesTable(this);
  late final $ChatUsersTable chatUsers = $ChatUsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [invites, chatUsers];
}

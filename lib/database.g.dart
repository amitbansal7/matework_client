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
  final String? userShortBio;
  final bool seen;
  Invite(
      {required this.id,
      this.message,
      required this.createdAt,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.userAvatar,
      this.userShortBio,
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
      userShortBio: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_short_bio']),
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
    if (!nullToAbsent || userShortBio != null) {
      map['user_short_bio'] = Variable<String?>(userShortBio);
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
      userShortBio: userShortBio == null && nullToAbsent
          ? const Value.absent()
          : Value(userShortBio),
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
      userShortBio: serializer.fromJson<String?>(json['userShortBio']),
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
      'userShortBio': serializer.toJson<String?>(userShortBio),
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
          String? userShortBio,
          bool? seen}) =>
      Invite(
        id: id ?? this.id,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
        userAvatar: userAvatar ?? this.userAvatar,
        userShortBio: userShortBio ?? this.userShortBio,
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
          ..write('userShortBio: $userShortBio, ')
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
                      $mrjc(
                          userLastName.hashCode,
                          $mrjc(
                              userAvatar.hashCode,
                              $mrjc(
                                  userShortBio.hashCode, seen.hashCode)))))))));
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
          other.userShortBio == this.userShortBio &&
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
  final Value<String?> userShortBio;
  final Value<bool> seen;
  const InvitesCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.userFirstName = const Value.absent(),
    this.userLastName = const Value.absent(),
    this.userAvatar = const Value.absent(),
    this.userShortBio = const Value.absent(),
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
    this.userShortBio = const Value.absent(),
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
    Expression<String?>? userShortBio,
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
      if (userShortBio != null) 'user_short_bio': userShortBio,
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
      Value<String?>? userShortBio,
      Value<bool>? seen}) {
    return InvitesCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userAvatar: userAvatar ?? this.userAvatar,
      userShortBio: userShortBio ?? this.userShortBio,
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
    if (userShortBio.present) {
      map['user_short_bio'] = Variable<String?>(userShortBio.value);
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
          ..write('userShortBio: $userShortBio, ')
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
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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

  final VerificationMeta _userShortBioMeta =
      const VerificationMeta('userShortBio');
  @override
  late final GeneratedTextColumn userShortBio = _constructUserShortBio();
  GeneratedTextColumn _constructUserShortBio() {
    return GeneratedTextColumn(
      'user_short_bio',
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
        userShortBio,
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
    if (data.containsKey('user_short_bio')) {
      context.handle(
          _userShortBioMeta,
          userShortBio.isAcceptableOrUnknown(
              data['user_short_bio']!, _userShortBioMeta));
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
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatar = const Value.absent(),
    required int inviteId,
    required int updatedAt,
  })   : inviteId = Value(inviteId),
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
  Set<GeneratedColumn> get $primaryKey => {id};
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

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int id;
  final int? serverId;
  final int inviteId;
  final int senderId;
  final String message;
  final bool sent;
  final bool seen;
  final int createdAt;
  ChatMessage(
      {required this.id,
      this.serverId,
      required this.inviteId,
      required this.senderId,
      required this.message,
      required this.sent,
      required this.seen,
      required this.createdAt});
  factory ChatMessage.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ChatMessage(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      serverId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
      inviteId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}invite_id'])!,
      senderId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sender_id'])!,
      message: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}message'])!,
      sent: boolType.mapFromDatabaseResponse(data['${effectivePrefix}sent'])!,
      seen: boolType.mapFromDatabaseResponse(data['${effectivePrefix}seen'])!,
      createdAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int?>(serverId);
    }
    map['invite_id'] = Variable<int>(inviteId);
    map['sender_id'] = Variable<int>(senderId);
    map['message'] = Variable<String>(message);
    map['sent'] = Variable<bool>(sent);
    map['seen'] = Variable<bool>(seen);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      inviteId: Value(inviteId),
      senderId: Value(senderId),
      message: Value(message),
      sent: Value(sent),
      seen: Value(seen),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int?>(json['serverId']),
      inviteId: serializer.fromJson<int>(json['inviteId']),
      senderId: serializer.fromJson<int>(json['senderId']),
      message: serializer.fromJson<String>(json['message']),
      sent: serializer.fromJson<bool>(json['sent']),
      seen: serializer.fromJson<bool>(json['seen']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int?>(serverId),
      'inviteId': serializer.toJson<int>(inviteId),
      'senderId': serializer.toJson<int>(senderId),
      'message': serializer.toJson<String>(message),
      'sent': serializer.toJson<bool>(sent),
      'seen': serializer.toJson<bool>(seen),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ChatMessage copyWith(
          {int? id,
          int? serverId,
          int? inviteId,
          int? senderId,
          String? message,
          bool? sent,
          bool? seen,
          int? createdAt}) =>
      ChatMessage(
        id: id ?? this.id,
        serverId: serverId ?? this.serverId,
        inviteId: inviteId ?? this.inviteId,
        senderId: senderId ?? this.senderId,
        message: message ?? this.message,
        sent: sent ?? this.sent,
        seen: seen ?? this.seen,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('inviteId: $inviteId, ')
          ..write('senderId: $senderId, ')
          ..write('message: $message, ')
          ..write('sent: $sent, ')
          ..write('seen: $seen, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          serverId.hashCode,
          $mrjc(
              inviteId.hashCode,
              $mrjc(
                  senderId.hashCode,
                  $mrjc(
                      message.hashCode,
                      $mrjc(sent.hashCode,
                          $mrjc(seen.hashCode, createdAt.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.inviteId == this.inviteId &&
          other.senderId == this.senderId &&
          other.message == this.message &&
          other.sent == this.sent &&
          other.seen == this.seen &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> id;
  final Value<int?> serverId;
  final Value<int> inviteId;
  final Value<int> senderId;
  final Value<String> message;
  final Value<bool> sent;
  final Value<bool> seen;
  final Value<int> createdAt;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.inviteId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.message = const Value.absent(),
    this.sent = const Value.absent(),
    this.seen = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required int inviteId,
    required int senderId,
    required String message,
    required bool sent,
    required bool seen,
    required int createdAt,
  })   : inviteId = Value(inviteId),
        senderId = Value(senderId),
        message = Value(message),
        sent = Value(sent),
        seen = Value(seen),
        createdAt = Value(createdAt);
  static Insertable<ChatMessage> custom({
    Expression<int>? id,
    Expression<int?>? serverId,
    Expression<int>? inviteId,
    Expression<int>? senderId,
    Expression<String>? message,
    Expression<bool>? sent,
    Expression<bool>? seen,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (inviteId != null) 'invite_id': inviteId,
      if (senderId != null) 'sender_id': senderId,
      if (message != null) 'message': message,
      if (sent != null) 'sent': sent,
      if (seen != null) 'seen': seen,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ChatMessagesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? serverId,
      Value<int>? inviteId,
      Value<int>? senderId,
      Value<String>? message,
      Value<bool>? sent,
      Value<bool>? seen,
      Value<int>? createdAt}) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      inviteId: inviteId ?? this.inviteId,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      sent: sent ?? this.sent,
      seen: seen ?? this.seen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int?>(serverId.value);
    }
    if (inviteId.present) {
      map['invite_id'] = Variable<int>(inviteId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<int>(senderId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (sent.present) {
      map['sent'] = Variable<bool>(sent.value);
    }
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('inviteId: $inviteId, ')
          ..write('senderId: $senderId, ')
          ..write('message: $message, ')
          ..write('sent: $sent, ')
          ..write('seen: $seen, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ChatMessagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedIntColumn serverId = _constructServerId();
  GeneratedIntColumn _constructServerId() {
    return GeneratedIntColumn(
      'server_id',
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

  final VerificationMeta _senderIdMeta = const VerificationMeta('senderId');
  @override
  late final GeneratedIntColumn senderId = _constructSenderId();
  GeneratedIntColumn _constructSenderId() {
    return GeneratedIntColumn(
      'sender_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedTextColumn message = _constructMessage();
  GeneratedTextColumn _constructMessage() {
    return GeneratedTextColumn(
      'message',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sentMeta = const VerificationMeta('sent');
  @override
  late final GeneratedBoolColumn sent = _constructSent();
  GeneratedBoolColumn _constructSent() {
    return GeneratedBoolColumn(
      'sent',
      $tableName,
      false,
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

  @override
  List<GeneratedColumn> get $columns =>
      [id, serverId, inviteId, senderId, message, sent, seen, createdAt];
  @override
  $ChatMessagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'chat_messages';
  @override
  final String actualTableName = 'chat_messages';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('invite_id')) {
      context.handle(_inviteIdMeta,
          inviteId.isAcceptableOrUnknown(data['invite_id']!, _inviteIdMeta));
    } else if (isInserting) {
      context.missing(_inviteIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(_senderIdMeta,
          senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta));
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('sent')) {
      context.handle(
          _sentMeta, sent.isAcceptableOrUnknown(data['sent']!, _sentMeta));
    } else if (isInserting) {
      context.missing(_sentMeta);
    }
    if (data.containsKey('seen')) {
      context.handle(
          _seenMeta, seen.isAcceptableOrUnknown(data['seen']!, _seenMeta));
    } else if (isInserting) {
      context.missing(_seenMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ChatMessage.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(_db, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? shortBio;
  final String? lookingFor;
  final String? longBio;
  final double? experience;
  final int? age;
  final String? externalLink;
  final String? location;
  final String? skills;
  UserProfile(
      {required this.id,
      this.firstName,
      this.lastName,
      this.avatar,
      this.shortBio,
      this.lookingFor,
      this.longBio,
      this.experience,
      this.age,
      this.externalLink,
      this.location,
      this.skills});
  factory UserProfile.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return UserProfile(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      shortBio: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}short_bio']),
      lookingFor: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}looking_for']),
      longBio: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}long_bio']),
      experience: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}experience']),
      age: intType.mapFromDatabaseResponse(data['${effectivePrefix}age']),
      externalLink: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}external_link']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      skills:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}skills']),
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
    if (!nullToAbsent || shortBio != null) {
      map['short_bio'] = Variable<String?>(shortBio);
    }
    if (!nullToAbsent || lookingFor != null) {
      map['looking_for'] = Variable<String?>(lookingFor);
    }
    if (!nullToAbsent || longBio != null) {
      map['long_bio'] = Variable<String?>(longBio);
    }
    if (!nullToAbsent || experience != null) {
      map['experience'] = Variable<double?>(experience);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int?>(age);
    }
    if (!nullToAbsent || externalLink != null) {
      map['external_link'] = Variable<String?>(externalLink);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String?>(location);
    }
    if (!nullToAbsent || skills != null) {
      map['skills'] = Variable<String?>(skills);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      shortBio: shortBio == null && nullToAbsent
          ? const Value.absent()
          : Value(shortBio),
      lookingFor: lookingFor == null && nullToAbsent
          ? const Value.absent()
          : Value(lookingFor),
      longBio: longBio == null && nullToAbsent
          ? const Value.absent()
          : Value(longBio),
      experience: experience == null && nullToAbsent
          ? const Value.absent()
          : Value(experience),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      externalLink: externalLink == null && nullToAbsent
          ? const Value.absent()
          : Value(externalLink),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      skills:
          skills == null && nullToAbsent ? const Value.absent() : Value(skills),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      shortBio: serializer.fromJson<String?>(json['shortBio']),
      lookingFor: serializer.fromJson<String?>(json['lookingFor']),
      longBio: serializer.fromJson<String?>(json['longBio']),
      experience: serializer.fromJson<double?>(json['experience']),
      age: serializer.fromJson<int?>(json['age']),
      externalLink: serializer.fromJson<String?>(json['externalLink']),
      location: serializer.fromJson<String?>(json['location']),
      skills: serializer.fromJson<String?>(json['skills']),
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
      'shortBio': serializer.toJson<String?>(shortBio),
      'lookingFor': serializer.toJson<String?>(lookingFor),
      'longBio': serializer.toJson<String?>(longBio),
      'experience': serializer.toJson<double?>(experience),
      'age': serializer.toJson<int?>(age),
      'externalLink': serializer.toJson<String?>(externalLink),
      'location': serializer.toJson<String?>(location),
      'skills': serializer.toJson<String?>(skills),
    };
  }

  UserProfile copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? avatar,
          String? shortBio,
          String? lookingFor,
          String? longBio,
          double? experience,
          int? age,
          String? externalLink,
          String? location,
          String? skills}) =>
      UserProfile(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
        shortBio: shortBio ?? this.shortBio,
        lookingFor: lookingFor ?? this.lookingFor,
        longBio: longBio ?? this.longBio,
        experience: experience ?? this.experience,
        age: age ?? this.age,
        externalLink: externalLink ?? this.externalLink,
        location: location ?? this.location,
        skills: skills ?? this.skills,
      );
  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatar: $avatar, ')
          ..write('shortBio: $shortBio, ')
          ..write('lookingFor: $lookingFor, ')
          ..write('longBio: $longBio, ')
          ..write('experience: $experience, ')
          ..write('age: $age, ')
          ..write('externalLink: $externalLink, ')
          ..write('location: $location, ')
          ..write('skills: $skills')
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
              $mrjc(
                  avatar.hashCode,
                  $mrjc(
                      shortBio.hashCode,
                      $mrjc(
                          lookingFor.hashCode,
                          $mrjc(
                              longBio.hashCode,
                              $mrjc(
                                  experience.hashCode,
                                  $mrjc(
                                      age.hashCode,
                                      $mrjc(
                                          externalLink.hashCode,
                                          $mrjc(location.hashCode,
                                              skills.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.avatar == this.avatar &&
          other.shortBio == this.shortBio &&
          other.lookingFor == this.lookingFor &&
          other.longBio == this.longBio &&
          other.experience == this.experience &&
          other.age == this.age &&
          other.externalLink == this.externalLink &&
          other.location == this.location &&
          other.skills == this.skills);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> avatar;
  final Value<String?> shortBio;
  final Value<String?> lookingFor;
  final Value<String?> longBio;
  final Value<double?> experience;
  final Value<int?> age;
  final Value<String?> externalLink;
  final Value<String?> location;
  final Value<String?> skills;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatar = const Value.absent(),
    this.shortBio = const Value.absent(),
    this.lookingFor = const Value.absent(),
    this.longBio = const Value.absent(),
    this.experience = const Value.absent(),
    this.age = const Value.absent(),
    this.externalLink = const Value.absent(),
    this.location = const Value.absent(),
    this.skills = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatar = const Value.absent(),
    this.shortBio = const Value.absent(),
    this.lookingFor = const Value.absent(),
    this.longBio = const Value.absent(),
    this.experience = const Value.absent(),
    this.age = const Value.absent(),
    this.externalLink = const Value.absent(),
    this.location = const Value.absent(),
    this.skills = const Value.absent(),
  });
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String?>? firstName,
    Expression<String?>? lastName,
    Expression<String?>? avatar,
    Expression<String?>? shortBio,
    Expression<String?>? lookingFor,
    Expression<String?>? longBio,
    Expression<double?>? experience,
    Expression<int?>? age,
    Expression<String?>? externalLink,
    Expression<String?>? location,
    Expression<String?>? skills,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (avatar != null) 'avatar': avatar,
      if (shortBio != null) 'short_bio': shortBio,
      if (lookingFor != null) 'looking_for': lookingFor,
      if (longBio != null) 'long_bio': longBio,
      if (experience != null) 'experience': experience,
      if (age != null) 'age': age,
      if (externalLink != null) 'external_link': externalLink,
      if (location != null) 'location': location,
      if (skills != null) 'skills': skills,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? avatar,
      Value<String?>? shortBio,
      Value<String?>? lookingFor,
      Value<String?>? longBio,
      Value<double?>? experience,
      Value<int?>? age,
      Value<String?>? externalLink,
      Value<String?>? location,
      Value<String?>? skills}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      shortBio: shortBio ?? this.shortBio,
      lookingFor: lookingFor ?? this.lookingFor,
      longBio: longBio ?? this.longBio,
      experience: experience ?? this.experience,
      age: age ?? this.age,
      externalLink: externalLink ?? this.externalLink,
      location: location ?? this.location,
      skills: skills ?? this.skills,
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
    if (shortBio.present) {
      map['short_bio'] = Variable<String?>(shortBio.value);
    }
    if (lookingFor.present) {
      map['looking_for'] = Variable<String?>(lookingFor.value);
    }
    if (longBio.present) {
      map['long_bio'] = Variable<String?>(longBio.value);
    }
    if (experience.present) {
      map['experience'] = Variable<double?>(experience.value);
    }
    if (age.present) {
      map['age'] = Variable<int?>(age.value);
    }
    if (externalLink.present) {
      map['external_link'] = Variable<String?>(externalLink.value);
    }
    if (location.present) {
      map['location'] = Variable<String?>(location.value);
    }
    if (skills.present) {
      map['skills'] = Variable<String?>(skills.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatar: $avatar, ')
          ..write('shortBio: $shortBio, ')
          ..write('lookingFor: $lookingFor, ')
          ..write('longBio: $longBio, ')
          ..write('experience: $experience, ')
          ..write('age: $age, ')
          ..write('externalLink: $externalLink, ')
          ..write('location: $location, ')
          ..write('skills: $skills')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UserProfilesTable(this._db, [this._alias]);
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

  final VerificationMeta _shortBioMeta = const VerificationMeta('shortBio');
  @override
  late final GeneratedTextColumn shortBio = _constructShortBio();
  GeneratedTextColumn _constructShortBio() {
    return GeneratedTextColumn(
      'short_bio',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lookingForMeta = const VerificationMeta('lookingFor');
  @override
  late final GeneratedTextColumn lookingFor = _constructLookingFor();
  GeneratedTextColumn _constructLookingFor() {
    return GeneratedTextColumn(
      'looking_for',
      $tableName,
      true,
    );
  }

  final VerificationMeta _longBioMeta = const VerificationMeta('longBio');
  @override
  late final GeneratedTextColumn longBio = _constructLongBio();
  GeneratedTextColumn _constructLongBio() {
    return GeneratedTextColumn(
      'long_bio',
      $tableName,
      true,
    );
  }

  final VerificationMeta _experienceMeta = const VerificationMeta('experience');
  @override
  late final GeneratedRealColumn experience = _constructExperience();
  GeneratedRealColumn _constructExperience() {
    return GeneratedRealColumn(
      'experience',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedIntColumn age = _constructAge();
  GeneratedIntColumn _constructAge() {
    return GeneratedIntColumn(
      'age',
      $tableName,
      true,
    );
  }

  final VerificationMeta _externalLinkMeta =
      const VerificationMeta('externalLink');
  @override
  late final GeneratedTextColumn externalLink = _constructExternalLink();
  GeneratedTextColumn _constructExternalLink() {
    return GeneratedTextColumn(
      'external_link',
      $tableName,
      true,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedTextColumn location = _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      true,
    );
  }

  final VerificationMeta _skillsMeta = const VerificationMeta('skills');
  @override
  late final GeneratedTextColumn skills = _constructSkills();
  GeneratedTextColumn _constructSkills() {
    return GeneratedTextColumn(
      'skills',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        avatar,
        shortBio,
        lookingFor,
        longBio,
        experience,
        age,
        externalLink,
        location,
        skills
      ];
  @override
  $UserProfilesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_profiles';
  @override
  final String actualTableName = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('short_bio')) {
      context.handle(_shortBioMeta,
          shortBio.isAcceptableOrUnknown(data['short_bio']!, _shortBioMeta));
    }
    if (data.containsKey('looking_for')) {
      context.handle(
          _lookingForMeta,
          lookingFor.isAcceptableOrUnknown(
              data['looking_for']!, _lookingForMeta));
    }
    if (data.containsKey('long_bio')) {
      context.handle(_longBioMeta,
          longBio.isAcceptableOrUnknown(data['long_bio']!, _longBioMeta));
    }
    if (data.containsKey('experience')) {
      context.handle(
          _experienceMeta,
          experience.isAcceptableOrUnknown(
              data['experience']!, _experienceMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('external_link')) {
      context.handle(
          _externalLinkMeta,
          externalLink.isAcceptableOrUnknown(
              data['external_link']!, _externalLinkMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('skills')) {
      context.handle(_skillsMeta,
          skills.isAcceptableOrUnknown(data['skills']!, _skillsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserProfile.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $InvitesTable invites = $InvitesTable(this);
  late final $ChatUsersTable chatUsers = $ChatUsersTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [invites, chatUsers, chatMessages, userProfiles];
}

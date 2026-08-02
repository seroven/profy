// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable = GeneratedColumn<bool>(
    'enable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _userCreateMeta = const VerificationMeta(
    'userCreate',
  );
  @override
  late final GeneratedColumn<String> userCreate = GeneratedColumn<String>(
    'user_create',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userUpdateMeta = const VerificationMeta(
    'userUpdate',
  );
  @override
  late final GeneratedColumn<String> userUpdate = GeneratedColumn<String>(
    'user_update',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    username,
    password,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(
        _enableMeta,
        enable.isAcceptableOrUnknown(data['enable']!, _enableMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_create')) {
      context.handle(
        _userCreateMeta,
        userCreate.isAcceptableOrUnknown(data['user_create']!, _userCreateMeta),
      );
    }
    if (data.containsKey('user_update')) {
      context.handle(
        _userUpdateMeta,
        userUpdate.isAcceptableOrUnknown(data['user_update']!, _userUpdateMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      userCreate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_create'],
      ),
      userUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_update'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final String username;

  /// Hash bcrypt de la contraseña (nunca texto plano).
  final String password;
  const User({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.username,
    required this.password,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable'] = Variable<bool>(enable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || userCreate != null) {
      map['user_create'] = Variable<String>(userCreate);
    }
    if (!nullToAbsent || userUpdate != null) {
      map['user_update'] = Variable<String>(userUpdate);
    }
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      enable: Value(enable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userCreate: userCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(userCreate),
      userUpdate: userUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(userUpdate),
      username: Value(username),
      password: Value(password),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enable': serializer.toJson<bool>(enable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userCreate': serializer.toJson<String?>(userCreate),
      'userUpdate': serializer.toJson<String?>(userUpdate),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    String? username,
    String? password,
  }) => User(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    username: username ?? this.username,
    password: password ?? this.password,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      enable: data.enable.present ? data.enable.value : this.enable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userCreate: data.userCreate.present
          ? data.userCreate.value
          : this.userCreate,
      userUpdate: data.userUpdate.present
          ? data.userUpdate.value
          : this.userUpdate,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    username,
    password,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.username == this.username &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<String> username;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required String username,
    required String password,
  }) : username = Value(username),
       password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<String>? username,
    Value<String>? password,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userCreate.present) {
      map['user_create'] = Variable<String>(userCreate.value);
    }
    if (userUpdate.present) {
      map['user_update'] = Variable<String>(userUpdate.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UserDetailsTable extends UserDetails
    with TableInfo<$UserDetailsTable, UserDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable = GeneratedColumn<bool>(
    'enable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _userCreateMeta = const VerificationMeta(
    'userCreate',
  );
  @override
  late final GeneratedColumn<String> userCreate = GeneratedColumn<String>(
    'user_create',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userUpdateMeta = const VerificationMeta(
    'userUpdate',
  );
  @override
  late final GeneratedColumn<String> userUpdate = GeneratedColumn<String>(
    'user_update',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dniMeta = const VerificationMeta('dni');
  @override
  late final GeneratedColumn<String> dni = GeneratedColumn<String>(
    'dni',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rucMeta = const VerificationMeta('ruc');
  @override
  late final GeneratedColumn<String> ruc = GeneratedColumn<String>(
    'ruc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userId,
    firstName,
    lastName,
    phone,
    dni,
    ruc,
    email,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(
        _enableMeta,
        enable.isAcceptableOrUnknown(data['enable']!, _enableMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_create')) {
      context.handle(
        _userCreateMeta,
        userCreate.isAcceptableOrUnknown(data['user_create']!, _userCreateMeta),
      );
    }
    if (data.containsKey('user_update')) {
      context.handle(
        _userUpdateMeta,
        userUpdate.isAcceptableOrUnknown(data['user_update']!, _userUpdateMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('dni')) {
      context.handle(
        _dniMeta,
        dni.isAcceptableOrUnknown(data['dni']!, _dniMeta),
      );
    }
    if (data.containsKey('ruc')) {
      context.handle(
        _rucMeta,
        ruc.isAcceptableOrUnknown(data['ruc']!, _rucMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDetail(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      userCreate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_create'],
      ),
      userUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_update'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      dni: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dni'],
      ),
      ruc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ruc'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
    );
  }

  @override
  $UserDetailsTable createAlias(String alias) {
    return $UserDetailsTable(attachedDatabase, alias);
  }
}

class UserDetail extends DataClass implements Insertable<UserDetail> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dni;
  final String? ruc;
  final String? email;
  final String? photoPath;
  const UserDetail({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.dni,
    this.ruc,
    this.email,
    this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable'] = Variable<bool>(enable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || userCreate != null) {
      map['user_create'] = Variable<String>(userCreate);
    }
    if (!nullToAbsent || userUpdate != null) {
      map['user_update'] = Variable<String>(userUpdate);
    }
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || dni != null) {
      map['dni'] = Variable<String>(dni);
    }
    if (!nullToAbsent || ruc != null) {
      map['ruc'] = Variable<String>(ruc);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    return map;
  }

  UserDetailsCompanion toCompanion(bool nullToAbsent) {
    return UserDetailsCompanion(
      id: Value(id),
      enable: Value(enable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userCreate: userCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(userCreate),
      userUpdate: userUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(userUpdate),
      userId: Value(userId),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      dni: dni == null && nullToAbsent ? const Value.absent() : Value(dni),
      ruc: ruc == null && nullToAbsent ? const Value.absent() : Value(ruc),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory UserDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDetail(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      userId: serializer.fromJson<int>(json['userId']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      phone: serializer.fromJson<String?>(json['phone']),
      dni: serializer.fromJson<String?>(json['dni']),
      ruc: serializer.fromJson<String?>(json['ruc']),
      email: serializer.fromJson<String?>(json['email']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enable': serializer.toJson<bool>(enable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userCreate': serializer.toJson<String?>(userCreate),
      'userUpdate': serializer.toJson<String?>(userUpdate),
      'userId': serializer.toJson<int>(userId),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'phone': serializer.toJson<String?>(phone),
      'dni': serializer.toJson<String?>(dni),
      'ruc': serializer.toJson<String?>(ruc),
      'email': serializer.toJson<String?>(email),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  UserDetail copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    int? userId,
    Value<String?> firstName = const Value.absent(),
    Value<String?> lastName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> dni = const Value.absent(),
    Value<String?> ruc = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
  }) => UserDetail(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    userId: userId ?? this.userId,
    firstName: firstName.present ? firstName.value : this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    phone: phone.present ? phone.value : this.phone,
    dni: dni.present ? dni.value : this.dni,
    ruc: ruc.present ? ruc.value : this.ruc,
    email: email.present ? email.value : this.email,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
  );
  UserDetail copyWithCompanion(UserDetailsCompanion data) {
    return UserDetail(
      id: data.id.present ? data.id.value : this.id,
      enable: data.enable.present ? data.enable.value : this.enable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userCreate: data.userCreate.present
          ? data.userCreate.value
          : this.userCreate,
      userUpdate: data.userUpdate.present
          ? data.userUpdate.value
          : this.userUpdate,
      userId: data.userId.present ? data.userId.value : this.userId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      phone: data.phone.present ? data.phone.value : this.phone,
      dni: data.dni.present ? data.dni.value : this.dni,
      ruc: data.ruc.present ? data.ruc.value : this.ruc,
      email: data.email.present ? data.email.value : this.email,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDetail(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('dni: $dni, ')
          ..write('ruc: $ruc, ')
          ..write('email: $email, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userId,
    firstName,
    lastName,
    phone,
    dni,
    ruc,
    email,
    photoPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDetail &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.userId == this.userId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.phone == this.phone &&
          other.dni == this.dni &&
          other.ruc == this.ruc &&
          other.email == this.email &&
          other.photoPath == this.photoPath);
}

class UserDetailsCompanion extends UpdateCompanion<UserDetail> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<int> userId;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> phone;
  final Value<String?> dni;
  final Value<String?> ruc;
  final Value<String?> email;
  final Value<String?> photoPath;
  const UserDetailsCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.userId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.dni = const Value.absent(),
    this.ruc = const Value.absent(),
    this.email = const Value.absent(),
    this.photoPath = const Value.absent(),
  });
  UserDetailsCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required int userId,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.dni = const Value.absent(),
    this.ruc = const Value.absent(),
    this.email = const Value.absent(),
    this.photoPath = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<UserDetail> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<int>? userId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? phone,
    Expression<String>? dni,
    Expression<String>? ruc,
    Expression<String>? email,
    Expression<String>? photoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (userId != null) 'user_id': userId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (dni != null) 'dni': dni,
      if (ruc != null) 'ruc': ruc,
      if (email != null) 'email': email,
      if (photoPath != null) 'photo_path': photoPath,
    });
  }

  UserDetailsCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<int>? userId,
    Value<String?>? firstName,
    Value<String?>? lastName,
    Value<String?>? phone,
    Value<String?>? dni,
    Value<String?>? ruc,
    Value<String?>? email,
    Value<String?>? photoPath,
  }) {
    return UserDetailsCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      dni: dni ?? this.dni,
      ruc: ruc ?? this.ruc,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userCreate.present) {
      map['user_create'] = Variable<String>(userCreate.value);
    }
    if (userUpdate.present) {
      map['user_update'] = Variable<String>(userUpdate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (dni.present) {
      map['dni'] = Variable<String>(dni.value);
    }
    if (ruc.present) {
      map['ruc'] = Variable<String>(ruc.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDetailsCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('dni: $dni, ')
          ..write('ruc: $ruc, ')
          ..write('email: $email, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable = GeneratedColumn<bool>(
    'enable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _userCreateMeta = const VerificationMeta(
    'userCreate',
  );
  @override
  late final GeneratedColumn<String> userCreate = GeneratedColumn<String>(
    'user_create',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userUpdateMeta = const VerificationMeta(
    'userUpdate',
  );
  @override
  late final GeneratedColumn<String> userUpdate = GeneratedColumn<String>(
    'user_update',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userDetailIdMeta = const VerificationMeta(
    'userDetailId',
  );
  @override
  late final GeneratedColumn<int> userDetailId = GeneratedColumn<int>(
    'user_detail_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES user_details (id)',
    ),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('dark'),
  );
  static const VerificationMeta _colorThemeMeta = const VerificationMeta(
    'colorTheme',
  );
  @override
  late final GeneratedColumn<String> colorTheme = GeneratedColumn<String>(
    'color_theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('blue'),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PEN'),
  );
  static const VerificationMeta _defaultUnitMeta = const VerificationMeta(
    'defaultUnit',
  );
  @override
  late final GeneratedColumn<String> defaultUnit = GeneratedColumn<String>(
    'default_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('m2'),
  );
  static const VerificationMeta _companyLogoPathMeta = const VerificationMeta(
    'companyLogoPath',
  );
  @override
  late final GeneratedColumn<String> companyLogoPath = GeneratedColumn<String>(
    'company_logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userDetailId,
    themeMode,
    colorTheme,
    defaultCurrency,
    defaultUnit,
    companyLogoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(
        _enableMeta,
        enable.isAcceptableOrUnknown(data['enable']!, _enableMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_create')) {
      context.handle(
        _userCreateMeta,
        userCreate.isAcceptableOrUnknown(data['user_create']!, _userCreateMeta),
      );
    }
    if (data.containsKey('user_update')) {
      context.handle(
        _userUpdateMeta,
        userUpdate.isAcceptableOrUnknown(data['user_update']!, _userUpdateMeta),
      );
    }
    if (data.containsKey('user_detail_id')) {
      context.handle(
        _userDetailIdMeta,
        userDetailId.isAcceptableOrUnknown(
          data['user_detail_id']!,
          _userDetailIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userDetailIdMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('color_theme')) {
      context.handle(
        _colorThemeMeta,
        colorTheme.isAcceptableOrUnknown(data['color_theme']!, _colorThemeMeta),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('default_unit')) {
      context.handle(
        _defaultUnitMeta,
        defaultUnit.isAcceptableOrUnknown(
          data['default_unit']!,
          _defaultUnitMeta,
        ),
      );
    }
    if (data.containsKey('company_logo_path')) {
      context.handle(
        _companyLogoPathMeta,
        companyLogoPath.isAcceptableOrUnknown(
          data['company_logo_path']!,
          _companyLogoPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      userCreate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_create'],
      ),
      userUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_update'],
      ),
      userDetailId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_detail_id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      colorTheme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_theme'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      defaultUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit'],
      )!,
      companyLogoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_logo_path'],
      ),
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final int userDetailId;

  /// `light` | `dark`
  final String themeMode;
  final String colorTheme;

  /// `PEN` | `USD` | `EUR`
  final String defaultCurrency;

  /// `m2` | `m3` | `ft` | `cm`
  final String defaultUnit;
  final String? companyLogoPath;
  const UserPreference({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.userDetailId,
    required this.themeMode,
    required this.colorTheme,
    required this.defaultCurrency,
    required this.defaultUnit,
    this.companyLogoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable'] = Variable<bool>(enable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || userCreate != null) {
      map['user_create'] = Variable<String>(userCreate);
    }
    if (!nullToAbsent || userUpdate != null) {
      map['user_update'] = Variable<String>(userUpdate);
    }
    map['user_detail_id'] = Variable<int>(userDetailId);
    map['theme_mode'] = Variable<String>(themeMode);
    map['color_theme'] = Variable<String>(colorTheme);
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['default_unit'] = Variable<String>(defaultUnit);
    if (!nullToAbsent || companyLogoPath != null) {
      map['company_logo_path'] = Variable<String>(companyLogoPath);
    }
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      id: Value(id),
      enable: Value(enable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userCreate: userCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(userCreate),
      userUpdate: userUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(userUpdate),
      userDetailId: Value(userDetailId),
      themeMode: Value(themeMode),
      colorTheme: Value(colorTheme),
      defaultCurrency: Value(defaultCurrency),
      defaultUnit: Value(defaultUnit),
      companyLogoPath: companyLogoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(companyLogoPath),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      userDetailId: serializer.fromJson<int>(json['userDetailId']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      colorTheme: serializer.fromJson<String>(json['colorTheme']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      defaultUnit: serializer.fromJson<String>(json['defaultUnit']),
      companyLogoPath: serializer.fromJson<String?>(json['companyLogoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enable': serializer.toJson<bool>(enable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userCreate': serializer.toJson<String?>(userCreate),
      'userUpdate': serializer.toJson<String?>(userUpdate),
      'userDetailId': serializer.toJson<int>(userDetailId),
      'themeMode': serializer.toJson<String>(themeMode),
      'colorTheme': serializer.toJson<String>(colorTheme),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'defaultUnit': serializer.toJson<String>(defaultUnit),
      'companyLogoPath': serializer.toJson<String?>(companyLogoPath),
    };
  }

  UserPreference copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    int? userDetailId,
    String? themeMode,
    String? colorTheme,
    String? defaultCurrency,
    String? defaultUnit,
    Value<String?> companyLogoPath = const Value.absent(),
  }) => UserPreference(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    userDetailId: userDetailId ?? this.userDetailId,
    themeMode: themeMode ?? this.themeMode,
    colorTheme: colorTheme ?? this.colorTheme,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    defaultUnit: defaultUnit ?? this.defaultUnit,
    companyLogoPath: companyLogoPath.present
        ? companyLogoPath.value
        : this.companyLogoPath,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      id: data.id.present ? data.id.value : this.id,
      enable: data.enable.present ? data.enable.value : this.enable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userCreate: data.userCreate.present
          ? data.userCreate.value
          : this.userCreate,
      userUpdate: data.userUpdate.present
          ? data.userUpdate.value
          : this.userUpdate,
      userDetailId: data.userDetailId.present
          ? data.userDetailId.value
          : this.userDetailId,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      colorTheme: data.colorTheme.present
          ? data.colorTheme.value
          : this.colorTheme,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      companyLogoPath: data.companyLogoPath.present
          ? data.companyLogoPath.value
          : this.companyLogoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userDetailId: $userDetailId, ')
          ..write('themeMode: $themeMode, ')
          ..write('colorTheme: $colorTheme, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('companyLogoPath: $companyLogoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userDetailId,
    themeMode,
    colorTheme,
    defaultCurrency,
    defaultUnit,
    companyLogoPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.userDetailId == this.userDetailId &&
          other.themeMode == this.themeMode &&
          other.colorTheme == this.colorTheme &&
          other.defaultCurrency == this.defaultCurrency &&
          other.defaultUnit == this.defaultUnit &&
          other.companyLogoPath == this.companyLogoPath);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<int> userDetailId;
  final Value<String> themeMode;
  final Value<String> colorTheme;
  final Value<String> defaultCurrency;
  final Value<String> defaultUnit;
  final Value<String?> companyLogoPath;
  const UserPreferencesCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.userDetailId = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.colorTheme = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.companyLogoPath = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required int userDetailId,
    this.themeMode = const Value.absent(),
    this.colorTheme = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.companyLogoPath = const Value.absent(),
  }) : userDetailId = Value(userDetailId);
  static Insertable<UserPreference> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<int>? userDetailId,
    Expression<String>? themeMode,
    Expression<String>? colorTheme,
    Expression<String>? defaultCurrency,
    Expression<String>? defaultUnit,
    Expression<String>? companyLogoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (userDetailId != null) 'user_detail_id': userDetailId,
      if (themeMode != null) 'theme_mode': themeMode,
      if (colorTheme != null) 'color_theme': colorTheme,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (companyLogoPath != null) 'company_logo_path': companyLogoPath,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<int>? userDetailId,
    Value<String>? themeMode,
    Value<String>? colorTheme,
    Value<String>? defaultCurrency,
    Value<String>? defaultUnit,
    Value<String?>? companyLogoPath,
  }) {
    return UserPreferencesCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      userDetailId: userDetailId ?? this.userDetailId,
      themeMode: themeMode ?? this.themeMode,
      colorTheme: colorTheme ?? this.colorTheme,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      companyLogoPath: companyLogoPath ?? this.companyLogoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userCreate.present) {
      map['user_create'] = Variable<String>(userCreate.value);
    }
    if (userUpdate.present) {
      map['user_update'] = Variable<String>(userUpdate.value);
    }
    if (userDetailId.present) {
      map['user_detail_id'] = Variable<int>(userDetailId.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (colorTheme.present) {
      map['color_theme'] = Variable<String>(colorTheme.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (companyLogoPath.present) {
      map['company_logo_path'] = Variable<String>(companyLogoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userDetailId: $userDetailId, ')
          ..write('themeMode: $themeMode, ')
          ..write('colorTheme: $colorTheme, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('companyLogoPath: $companyLogoPath')
          ..write(')'))
        .toString();
  }
}

class $PaymentMethodsTable extends PaymentMethods
    with TableInfo<$PaymentMethodsTable, PaymentMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable = GeneratedColumn<bool>(
    'enable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _userCreateMeta = const VerificationMeta(
    'userCreate',
  );
  @override
  late final GeneratedColumn<String> userCreate = GeneratedColumn<String>(
    'user_create',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userUpdateMeta = const VerificationMeta(
    'userUpdate',
  );
  @override
  late final GeneratedColumn<String> userUpdate = GeneratedColumn<String>(
    'user_update',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userDetailIdMeta = const VerificationMeta(
    'userDetailId',
  );
  @override
  late final GeneratedColumn<int> userDetailId = GeneratedColumn<int>(
    'user_detail_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_details (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _interbankNumberMeta = const VerificationMeta(
    'interbankNumber',
  );
  @override
  late final GeneratedColumn<String> interbankNumber = GeneratedColumn<String>(
    'interbank_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userDetailId,
    type,
    name,
    phone,
    accountNumber,
    interbankNumber,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(
        _enableMeta,
        enable.isAcceptableOrUnknown(data['enable']!, _enableMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_create')) {
      context.handle(
        _userCreateMeta,
        userCreate.isAcceptableOrUnknown(data['user_create']!, _userCreateMeta),
      );
    }
    if (data.containsKey('user_update')) {
      context.handle(
        _userUpdateMeta,
        userUpdate.isAcceptableOrUnknown(data['user_update']!, _userUpdateMeta),
      );
    }
    if (data.containsKey('user_detail_id')) {
      context.handle(
        _userDetailIdMeta,
        userDetailId.isAcceptableOrUnknown(
          data['user_detail_id']!,
          _userDetailIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userDetailIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    }
    if (data.containsKey('interbank_number')) {
      context.handle(
        _interbankNumberMeta,
        interbankNumber.isAcceptableOrUnknown(
          data['interbank_number']!,
          _interbankNumberMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentMethod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      userCreate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_create'],
      ),
      userUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_update'],
      ),
      userDetailId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_detail_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      ),
      interbankNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interbank_number'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PaymentMethodsTable createAlias(String alias) {
    return $PaymentMethodsTable(attachedDatabase, alias);
  }
}

class PaymentMethod extends DataClass implements Insertable<PaymentMethod> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final int userDetailId;

  /// `yape` | `plin` | `bank_account`
  final String type;
  final String name;
  final String? phone;
  final String? accountNumber;
  final String? interbankNumber;
  final int sortOrder;
  const PaymentMethod({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.userDetailId,
    required this.type,
    required this.name,
    this.phone,
    this.accountNumber,
    this.interbankNumber,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable'] = Variable<bool>(enable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || userCreate != null) {
      map['user_create'] = Variable<String>(userCreate);
    }
    if (!nullToAbsent || userUpdate != null) {
      map['user_update'] = Variable<String>(userUpdate);
    }
    map['user_detail_id'] = Variable<int>(userDetailId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || interbankNumber != null) {
      map['interbank_number'] = Variable<String>(interbankNumber);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PaymentMethodsCompanion toCompanion(bool nullToAbsent) {
    return PaymentMethodsCompanion(
      id: Value(id),
      enable: Value(enable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userCreate: userCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(userCreate),
      userUpdate: userUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(userUpdate),
      userDetailId: Value(userDetailId),
      type: Value(type),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      interbankNumber: interbankNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(interbankNumber),
      sortOrder: Value(sortOrder),
    );
  }

  factory PaymentMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentMethod(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      userDetailId: serializer.fromJson<int>(json['userDetailId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      interbankNumber: serializer.fromJson<String?>(json['interbankNumber']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enable': serializer.toJson<bool>(enable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'userCreate': serializer.toJson<String?>(userCreate),
      'userUpdate': serializer.toJson<String?>(userUpdate),
      'userDetailId': serializer.toJson<int>(userDetailId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'interbankNumber': serializer.toJson<String?>(interbankNumber),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PaymentMethod copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    int? userDetailId,
    String? type,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> accountNumber = const Value.absent(),
    Value<String?> interbankNumber = const Value.absent(),
    int? sortOrder,
  }) => PaymentMethod(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    userDetailId: userDetailId ?? this.userDetailId,
    type: type ?? this.type,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    accountNumber: accountNumber.present
        ? accountNumber.value
        : this.accountNumber,
    interbankNumber: interbankNumber.present
        ? interbankNumber.value
        : this.interbankNumber,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  PaymentMethod copyWithCompanion(PaymentMethodsCompanion data) {
    return PaymentMethod(
      id: data.id.present ? data.id.value : this.id,
      enable: data.enable.present ? data.enable.value : this.enable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userCreate: data.userCreate.present
          ? data.userCreate.value
          : this.userCreate,
      userUpdate: data.userUpdate.present
          ? data.userUpdate.value
          : this.userUpdate,
      userDetailId: data.userDetailId.present
          ? data.userDetailId.value
          : this.userDetailId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      interbankNumber: data.interbankNumber.present
          ? data.interbankNumber.value
          : this.interbankNumber,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethod(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userDetailId: $userDetailId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('interbankNumber: $interbankNumber, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enable,
    createdAt,
    updatedAt,
    userCreate,
    userUpdate,
    userDetailId,
    type,
    name,
    phone,
    accountNumber,
    interbankNumber,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentMethod &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.userDetailId == this.userDetailId &&
          other.type == this.type &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.accountNumber == this.accountNumber &&
          other.interbankNumber == this.interbankNumber &&
          other.sortOrder == this.sortOrder);
}

class PaymentMethodsCompanion extends UpdateCompanion<PaymentMethod> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<int> userDetailId;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> accountNumber;
  final Value<String?> interbankNumber;
  final Value<int> sortOrder;
  const PaymentMethodsCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.userDetailId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.interbankNumber = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  PaymentMethodsCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required int userDetailId,
    required String type,
    required String name,
    this.phone = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.interbankNumber = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : userDetailId = Value(userDetailId),
       type = Value(type),
       name = Value(name);
  static Insertable<PaymentMethod> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<int>? userDetailId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? accountNumber,
    Expression<String>? interbankNumber,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (userDetailId != null) 'user_detail_id': userDetailId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (accountNumber != null) 'account_number': accountNumber,
      if (interbankNumber != null) 'interbank_number': interbankNumber,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  PaymentMethodsCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<int>? userDetailId,
    Value<String>? type,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? accountNumber,
    Value<String?>? interbankNumber,
    Value<int>? sortOrder,
  }) {
    return PaymentMethodsCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      userDetailId: userDetailId ?? this.userDetailId,
      type: type ?? this.type,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      accountNumber: accountNumber ?? this.accountNumber,
      interbankNumber: interbankNumber ?? this.interbankNumber,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userCreate.present) {
      map['user_create'] = Variable<String>(userCreate.value);
    }
    if (userUpdate.present) {
      map['user_update'] = Variable<String>(userUpdate.value);
    }
    if (userDetailId.present) {
      map['user_detail_id'] = Variable<int>(userDetailId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (interbankNumber.present) {
      map['interbank_number'] = Variable<String>(interbankNumber.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethodsCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userDetailId: $userDetailId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('interbankNumber: $interbankNumber, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserDetailsTable userDetails = $UserDetailsTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $PaymentMethodsTable paymentMethods = $PaymentMethodsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    userDetails,
    userPreferences,
    paymentMethods,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required String username,
      required String password,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<String> username,
      Value<String> password,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserDetailsTable, List<UserDetail>>
  _userDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userDetails,
    aliasName: 'users__id__user_details__user_id',
  );

  $$UserDetailsTableProcessedTableManager get userDetailsRefs {
    final manager = $$UserDetailsTableTableManager(
      $_db,
      $_db.userDetails,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userDetailsRefs(
    Expression<bool> Function($$UserDetailsTableFilterComposer f) f,
  ) {
    final $$UserDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableFilterComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enable =>
      $composableBuilder(column: $table.enable, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  Expression<T> userDetailsRefs<T extends Object>(
    Expression<T> Function($$UserDetailsTableAnnotationComposer a) f,
  ) {
    final $$UserDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool userDetailsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                username: username,
                password: password,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                required String username,
                required String password,
              }) => UsersCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                username: username,
                password: password,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({userDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userDetailsRefs) db.userDetails],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userDetailsRefs)
                    await $_getPrefetchedData<User, $UsersTable, UserDetail>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._userDetailsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).userDetailsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool userDetailsRefs})
    >;
typedef $$UserDetailsTableCreateCompanionBuilder =
    UserDetailsCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required int userId,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> phone,
      Value<String?> dni,
      Value<String?> ruc,
      Value<String?> email,
      Value<String?> photoPath,
    });
typedef $$UserDetailsTableUpdateCompanionBuilder =
    UserDetailsCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<int> userId,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> phone,
      Value<String?> dni,
      Value<String?> ruc,
      Value<String?> email,
      Value<String?> photoPath,
    });

final class $$UserDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $UserDetailsTable, UserDetail> {
  $$UserDetailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('user_details__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$UserPreferencesTable, List<UserPreference>>
  _userPreferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPreferences,
    aliasName: 'user_details__id__user_preferences__user_detail_id',
  );

  $$UserPreferencesTableProcessedTableManager get userPreferencesRefs {
    final manager = $$UserPreferencesTableTableManager(
      $_db,
      $_db.userPreferences,
    ).filter((f) => f.userDetailId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentMethodsTable, List<PaymentMethod>>
  _paymentMethodsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentMethods,
    aliasName: 'user_details__id__payment_methods__user_detail_id',
  );

  $$PaymentMethodsTableProcessedTableManager get paymentMethodsRefs {
    final manager = $$PaymentMethodsTableTableManager(
      $_db,
      $_db.paymentMethods,
    ).filter((f) => f.userDetailId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentMethodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $UserDetailsTable> {
  $$UserDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dni => $composableBuilder(
    column: $table.dni,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruc => $composableBuilder(
    column: $table.ruc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> userPreferencesRefs(
    Expression<bool> Function($$UserPreferencesTableFilterComposer f) f,
  ) {
    final $$UserPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.userDetailId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentMethodsRefs(
    Expression<bool> Function($$PaymentMethodsTableFilterComposer f) f,
  ) {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.userDetailId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserDetailsTable> {
  $$UserDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dni => $composableBuilder(
    column: $table.dni,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruc => $composableBuilder(
    column: $table.ruc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserDetailsTable> {
  $$UserDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enable =>
      $composableBuilder(column: $table.enable, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get dni =>
      $composableBuilder(column: $table.dni, builder: (column) => column);

  GeneratedColumn<String> get ruc =>
      $composableBuilder(column: $table.ruc, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> userPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserPreferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.userDetailId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentMethodsRefs<T extends Object>(
    Expression<T> Function($$PaymentMethodsTableAnnotationComposer a) f,
  ) {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.userDetailId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserDetailsTable,
          UserDetail,
          $$UserDetailsTableFilterComposer,
          $$UserDetailsTableOrderingComposer,
          $$UserDetailsTableAnnotationComposer,
          $$UserDetailsTableCreateCompanionBuilder,
          $$UserDetailsTableUpdateCompanionBuilder,
          (UserDetail, $$UserDetailsTableReferences),
          UserDetail,
          PrefetchHooks Function({
            bool userId,
            bool userPreferencesRefs,
            bool paymentMethodsRefs,
          })
        > {
  $$UserDetailsTableTableManager(_$AppDatabase db, $UserDetailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> dni = const Value.absent(),
                Value<String?> ruc = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => UserDetailsCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                dni: dni,
                ruc: ruc,
                email: email,
                photoPath: photoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                required int userId,
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> dni = const Value.absent(),
                Value<String?> ruc = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => UserDetailsCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                dni: dni,
                ruc: ruc,
                email: email,
                photoPath: photoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                userPreferencesRefs = false,
                paymentMethodsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userPreferencesRefs) db.userPreferences,
                    if (paymentMethodsRefs) db.paymentMethods,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$UserDetailsTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$UserDetailsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userPreferencesRefs)
                        await $_getPrefetchedData<
                          UserDetail,
                          $UserDetailsTable,
                          UserPreference
                        >(
                          currentTable: table,
                          referencedTable: $$UserDetailsTableReferences
                              ._userPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserDetailsTableReferences(
                                db,
                                table,
                                p0,
                              ).userPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userDetailId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentMethodsRefs)
                        await $_getPrefetchedData<
                          UserDetail,
                          $UserDetailsTable,
                          PaymentMethod
                        >(
                          currentTable: table,
                          referencedTable: $$UserDetailsTableReferences
                              ._paymentMethodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserDetailsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentMethodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userDetailId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserDetailsTable,
      UserDetail,
      $$UserDetailsTableFilterComposer,
      $$UserDetailsTableOrderingComposer,
      $$UserDetailsTableAnnotationComposer,
      $$UserDetailsTableCreateCompanionBuilder,
      $$UserDetailsTableUpdateCompanionBuilder,
      (UserDetail, $$UserDetailsTableReferences),
      UserDetail,
      PrefetchHooks Function({
        bool userId,
        bool userPreferencesRefs,
        bool paymentMethodsRefs,
      })
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required int userDetailId,
      Value<String> themeMode,
      Value<String> colorTheme,
      Value<String> defaultCurrency,
      Value<String> defaultUnit,
      Value<String?> companyLogoPath,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<int> userDetailId,
      Value<String> themeMode,
      Value<String> colorTheme,
      Value<String> defaultCurrency,
      Value<String> defaultUnit,
      Value<String?> companyLogoPath,
    });

final class $$UserPreferencesTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference> {
  $$UserPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserDetailsTable _userDetailIdTable(_$AppDatabase db) => db
      .userDetails
      .createAlias('user_preferences__user_detail_id__user_details__id');

  $$UserDetailsTableProcessedTableManager get userDetailId {
    final $_column = $_itemColumn<int>('user_detail_id')!;

    final manager = $$UserDetailsTableTableManager(
      $_db,
      $_db.userDetails,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userDetailIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorTheme => $composableBuilder(
    column: $table.colorTheme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyLogoPath => $composableBuilder(
    column: $table.companyLogoPath,
    builder: (column) => ColumnFilters(column),
  );

  $$UserDetailsTableFilterComposer get userDetailId {
    final $$UserDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableFilterComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorTheme => $composableBuilder(
    column: $table.colorTheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyLogoPath => $composableBuilder(
    column: $table.companyLogoPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserDetailsTableOrderingComposer get userDetailId {
    final $$UserDetailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableOrderingComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enable =>
      $composableBuilder(column: $table.enable, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get colorTheme => $composableBuilder(
    column: $table.colorTheme,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companyLogoPath => $composableBuilder(
    column: $table.companyLogoPath,
    builder: (column) => column,
  );

  $$UserDetailsTableAnnotationComposer get userDetailId {
    final $$UserDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (UserPreference, $$UserPreferencesTableReferences),
          UserPreference,
          PrefetchHooks Function({bool userDetailId})
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<int> userDetailId = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> colorTheme = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> defaultUnit = const Value.absent(),
                Value<String?> companyLogoPath = const Value.absent(),
              }) => UserPreferencesCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userDetailId: userDetailId,
                themeMode: themeMode,
                colorTheme: colorTheme,
                defaultCurrency: defaultCurrency,
                defaultUnit: defaultUnit,
                companyLogoPath: companyLogoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                required int userDetailId,
                Value<String> themeMode = const Value.absent(),
                Value<String> colorTheme = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> defaultUnit = const Value.absent(),
                Value<String?> companyLogoPath = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userDetailId: userDetailId,
                themeMode: themeMode,
                colorTheme: colorTheme,
                defaultCurrency: defaultCurrency,
                defaultUnit: defaultUnit,
                companyLogoPath: companyLogoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userDetailId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userDetailId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userDetailId,
                                referencedTable:
                                    $$UserPreferencesTableReferences
                                        ._userDetailIdTable(db),
                                referencedColumn:
                                    $$UserPreferencesTableReferences
                                        ._userDetailIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (UserPreference, $$UserPreferencesTableReferences),
      UserPreference,
      PrefetchHooks Function({bool userDetailId})
    >;
typedef $$PaymentMethodsTableCreateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required int userDetailId,
      required String type,
      required String name,
      Value<String?> phone,
      Value<String?> accountNumber,
      Value<String?> interbankNumber,
      Value<int> sortOrder,
    });
typedef $$PaymentMethodsTableUpdateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<int> userDetailId,
      Value<String> type,
      Value<String> name,
      Value<String?> phone,
      Value<String?> accountNumber,
      Value<String?> interbankNumber,
      Value<int> sortOrder,
    });

final class $$PaymentMethodsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod> {
  $$PaymentMethodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserDetailsTable _userDetailIdTable(_$AppDatabase db) => db
      .userDetails
      .createAlias('payment_methods__user_detail_id__user_details__id');

  $$UserDetailsTableProcessedTableManager get userDetailId {
    final $_column = $_itemColumn<int>('user_detail_id')!;

    final manager = $$UserDetailsTableTableManager(
      $_db,
      $_db.userDetails,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userDetailIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get interbankNumber => $composableBuilder(
    column: $table.interbankNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$UserDetailsTableFilterComposer get userDetailId {
    final $$UserDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableFilterComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enable => $composableBuilder(
    column: $table.enable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get interbankNumber => $composableBuilder(
    column: $table.interbankNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserDetailsTableOrderingComposer get userDetailId {
    final $$UserDetailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableOrderingComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enable =>
      $composableBuilder(column: $table.enable, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userCreate => $composableBuilder(
    column: $table.userCreate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userUpdate => $composableBuilder(
    column: $table.userUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get interbankNumber => $composableBuilder(
    column: $table.interbankNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$UserDetailsTableAnnotationComposer get userDetailId {
    final $$UserDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userDetailId,
      referencedTable: $db.userDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.userDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentMethodsTable,
          PaymentMethod,
          $$PaymentMethodsTableFilterComposer,
          $$PaymentMethodsTableOrderingComposer,
          $$PaymentMethodsTableAnnotationComposer,
          $$PaymentMethodsTableCreateCompanionBuilder,
          $$PaymentMethodsTableUpdateCompanionBuilder,
          (PaymentMethod, $$PaymentMethodsTableReferences),
          PaymentMethod,
          PrefetchHooks Function({bool userDetailId})
        > {
  $$PaymentMethodsTableTableManager(
    _$AppDatabase db,
    $PaymentMethodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<int> userDetailId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> interbankNumber = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => PaymentMethodsCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userDetailId: userDetailId,
                type: type,
                name: name,
                phone: phone,
                accountNumber: accountNumber,
                interbankNumber: interbankNumber,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                required int userDetailId,
                required String type,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> interbankNumber = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => PaymentMethodsCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userDetailId: userDetailId,
                type: type,
                name: name,
                phone: phone,
                accountNumber: accountNumber,
                interbankNumber: interbankNumber,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentMethodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userDetailId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userDetailId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userDetailId,
                                referencedTable: $$PaymentMethodsTableReferences
                                    ._userDetailIdTable(db),
                                referencedColumn:
                                    $$PaymentMethodsTableReferences
                                        ._userDetailIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentMethodsTable,
      PaymentMethod,
      $$PaymentMethodsTableFilterComposer,
      $$PaymentMethodsTableOrderingComposer,
      $$PaymentMethodsTableAnnotationComposer,
      $$PaymentMethodsTableCreateCompanionBuilder,
      $$PaymentMethodsTableUpdateCompanionBuilder,
      (PaymentMethod, $$PaymentMethodsTableReferences),
      PaymentMethod,
      PrefetchHooks Function({bool userDetailId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserDetailsTableTableManager get userDetails =>
      $$UserDetailsTableTableManager(_db, _db.userDetails);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$PaymentMethodsTableTableManager get paymentMethods =>
      $$PaymentMethodsTableTableManager(_db, _db.paymentMethods);
}

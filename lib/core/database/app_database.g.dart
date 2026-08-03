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
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    companyName,
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
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
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
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      ),
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
  final String? companyName;
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
    this.companyName,
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
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
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
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
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
      companyName: serializer.fromJson<String?>(json['companyName']),
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
      'companyName': serializer.toJson<String?>(companyName),
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
    Value<String?> companyName = const Value.absent(),
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
    companyName: companyName.present ? companyName.value : this.companyName,
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
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
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
          ..write('companyName: $companyName, ')
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
    companyName,
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
          other.companyName == this.companyName &&
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
  final Value<String?> companyName;
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
    this.companyName = const Value.absent(),
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
    this.companyName = const Value.absent(),
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
    Expression<String>? companyName,
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
      if (companyName != null) 'company_name': companyName,
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
    Value<String?>? companyName,
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
      companyName: companyName ?? this.companyName,
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
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
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
          ..write('companyName: $companyName, ')
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

class $ProformasTable extends Proformas
    with TableInfo<$ProformasTable, Proforma> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProformasTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _projectNameMeta = const VerificationMeta(
    'projectName',
  );
  @override
  late final GeneratedColumn<String> projectName = GeneratedColumn<String>(
    'project_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _proformaDateMeta = const VerificationMeta(
    'proformaDate',
  );
  @override
  late final GeneratedColumn<DateTime> proformaDate = GeneratedColumn<DateTime>(
    'proforma_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PEN'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _documentJsonMeta = const VerificationMeta(
    'documentJson',
  );
  @override
  late final GeneratedColumn<String> documentJson = GeneratedColumn<String>(
    'document_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{"blocks":[]}'),
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
    code,
    clientName,
    projectName,
    phone,
    proformaDate,
    currency,
    status,
    documentJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proformas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Proforma> instance, {
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
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    }
    if (data.containsKey('project_name')) {
      context.handle(
        _projectNameMeta,
        projectName.isAcceptableOrUnknown(
          data['project_name']!,
          _projectNameMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('proforma_date')) {
      context.handle(
        _proformaDateMeta,
        proformaDate.isAcceptableOrUnknown(
          data['proforma_date']!,
          _proformaDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proformaDateMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('document_json')) {
      context.handle(
        _documentJsonMeta,
        documentJson.isAcceptableOrUnknown(
          data['document_json']!,
          _documentJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proforma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Proforma(
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
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      projectName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      proformaDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}proforma_date'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      documentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_json'],
      )!,
    );
  }

  @override
  $ProformasTable createAlias(String alias) {
    return $ProformasTable(attachedDatabase, alias);
  }
}

class Proforma extends DataClass implements Insertable<Proforma> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final int userId;

  /// Ej: PR-2026-928321
  final String code;
  final String clientName;
  final String projectName;
  final String? phone;
  final DateTime proformaDate;

  /// `PEN` | `USD` | `EUR`
  final String currency;

  /// `draft` | `finished`
  final String status;

  /// Bloques del documento (tablas, texto, perfil, medios de pago, …).
  final String documentJson;
  const Proforma({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.userId,
    required this.code,
    required this.clientName,
    required this.projectName,
    this.phone,
    required this.proformaDate,
    required this.currency,
    required this.status,
    required this.documentJson,
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
    map['code'] = Variable<String>(code);
    map['client_name'] = Variable<String>(clientName);
    map['project_name'] = Variable<String>(projectName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['proforma_date'] = Variable<DateTime>(proformaDate);
    map['currency'] = Variable<String>(currency);
    map['status'] = Variable<String>(status);
    map['document_json'] = Variable<String>(documentJson);
    return map;
  }

  ProformasCompanion toCompanion(bool nullToAbsent) {
    return ProformasCompanion(
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
      code: Value(code),
      clientName: Value(clientName),
      projectName: Value(projectName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      proformaDate: Value(proformaDate),
      currency: Value(currency),
      status: Value(status),
      documentJson: Value(documentJson),
    );
  }

  factory Proforma.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Proforma(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      userId: serializer.fromJson<int>(json['userId']),
      code: serializer.fromJson<String>(json['code']),
      clientName: serializer.fromJson<String>(json['clientName']),
      projectName: serializer.fromJson<String>(json['projectName']),
      phone: serializer.fromJson<String?>(json['phone']),
      proformaDate: serializer.fromJson<DateTime>(json['proformaDate']),
      currency: serializer.fromJson<String>(json['currency']),
      status: serializer.fromJson<String>(json['status']),
      documentJson: serializer.fromJson<String>(json['documentJson']),
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
      'code': serializer.toJson<String>(code),
      'clientName': serializer.toJson<String>(clientName),
      'projectName': serializer.toJson<String>(projectName),
      'phone': serializer.toJson<String?>(phone),
      'proformaDate': serializer.toJson<DateTime>(proformaDate),
      'currency': serializer.toJson<String>(currency),
      'status': serializer.toJson<String>(status),
      'documentJson': serializer.toJson<String>(documentJson),
    };
  }

  Proforma copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    int? userId,
    String? code,
    String? clientName,
    String? projectName,
    Value<String?> phone = const Value.absent(),
    DateTime? proformaDate,
    String? currency,
    String? status,
    String? documentJson,
  }) => Proforma(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    userId: userId ?? this.userId,
    code: code ?? this.code,
    clientName: clientName ?? this.clientName,
    projectName: projectName ?? this.projectName,
    phone: phone.present ? phone.value : this.phone,
    proformaDate: proformaDate ?? this.proformaDate,
    currency: currency ?? this.currency,
    status: status ?? this.status,
    documentJson: documentJson ?? this.documentJson,
  );
  Proforma copyWithCompanion(ProformasCompanion data) {
    return Proforma(
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
      code: data.code.present ? data.code.value : this.code,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      projectName: data.projectName.present
          ? data.projectName.value
          : this.projectName,
      phone: data.phone.present ? data.phone.value : this.phone,
      proformaDate: data.proformaDate.present
          ? data.proformaDate.value
          : this.proformaDate,
      currency: data.currency.present ? data.currency.value : this.currency,
      status: data.status.present ? data.status.value : this.status,
      documentJson: data.documentJson.present
          ? data.documentJson.value
          : this.documentJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Proforma(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('code: $code, ')
          ..write('clientName: $clientName, ')
          ..write('projectName: $projectName, ')
          ..write('phone: $phone, ')
          ..write('proformaDate: $proformaDate, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('documentJson: $documentJson')
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
    code,
    clientName,
    projectName,
    phone,
    proformaDate,
    currency,
    status,
    documentJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Proforma &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.userId == this.userId &&
          other.code == this.code &&
          other.clientName == this.clientName &&
          other.projectName == this.projectName &&
          other.phone == this.phone &&
          other.proformaDate == this.proformaDate &&
          other.currency == this.currency &&
          other.status == this.status &&
          other.documentJson == this.documentJson);
}

class ProformasCompanion extends UpdateCompanion<Proforma> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<int> userId;
  final Value<String> code;
  final Value<String> clientName;
  final Value<String> projectName;
  final Value<String?> phone;
  final Value<DateTime> proformaDate;
  final Value<String> currency;
  final Value<String> status;
  final Value<String> documentJson;
  const ProformasCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.userId = const Value.absent(),
    this.code = const Value.absent(),
    this.clientName = const Value.absent(),
    this.projectName = const Value.absent(),
    this.phone = const Value.absent(),
    this.proformaDate = const Value.absent(),
    this.currency = const Value.absent(),
    this.status = const Value.absent(),
    this.documentJson = const Value.absent(),
  });
  ProformasCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required int userId,
    required String code,
    this.clientName = const Value.absent(),
    this.projectName = const Value.absent(),
    this.phone = const Value.absent(),
    required DateTime proformaDate,
    this.currency = const Value.absent(),
    this.status = const Value.absent(),
    this.documentJson = const Value.absent(),
  }) : userId = Value(userId),
       code = Value(code),
       proformaDate = Value(proformaDate);
  static Insertable<Proforma> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<int>? userId,
    Expression<String>? code,
    Expression<String>? clientName,
    Expression<String>? projectName,
    Expression<String>? phone,
    Expression<DateTime>? proformaDate,
    Expression<String>? currency,
    Expression<String>? status,
    Expression<String>? documentJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (userId != null) 'user_id': userId,
      if (code != null) 'code': code,
      if (clientName != null) 'client_name': clientName,
      if (projectName != null) 'project_name': projectName,
      if (phone != null) 'phone': phone,
      if (proformaDate != null) 'proforma_date': proformaDate,
      if (currency != null) 'currency': currency,
      if (status != null) 'status': status,
      if (documentJson != null) 'document_json': documentJson,
    });
  }

  ProformasCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<int>? userId,
    Value<String>? code,
    Value<String>? clientName,
    Value<String>? projectName,
    Value<String?>? phone,
    Value<DateTime>? proformaDate,
    Value<String>? currency,
    Value<String>? status,
    Value<String>? documentJson,
  }) {
    return ProformasCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      userId: userId ?? this.userId,
      code: code ?? this.code,
      clientName: clientName ?? this.clientName,
      projectName: projectName ?? this.projectName,
      phone: phone ?? this.phone,
      proformaDate: proformaDate ?? this.proformaDate,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      documentJson: documentJson ?? this.documentJson,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (proformaDate.present) {
      map['proforma_date'] = Variable<DateTime>(proformaDate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (documentJson.present) {
      map['document_json'] = Variable<String>(documentJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProformasCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('code: $code, ')
          ..write('clientName: $clientName, ')
          ..write('projectName: $projectName, ')
          ..write('phone: $phone, ')
          ..write('proformaDate: $proformaDate, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('documentJson: $documentJson')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _documentJsonMeta = const VerificationMeta(
    'documentJson',
  );
  @override
  late final GeneratedColumn<String> documentJson = GeneratedColumn<String>(
    'document_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{"blocks":[]}'),
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
    name,
    documentJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<Template> instance, {
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('document_json')) {
      context.handle(
        _documentJsonMeta,
        documentJson.isAcceptableOrUnknown(
          data['document_json']!,
          _documentJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
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
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      documentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_json'],
      )!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final int id;
  final bool enable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userCreate;
  final String? userUpdate;
  final int userId;
  final String name;

  /// Bloques del documento (mismo esquema que proformas.document_json).
  final String documentJson;
  const Template({
    required this.id,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    this.userCreate,
    this.userUpdate,
    required this.userId,
    required this.name,
    required this.documentJson,
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
    map['name'] = Variable<String>(name);
    map['document_json'] = Variable<String>(documentJson);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
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
      name: Value(name),
      documentJson: Value(documentJson),
    );
  }

  factory Template.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      userCreate: serializer.fromJson<String?>(json['userCreate']),
      userUpdate: serializer.fromJson<String?>(json['userUpdate']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      documentJson: serializer.fromJson<String>(json['documentJson']),
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
      'name': serializer.toJson<String>(name),
      'documentJson': serializer.toJson<String>(documentJson),
    };
  }

  Template copyWith({
    int? id,
    bool? enable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> userCreate = const Value.absent(),
    Value<String?> userUpdate = const Value.absent(),
    int? userId,
    String? name,
    String? documentJson,
  }) => Template(
    id: id ?? this.id,
    enable: enable ?? this.enable,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userCreate: userCreate.present ? userCreate.value : this.userCreate,
    userUpdate: userUpdate.present ? userUpdate.value : this.userUpdate,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    documentJson: documentJson ?? this.documentJson,
  );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
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
      name: data.name.present ? data.name.value : this.name,
      documentJson: data.documentJson.present
          ? data.documentJson.value
          : this.documentJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('documentJson: $documentJson')
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
    name,
    documentJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userCreate == this.userCreate &&
          other.userUpdate == this.userUpdate &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.documentJson == this.documentJson);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> userCreate;
  final Value<String?> userUpdate;
  final Value<int> userId;
  final Value<String> name;
  final Value<String> documentJson;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.documentJson = const Value.absent(),
  });
  TemplatesCompanion.insert({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userCreate = const Value.absent(),
    this.userUpdate = const Value.absent(),
    required int userId,
    this.name = const Value.absent(),
    this.documentJson = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<Template> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userCreate,
    Expression<String>? userUpdate,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? documentJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userCreate != null) 'user_create': userCreate,
      if (userUpdate != null) 'user_update': userUpdate,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (documentJson != null) 'document_json': documentJson,
    });
  }

  TemplatesCompanion copyWith({
    Value<int>? id,
    Value<bool>? enable,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? userCreate,
    Value<String?>? userUpdate,
    Value<int>? userId,
    Value<String>? name,
    Value<String>? documentJson,
  }) {
    return TemplatesCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userCreate: userCreate ?? this.userCreate,
      userUpdate: userUpdate ?? this.userUpdate,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      documentJson: documentJson ?? this.documentJson,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (documentJson.present) {
      map['document_json'] = Variable<String>(documentJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userCreate: $userCreate, ')
          ..write('userUpdate: $userUpdate, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('documentJson: $documentJson')
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
  late final $ProformasTable proformas = $ProformasTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    userDetails,
    userPreferences,
    paymentMethods,
    proformas,
    templates,
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

  static MultiTypedResultKey<$ProformasTable, List<Proforma>>
  _proformasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.proformas,
    aliasName: 'users__id__proformas__user_id',
  );

  $$ProformasTableProcessedTableManager get proformasRefs {
    final manager = $$ProformasTableTableManager(
      $_db,
      $_db.proformas,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proformasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TemplatesTable, List<Template>>
  _templatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templates,
    aliasName: 'users__id__templates__user_id',
  );

  $$TemplatesTableProcessedTableManager get templatesRefs {
    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_templatesRefsTable($_db));
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

  Expression<bool> proformasRefs(
    Expression<bool> Function($$ProformasTableFilterComposer f) f,
  ) {
    final $$ProformasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proformas,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProformasTableFilterComposer(
            $db: $db,
            $table: $db.proformas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> templatesRefs(
    Expression<bool> Function($$TemplatesTableFilterComposer f) f,
  ) {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
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

  Expression<T> proformasRefs<T extends Object>(
    Expression<T> Function($$ProformasTableAnnotationComposer a) f,
  ) {
    final $$ProformasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proformas,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProformasTableAnnotationComposer(
            $db: $db,
            $table: $db.proformas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> templatesRefs<T extends Object>(
    Expression<T> Function($$TemplatesTableAnnotationComposer a) f,
  ) {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
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
          PrefetchHooks Function({
            bool userDetailsRefs,
            bool proformasRefs,
            bool templatesRefs,
          })
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
          prefetchHooksCallback:
              ({
                userDetailsRefs = false,
                proformasRefs = false,
                templatesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userDetailsRefs) db.userDetails,
                    if (proformasRefs) db.proformas,
                    if (templatesRefs) db.templates,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userDetailsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          UserDetail
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._userDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proformasRefs)
                        await $_getPrefetchedData<User, $UsersTable, Proforma>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._proformasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).proformasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (templatesRefs)
                        await $_getPrefetchedData<User, $UsersTable, Template>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._templatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).templatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
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
      PrefetchHooks Function({
        bool userDetailsRefs,
        bool proformasRefs,
        bool templatesRefs,
      })
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
      Value<String?> companyName,
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
      Value<String?> companyName,
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

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
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

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
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

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
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
                Value<String?> companyName = const Value.absent(),
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
                companyName: companyName,
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
                Value<String?> companyName = const Value.absent(),
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
                companyName: companyName,
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
typedef $$ProformasTableCreateCompanionBuilder =
    ProformasCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required int userId,
      required String code,
      Value<String> clientName,
      Value<String> projectName,
      Value<String?> phone,
      required DateTime proformaDate,
      Value<String> currency,
      Value<String> status,
      Value<String> documentJson,
    });
typedef $$ProformasTableUpdateCompanionBuilder =
    ProformasCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<int> userId,
      Value<String> code,
      Value<String> clientName,
      Value<String> projectName,
      Value<String?> phone,
      Value<DateTime> proformaDate,
      Value<String> currency,
      Value<String> status,
      Value<String> documentJson,
    });

final class $$ProformasTableReferences
    extends BaseReferences<_$AppDatabase, $ProformasTable, Proforma> {
  $$ProformasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('proformas__user_id__users__id');

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
}

class $$ProformasTableFilterComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get proformaDate => $composableBuilder(
    column: $table.proformaDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
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
}

class $$ProformasTableOrderingComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get proformaDate => $composableBuilder(
    column: $table.proformaDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
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

class $$ProformasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableAnnotationComposer({
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

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get proformaDate => $composableBuilder(
    column: $table.proformaDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
    builder: (column) => column,
  );

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
}

class $$ProformasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProformasTable,
          Proforma,
          $$ProformasTableFilterComposer,
          $$ProformasTableOrderingComposer,
          $$ProformasTableAnnotationComposer,
          $$ProformasTableCreateCompanionBuilder,
          $$ProformasTableUpdateCompanionBuilder,
          (Proforma, $$ProformasTableReferences),
          Proforma,
          PrefetchHooks Function({bool userId})
        > {
  $$ProformasTableTableManager(_$AppDatabase db, $ProformasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProformasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProformasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProformasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<String> projectName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<DateTime> proformaDate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> documentJson = const Value.absent(),
              }) => ProformasCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                code: code,
                clientName: clientName,
                projectName: projectName,
                phone: phone,
                proformaDate: proformaDate,
                currency: currency,
                status: status,
                documentJson: documentJson,
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
                required String code,
                Value<String> clientName = const Value.absent(),
                Value<String> projectName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required DateTime proformaDate,
                Value<String> currency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> documentJson = const Value.absent(),
              }) => ProformasCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                code: code,
                clientName: clientName,
                projectName: projectName,
                phone: phone,
                proformaDate: proformaDate,
                currency: currency,
                status: status,
                documentJson: documentJson,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProformasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$ProformasTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$ProformasTableReferences
                                    ._userIdTable(db)
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

typedef $$ProformasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProformasTable,
      Proforma,
      $$ProformasTableFilterComposer,
      $$ProformasTableOrderingComposer,
      $$ProformasTableAnnotationComposer,
      $$ProformasTableCreateCompanionBuilder,
      $$ProformasTableUpdateCompanionBuilder,
      (Proforma, $$ProformasTableReferences),
      Proforma,
      PrefetchHooks Function({bool userId})
    >;
typedef $$TemplatesTableCreateCompanionBuilder =
    TemplatesCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      required int userId,
      Value<String> name,
      Value<String> documentJson,
    });
typedef $$TemplatesTableUpdateCompanionBuilder =
    TemplatesCompanion Function({
      Value<int> id,
      Value<bool> enable,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> userCreate,
      Value<String?> userUpdate,
      Value<int> userId,
      Value<String> name,
      Value<String> documentJson,
    });

final class $$TemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $TemplatesTable, Template> {
  $$TemplatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('templates__user_id__users__id');

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
}

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
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
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
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

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get documentJson => $composableBuilder(
    column: $table.documentJson,
    builder: (column) => column,
  );

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
}

class $$TemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplatesTable,
          Template,
          $$TemplatesTableFilterComposer,
          $$TemplatesTableOrderingComposer,
          $$TemplatesTableAnnotationComposer,
          $$TemplatesTableCreateCompanionBuilder,
          $$TemplatesTableUpdateCompanionBuilder,
          (Template, $$TemplatesTableReferences),
          Template,
          PrefetchHooks Function({bool userId})
        > {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enable = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> userCreate = const Value.absent(),
                Value<String?> userUpdate = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> documentJson = const Value.absent(),
              }) => TemplatesCompanion(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                name: name,
                documentJson: documentJson,
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
                Value<String> name = const Value.absent(),
                Value<String> documentJson = const Value.absent(),
              }) => TemplatesCompanion.insert(
                id: id,
                enable: enable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userCreate: userCreate,
                userUpdate: userUpdate,
                userId: userId,
                name: name,
                documentJson: documentJson,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$TemplatesTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$TemplatesTableReferences
                                    ._userIdTable(db)
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

typedef $$TemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplatesTable,
      Template,
      $$TemplatesTableFilterComposer,
      $$TemplatesTableOrderingComposer,
      $$TemplatesTableAnnotationComposer,
      $$TemplatesTableCreateCompanionBuilder,
      $$TemplatesTableUpdateCompanionBuilder,
      (Template, $$TemplatesTableReferences),
      Template,
      PrefetchHooks Function({bool userId})
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
  $$ProformasTableTableManager get proformas =>
      $$ProformasTableTableManager(_db, _db.proformas);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
}

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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
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
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}

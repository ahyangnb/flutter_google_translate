// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TranslateItemsTable extends TranslateItems
    with TableInfo<$TranslateItemsTable, TranslateItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranslateItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _originContentMeta =
      const VerificationMeta('originContent');
  @override
  late final GeneratedColumn<String> originContent = GeneratedColumn<String>(
      'origin_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resultContentMeta =
      const VerificationMeta('resultContent');
  @override
  late final GeneratedColumn<String> resultContent = GeneratedColumn<String>(
      'result_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetLanguageMeta =
      const VerificationMeta('targetLanguage');
  @override
  late final GeneratedColumn<String> targetLanguage = GeneratedColumn<String>(
      'target_language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, originContent, resultContent, targetLanguage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'translate_items';
  @override
  VerificationContext validateIntegrity(Insertable<TranslateItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('origin_content')) {
      context.handle(
          _originContentMeta,
          originContent.isAcceptableOrUnknown(
              data['origin_content']!, _originContentMeta));
    } else if (isInserting) {
      context.missing(_originContentMeta);
    }
    if (data.containsKey('result_content')) {
      context.handle(
          _resultContentMeta,
          resultContent.isAcceptableOrUnknown(
              data['result_content']!, _resultContentMeta));
    } else if (isInserting) {
      context.missing(_resultContentMeta);
    }
    if (data.containsKey('target_language')) {
      context.handle(
          _targetLanguageMeta,
          targetLanguage.isAcceptableOrUnknown(
              data['target_language']!, _targetLanguageMeta));
    } else if (isInserting) {
      context.missing(_targetLanguageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TranslateItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranslateItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      originContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin_content'])!,
      resultContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result_content'])!,
      targetLanguage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}target_language'])!,
    );
  }

  @override
  $TranslateItemsTable createAlias(String alias) {
    return $TranslateItemsTable(attachedDatabase, alias);
  }
}

class TranslateItem extends DataClass implements Insertable<TranslateItem> {
  final int id;
  final String originContent;
  final String resultContent;
  final String targetLanguage;
  const TranslateItem(
      {required this.id,
      required this.originContent,
      required this.resultContent,
      required this.targetLanguage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['origin_content'] = Variable<String>(originContent);
    map['result_content'] = Variable<String>(resultContent);
    map['target_language'] = Variable<String>(targetLanguage);
    return map;
  }

  TranslateItemsCompanion toCompanion(bool nullToAbsent) {
    return TranslateItemsCompanion(
      id: Value(id),
      originContent: Value(originContent),
      resultContent: Value(resultContent),
      targetLanguage: Value(targetLanguage),
    );
  }

  factory TranslateItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranslateItem(
      id: serializer.fromJson<int>(json['id']),
      originContent: serializer.fromJson<String>(json['originContent']),
      resultContent: serializer.fromJson<String>(json['resultContent']),
      targetLanguage: serializer.fromJson<String>(json['targetLanguage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originContent': serializer.toJson<String>(originContent),
      'resultContent': serializer.toJson<String>(resultContent),
      'targetLanguage': serializer.toJson<String>(targetLanguage),
    };
  }

  TranslateItem copyWith(
          {int? id,
          String? originContent,
          String? resultContent,
          String? targetLanguage}) =>
      TranslateItem(
        id: id ?? this.id,
        originContent: originContent ?? this.originContent,
        resultContent: resultContent ?? this.resultContent,
        targetLanguage: targetLanguage ?? this.targetLanguage,
      );
  @override
  String toString() {
    return (StringBuffer('TranslateItem(')
          ..write('id: $id, ')
          ..write('originContent: $originContent, ')
          ..write('resultContent: $resultContent, ')
          ..write('targetLanguage: $targetLanguage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, originContent, resultContent, targetLanguage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranslateItem &&
          other.id == this.id &&
          other.originContent == this.originContent &&
          other.resultContent == this.resultContent &&
          other.targetLanguage == this.targetLanguage);
}

class TranslateItemsCompanion extends UpdateCompanion<TranslateItem> {
  final Value<int> id;
  final Value<String> originContent;
  final Value<String> resultContent;
  final Value<String> targetLanguage;
  const TranslateItemsCompanion({
    this.id = const Value.absent(),
    this.originContent = const Value.absent(),
    this.resultContent = const Value.absent(),
    this.targetLanguage = const Value.absent(),
  });
  TranslateItemsCompanion.insert({
    this.id = const Value.absent(),
    required String originContent,
    required String resultContent,
    required String targetLanguage,
  })  : originContent = Value(originContent),
        resultContent = Value(resultContent),
        targetLanguage = Value(targetLanguage);
  static Insertable<TranslateItem> custom({
    Expression<int>? id,
    Expression<String>? originContent,
    Expression<String>? resultContent,
    Expression<String>? targetLanguage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originContent != null) 'origin_content': originContent,
      if (resultContent != null) 'result_content': resultContent,
      if (targetLanguage != null) 'target_language': targetLanguage,
    });
  }

  TranslateItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? originContent,
      Value<String>? resultContent,
      Value<String>? targetLanguage}) {
    return TranslateItemsCompanion(
      id: id ?? this.id,
      originContent: originContent ?? this.originContent,
      resultContent: resultContent ?? this.resultContent,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originContent.present) {
      map['origin_content'] = Variable<String>(originContent.value);
    }
    if (resultContent.present) {
      map['result_content'] = Variable<String>(resultContent.value);
    }
    if (targetLanguage.present) {
      map['target_language'] = Variable<String>(targetLanguage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranslateItemsCompanion(')
          ..write('id: $id, ')
          ..write('originContent: $originContent, ')
          ..write('resultContent: $resultContent, ')
          ..write('targetLanguage: $targetLanguage')
          ..write(')'))
        .toString();
  }
}

abstract class _$TranslateDbInstance extends GeneratedDatabase {
  _$TranslateDbInstance(QueryExecutor e) : super(e);
  _$TranslateDbInstanceManager get managers =>
      _$TranslateDbInstanceManager(this);
  late final $TranslateItemsTable translateItems = $TranslateItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [translateItems];
}

typedef $$TranslateItemsTableInsertCompanionBuilder = TranslateItemsCompanion
    Function({
  Value<int> id,
  required String originContent,
  required String resultContent,
  required String targetLanguage,
});
typedef $$TranslateItemsTableUpdateCompanionBuilder = TranslateItemsCompanion
    Function({
  Value<int> id,
  Value<String> originContent,
  Value<String> resultContent,
  Value<String> targetLanguage,
});

class $$TranslateItemsTableTableManager extends RootTableManager<
    _$TranslateDbInstance,
    $TranslateItemsTable,
    TranslateItem,
    $$TranslateItemsTableFilterComposer,
    $$TranslateItemsTableOrderingComposer,
    $$TranslateItemsTableProcessedTableManager,
    $$TranslateItemsTableInsertCompanionBuilder,
    $$TranslateItemsTableUpdateCompanionBuilder> {
  $$TranslateItemsTableTableManager(
      _$TranslateDbInstance db, $TranslateItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TranslateItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TranslateItemsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TranslateItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> originContent = const Value.absent(),
            Value<String> resultContent = const Value.absent(),
            Value<String> targetLanguage = const Value.absent(),
          }) =>
              TranslateItemsCompanion(
            id: id,
            originContent: originContent,
            resultContent: resultContent,
            targetLanguage: targetLanguage,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String originContent,
            required String resultContent,
            required String targetLanguage,
          }) =>
              TranslateItemsCompanion.insert(
            id: id,
            originContent: originContent,
            resultContent: resultContent,
            targetLanguage: targetLanguage,
          ),
        ));
}

class $$TranslateItemsTableProcessedTableManager extends ProcessedTableManager<
    _$TranslateDbInstance,
    $TranslateItemsTable,
    TranslateItem,
    $$TranslateItemsTableFilterComposer,
    $$TranslateItemsTableOrderingComposer,
    $$TranslateItemsTableProcessedTableManager,
    $$TranslateItemsTableInsertCompanionBuilder,
    $$TranslateItemsTableUpdateCompanionBuilder> {
  $$TranslateItemsTableProcessedTableManager(super.$state);
}

class $$TranslateItemsTableFilterComposer
    extends FilterComposer<_$TranslateDbInstance, $TranslateItemsTable> {
  $$TranslateItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get originContent => $state.composableBuilder(
      column: $state.table.originContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get resultContent => $state.composableBuilder(
      column: $state.table.resultContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get targetLanguage => $state.composableBuilder(
      column: $state.table.targetLanguage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TranslateItemsTableOrderingComposer
    extends OrderingComposer<_$TranslateDbInstance, $TranslateItemsTable> {
  $$TranslateItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get originContent => $state.composableBuilder(
      column: $state.table.originContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get resultContent => $state.composableBuilder(
      column: $state.table.resultContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get targetLanguage => $state.composableBuilder(
      column: $state.table.targetLanguage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$TranslateDbInstanceManager {
  final _$TranslateDbInstance _db;
  _$TranslateDbInstanceManager(this._db);
  $$TranslateItemsTableTableManager get translateItems =>
      $$TranslateItemsTableTableManager(_db, _db.translateItems);
}

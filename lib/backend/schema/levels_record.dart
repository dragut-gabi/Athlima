import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'levels_record.g.dart';

abstract class LevelsRecord
    implements Built<LevelsRecord, LevelsRecordBuilder> {
  static Serializer<LevelsRecord> get serializer => _$levelsRecordSerializer;

  @nullable
  String get level;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(LevelsRecordBuilder builder) =>
      builder..level = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('levels');

  static Stream<LevelsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  LevelsRecord._();
  factory LevelsRecord([void Function(LevelsRecordBuilder) updates]) =
      _$LevelsRecord;

  static LevelsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createLevelsRecordData({
  String level,
}) =>
    serializers.toFirestore(
        LevelsRecord.serializer, LevelsRecord((l) => l..level = level));

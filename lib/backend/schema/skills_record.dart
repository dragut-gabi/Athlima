import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'skills_record.g.dart';

abstract class SkillsRecord
    implements Built<SkillsRecord, SkillsRecordBuilder> {
  static Serializer<SkillsRecord> get serializer => _$skillsRecordSerializer;

  @nullable
  DocumentReference get sport;

  @nullable
  DocumentReference get level;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SkillsRecordBuilder builder) => builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('skills');

  static Stream<SkillsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SkillsRecord._();
  factory SkillsRecord([void Function(SkillsRecordBuilder) updates]) =
      _$SkillsRecord;

  static SkillsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createSkillsRecordData({
  DocumentReference sport,
  DocumentReference level,
}) =>
    serializers.toFirestore(
        SkillsRecord.serializer,
        SkillsRecord((s) => s
          ..sport = sport
          ..level = level));

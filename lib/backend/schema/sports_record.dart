import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'sports_record.g.dart';

abstract class SportsRecord
    implements Built<SportsRecord, SportsRecordBuilder> {
  static Serializer<SportsRecord> get serializer => _$sportsRecordSerializer;

  @nullable
  String get name;

  @nullable
  bool get groupSport;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SportsRecordBuilder builder) => builder
    ..name = ''
    ..groupSport = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sports');

  static Stream<SportsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SportsRecord._();
  factory SportsRecord([void Function(SportsRecordBuilder) updates]) =
      _$SportsRecord;

  static SportsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createSportsRecordData({
  String name,
  bool groupSport,
}) =>
    serializers.toFirestore(
        SportsRecord.serializer,
        SportsRecord((s) => s
          ..name = name
          ..groupSport = groupSport));

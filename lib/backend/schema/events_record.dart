import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get description;

  @nullable
  LatLng get location;

  @nullable
  DateTime get dateTime;

  @nullable
  DocumentReference get skill;

  @nullable
  String get picture;

  @nullable
  DocumentReference get owner;

  @nullable
  BuiltList<DocumentReference> get people;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..picture = ''
    ..people = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventsRecordData({
  String name,
  String description,
  LatLng location,
  DateTime dateTime,
  DocumentReference skill,
  String picture,
  DocumentReference owner,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..name = name
          ..description = description
          ..location = location
          ..dateTime = dateTime
          ..skill = skill
          ..picture = picture
          ..owner = owner
          ..people = null));

import 'package:freezed_annotation/freezed_annotation.dart';

part 'debrief_note.freezed.dart';
part 'debrief_note.g.dart';

@freezed
class RefresherDebriefNote with _$RefresherDebriefNote {
  factory RefresherDebriefNote(
    String ulid,
    String note,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  ) = _RefresherDebriefNote;

  factory RefresherDebriefNote.fromJson(Map<String, dynamic> json) =>
      _$RefresherDebriefNoteFromJson(json);
}

@freezed
class RefresherDebriefNoteResponse with _$RefresherDebriefNoteResponse {
  factory RefresherDebriefNoteResponse(List<RefresherDebriefNote> data) =
      _RefresherDebriefNoteResponse;

  factory RefresherDebriefNoteResponse.fromJson(Map<String, dynamic> json) =>
      _$RefresherDebriefNoteResponseFromJson(json);
}

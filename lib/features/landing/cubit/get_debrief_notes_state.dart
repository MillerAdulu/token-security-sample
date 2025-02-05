part of 'get_debrief_notes_cubit.dart';

@freezed
class GetDebriefNotesState with _$GetDebriefNotesState {
  const factory GetDebriefNotesState.initial() = _Initial;
  const factory GetDebriefNotesState.loading() = _Loading;
  const factory GetDebriefNotesState.loaded({
    required List<RefresherDebriefNote> debriefNotes,
  }) = _Loaded;
  const factory GetDebriefNotesState.empty() = _Empty;
  const factory GetDebriefNotesState.error(String message) = _Error;
}

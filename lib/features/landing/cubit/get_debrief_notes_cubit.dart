import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refresher/models/debrief_note.dart';
import 'package:refresher/models/failure.dart';
import 'package:refresher/services/debrief_service.dart';

part 'get_debrief_notes_state.dart';
part 'get_debrief_notes_cubit.freezed.dart';

class GetDebriefNotesCubit extends Cubit<GetDebriefNotesState> {
  GetDebriefNotesCubit({
    required DebriefService debriefService,
  }) : super(const GetDebriefNotesState.initial()) {
    _debriefService = debriefService;
  }

  late DebriefService _debriefService;

  Future<void> getDebriefNotes() async {
    emit(const GetDebriefNotesState.loading());
    try {
      final debriefNotes = await _debriefService.getDebriefNotes();

      if (debriefNotes.isEmpty) {
        emit(const GetDebriefNotesState.empty());
        return;
      }

      emit(GetDebriefNotesState.loaded(debriefNotes: debriefNotes));
    } on Failure catch (e) {
      emit(GetDebriefNotesState.error(e.message));
    }
  }
}

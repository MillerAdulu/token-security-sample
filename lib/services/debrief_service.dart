import 'package:refresher/models/debrief_note.dart';
import 'package:refresher/utils/network.dart';

// ignore: one_member_abstracts
abstract class DebriefService {
  Future<List<RefresherDebriefNote>> getDebriefNotes();
}

class DebriefServiceImpl implements DebriefService {
  final _networkUtil = NetworkUtil();

  @override
  Future<List<RefresherDebriefNote>> getDebriefNotes() async {
    try {
      final res = await _networkUtil.getReq(
        '/debrief-notes',
      );

      return RefresherDebriefNoteResponse.fromJson(res).data;
    } catch (e) {
      rethrow;
    }
  }
}

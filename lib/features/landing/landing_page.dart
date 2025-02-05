import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresher/features/landing/cubit/get_debrief_notes_cubit.dart';
import 'package:refresher/l10n/l10n.dart';
import 'package:refresher/models/debrief_note.dart';
import 'package:refresher/utils/color_pallete.dart';
import 'package:refresher/utils/custom_text_theme.dart';
import 'package:refresher/utils/misc.dart';

@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    context.read<GetDebriefNotesCubit>().getDebriefNotes();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          l10n.debriefNotes,
          style: CustomTextTheme.customTextTheme().displayLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<GetDebriefNotesCubit, GetDebriefNotesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            loaded: (debriefNotes) {
              if (debriefNotes.isEmpty) {
                return Center(
                  child: Text(
                    l10n.noNotes,
                    style: CustomTextTheme.customTextTheme()
                        .headlineSmall!
                        .copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.appTheme().kPrimaryColorV2,
                        ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: debriefNotes.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) =>
                    DebriefNoteCard(debriefNote: debriefNotes[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class DebriefNoteCard extends StatelessWidget {
  const DebriefNoteCard({
    required this.debriefNote,
    super.key,
  });

  final RefresherDebriefNote debriefNote;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Animate(
      effects: const [SaturateEffect()],
      child: Stack(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 60,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color:
                  AppTheme.appTheme().kSecondaryColorV2.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(48),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  debriefNote.note,
                  style: CustomTextTheme.customTextTheme().bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  Misc.formatDateTime(debriefNote.createdAt),
                  style: CustomTextTheme.customTextTheme().bodySmall,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresher/features/landing/cubit/get_debrief_notes_cubit.dart';
import 'package:refresher/features/landing/landing_page.dart';
import 'package:refresher/l10n/l10n.dart';
import 'package:refresher/utils/color_pallete.dart';
import 'package:refresher/utils/custom_text_theme.dart';

@RoutePage()
class DebriefNotesPage extends StatefulWidget {
  const DebriefNotesPage({super.key});

  @override
  State<DebriefNotesPage> createState() => _DebriefNotesPageState();
}

class _DebriefNotesPageState extends State<DebriefNotesPage> {
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

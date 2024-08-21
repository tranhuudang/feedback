import 'package:feedback/src/better_feedback.dart';
import 'package:feedback/src/l18n/translation.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:flutter/material.dart';

/// Prompt the user for feedback using `StringFeedback`.
Widget simpleFeedbackBuilder(
  BuildContext context,
  OnSubmit onSubmit,
  ScrollController? scrollController,
) =>
    StringFeedback(onSubmit: onSubmit, scrollController: scrollController,);

/// A form that prompts the user for feedback with a single text field.
/// This is the default feedback widget used by [BetterFeedback].
class StringFeedback extends StatefulWidget {
  /// Create a [StringFeedback].
  /// This is the default feedback bottom sheet, which is presented to the user.
  const StringFeedback({
    super.key,
    required this.onSubmit,
    required this.scrollController,
  });

  /// Should be called when the user taps the submit button.
  final OnSubmit onSubmit;

  /// A scroll controller that expands the sheet when it's attached to a
  /// scrollable widget and that widget is scrolled.
  ///
  /// Non null if the sheet is draggable.
  /// See: [FeedbackThemeData.sheetIsDraggable].
  final ScrollController? scrollController;

  @override
  State<StringFeedback> createState() => _StringFeedbackState();
}

class _StringFeedbackState extends State<StringFeedback> {
  late TextEditingController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                FeedbackLocalizations.of(context).feedbackDescriptionText,
                maxLines: 2,
                style:
                    FeedbackTheme.of(context).bottomSheetDescriptionStyle,
              ),
              SizedBox(height: 8,),
              TextField(

                style: FeedbackTheme.of(context).bottomSheetTextInputStyle,
                key: const Key('text_input_field'),
                maxLines: 2,
                minLines: 1,
                controller: controller,
                textInputAction: TextInputAction.newline,
                onChanged: (_) {
                  //print(_);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(32)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(32)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(32)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(32)),
                  ),
                ),
              ),
            ],
          ),
        ),
        FilledButton(
          key: const Key('submit_feedback_button'),
          child: Text(
            FeedbackLocalizations.of(context).submitButtonText,
          ),
          onPressed: () => widget.onSubmit(controller.text),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

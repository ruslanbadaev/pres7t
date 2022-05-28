import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

// ignore: must_be_immutable
class EditebleField extends StatefulWidget {
  String id;
  String title;
  String subtitle;
  Function onSaved;

  EditebleField({
    Key? key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<EditebleField> createState() => _EditebleFieldWidgetState();
}

class _EditebleFieldWidgetState extends State<EditebleField> {
  bool isEdited = false;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: AdaptiveTheme.of(context).theme.textTheme.bodyText1,
      ),
      subtitle: isEdited
          ? TextField(
              controller: controller,
              cursorColor: AppColors.BLUE,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: AppColors.ORANGE,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Type me",
                fillColor: AppColors.BLUE,
                hoverColor: AppColors.BLUE,
                focusColor: AppColors.BLUE,
              ),
              style: AdaptiveTheme.of(context).theme.textTheme.bodyText2!.copyWith(color: AppColors.BLUE),
            )
          : Text(
              widget.subtitle,
              style: AdaptiveTheme.of(context).theme.textTheme.bodyText1,
            ),
      trailing: isEdited
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.save_rounded),
                  onPressed: () => {
                    setState(() {
                      isEdited = false;
                    }),
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                  ),
                  onPressed: () => {
                    setState(() {
                      controller.text = widget.subtitle;
                      isEdited = false;
                    }),
                  },
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.edit_rounded),
              onPressed: () => {
                setState(() {
                  isEdited = true;
                }),
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.actionText,
    this.onPressed,
  });

  final String? actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          actionText ?? 'okay',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
              ),
        ));
  }
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.error),
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}

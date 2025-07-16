import 'package:flutter/material.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

Future<bool?> showConfirmDeleteDialog(
  BuildContext context,
  AppLocalizations l10n,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.confirmDeleteTitle),
        content: Text(l10n.confirmDeleteMessage),
        actions: [
          TextButton(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(l10n.delete),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );
}

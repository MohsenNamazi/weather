import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    assert(localizations != null, 'AppLocalizations is not available');
    return localizations!;
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get bottomPadding => mediaQuery.padding.bottom;

  double get topPadding => mediaQuery.padding.top;

  Orientation get oritentation => MediaQuery.of(this).orientation;

  bool get isPortrait => oritentation == Orientation.portrait;

  double get width => MediaQuery.sizeOf(this).width;
}

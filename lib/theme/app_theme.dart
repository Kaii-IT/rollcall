import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF0E6B5C);
  static const Color primaryDark = Color(0xFF0A5247);
  static const Color primarySoft = Color(0xFFDCEFEA);
  static const Color accent = Color(0xFFF26B4F);
  static const Color accentSoft = Color(0xFFFDE5DE);
  static const Color ink = Color(0xFF14201E);
  static const Color secondary = Color(0xFF5B6664);
  static const Color hairline = Color(0xFFE4E1D9);
  static const Color background = Color(0xFFF7F5F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB3261E);
}

abstract final class AppFonts {
  static const String text = 'SF Pro Text';
  static const String display = 'SF Pro Display';

  // SF Pro isn't bundled (licensing). Apple platforms resolve the Cupertino
  // system names to SF; other platforms fall through to their own grotesques.
  static const List<String> textFallback = [
    'CupertinoSystemText',
    '.SF UI Text',
    'Helvetica Neue',
    'Roboto',
    'Segoe UI',
    'Noto Sans',
    'Arial',
  ];

  static const List<String> displayFallback = [
    'CupertinoSystemDisplay',
    '.SF UI Display',
    'Helvetica Neue',
    'Roboto',
    'Segoe UI',
    'Noto Sans',
    'Arial',
  ];
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;
  static const double xxl = 64;
}

enum ScreenSize { compact, medium, expanded }

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 900;

  static ScreenSize of(double width) {
    if (width >= expanded) return ScreenSize.expanded;
    if (width >= medium) return ScreenSize.medium;
    return ScreenSize.compact;
  }

  static double gutter(double width) => switch (of(width)) {
        ScreenSize.compact => AppSpacing.lg,
        ScreenSize.medium => 40,
        ScreenSize.expanded => 64,
      };
}

abstract final class AppTheme {
  static const TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: AppFonts.display,
      fontFamilyFallback: AppFonts.displayFallback,
      fontSize: 34,
      height: 1.12,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.8,
      color: AppColors.ink,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFonts.display,
      fontFamilyFallback: AppFonts.displayFallback,
      fontSize: 24,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      color: AppColors.ink,
    ),
    titleMedium: TextStyle(
      fontSize: 17,
      height: 1.3,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.ink,
    ),
    bodyLarge: TextStyle(
      fontSize: 17,
      height: 1.45,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2,
      color: AppColors.ink,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      height: 1.4,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.1,
      color: AppColors.secondary,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      height: 1.35,
      fontWeight: FontWeight.w400,
      color: AppColors.secondary,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
  );

  static OutlineInputBorder _border(Color color, [double width = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );

  static ThemeData get light {
    const scheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primarySoft,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.accent,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.accentSoft,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.secondary,
      outline: AppColors.hairline,
      outlineVariant: AppColors.hairline,
      error: AppColors.error,
      onError: Colors.white,
      surfaceTint: Colors.transparent,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppFonts.text,
      fontFamilyFallback: AppFonts.textFallback,
      textTheme: _textTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: Color(0x330E6B5C),
        selectionHandleColor: AppColors.primary,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.hairline,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(
          color: AppColors.secondary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: const TextStyle(color: AppColors.error, fontSize: 13, height: 1.3),
        border: _border(AppColors.hairline),
        enabledBorder: _border(AppColors.hairline),
        focusedBorder: _border(AppColors.primary, 2),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFB9C9C5),
          disabledForegroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: _textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.hairline),
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          minimumSize: const Size(44, 44),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class Wordmark extends StatelessWidget {
  const Wordmark({super.key, this.color = AppColors.ink});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: 'Rollcall',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Rollcall',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Login and sign-up frame. Expanded widths get a teal brand panel beside
/// the form; narrower widths stack a teal banner above it.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  static const double _formMaxWidth = 440;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final size = Breakpoints.of(width);
          final gutter = Breakpoints.gutter(width);

          if (size == ScreenSize.expanded) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(flex: 5, child: _BrandPanel()),
                Expanded(
                  flex: 6,
                  child: SafeArea(
                    left: false,
                    child: Center(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 48),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: _formMaxWidth),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BrandBanner(gutter: gutter, isMedium: size == ScreenSize.medium),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(gutter, 36, gutter, AppSpacing.xl),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: _formMaxWidth),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

const _brandHeadline = 'Every member, every meeting, accounted for.';
const _brandPoints = [
  'Check in at the door with one tap',
  'See who showed up to each meeting',
  'Share rosters with your club officers',
];

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        right: false,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(56),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: (constraints.maxHeight - 112).clamp(0, double.infinity)),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Wordmark(color: Colors.white),
                    const Spacer(),
                    Container(width: 48, height: 4, color: AppColors.accent),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      _brandHeadline,
                      style: text.displaySmall?.copyWith(color: Colors.white, fontSize: 40),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    for (final point in _brandPoints) _BrandPoint(label: point),
                    const Spacer(),
                    Text(
                      'Built for university clubs and societies.',
                      style: text.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandBanner extends StatelessWidget {
  const _BrandBanner({required this.gutter, required this.isMedium});

  final double gutter;
  final bool isMedium;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(gutter, 20, gutter, isMedium ? 40 : 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wordmark(color: Colors.white),
              SizedBox(height: isMedium ? 40 : 28),
              Container(width: 36, height: 4, color: AppColors.accent),
              const SizedBox(height: AppSpacing.md),
              Text(
                _brandHeadline,
                style: (isMedium ? text.displaySmall : text.headlineSmall)
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandPoint extends StatelessWidget {
  const _BrandPoint({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(color: AppColors.primaryDark, shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, size: 16, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Signed-in frame: teal top bar with the wordmark, centered content that
/// widens with the screen.
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child, this.trailing});

  final Widget child;
  final Widget? trailing;

  static const double maxContentWidth = 1040;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final gutter = Breakpoints.gutter(constraints.maxWidth);
          final isCompact = Breakpoints.of(constraints.maxWidth) == ScreenSize.compact;

          Widget constrained(Widget content) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxContentWidth),
                  child: content,
                ),
              );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: AppColors.primary,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 12),
                    child: constrained(
                      SizedBox(
                        height: 44,
                        child: Row(
                          children: [
                            const Wordmark(color: Colors.white),
                            const Spacer(),
                            ?trailing,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    gutter,
                    isCompact ? 32 : 56,
                    gutter,
                    AppSpacing.xl,
                  ),
                  child: SafeArea(top: false, child: constrained(child)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppPageHeader extends StatelessWidget {
  const AppPageHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(header: true, child: Text(title, style: text.displaySmall)),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(subtitle!, style: text.bodyLarge?.copyWith(color: AppColors.secondary)),
        ],
      ],
    );
  }
}

class AuthSwitchPrompt extends StatelessWidget {
  const AuthSwitchPrompt({
    super.key,
    required this.prompt,
    required this.action,
    required this.onPressed,
  });

  final String prompt;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: Theme.of(context).textTheme.bodyMedium),
        TextButton(onPressed: onPressed, child: Text(action)),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.autofillHints = const [AutofillHints.password],
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String> autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscured,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: TextButton(
            onPressed: () => setState(() => _obscured = !_obscured),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size(56, 40),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            child: Text(
              _obscured ? 'Show' : 'Hide',
              semanticsLabel: _obscured ? 'Show password' : 'Hide password',
            ),
          ),
        ),
      ),
    );
  }
}

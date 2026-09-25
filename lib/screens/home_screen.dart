
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'login_screen.dart';

class HomeArgs {
  const HomeArgs({required this.name});

  final String name;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  static const _sessions = [
    _Session(
      'Robotics Society',
      'Build night',
      'Engineering Hall 204',
      '4:00 PM',
      AppColors.primary,
      AppColors.primarySoft,
    ),
    _Session(
      'Debate Union',
      'Motion practice',
      'Library Seminar B',
      '6:30 PM',
      AppColors.accent,
      AppColors.accentSoft,
    ),
  ];

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final name = args is HomeArgs && args.name.trim().isNotEmpty ? args.name.trim() : 'there';
    final text = Theme.of(context).textTheme;
    final count = _sessions.length;

    return AppScaffold(
      trailing: OutlinedButton(
        onPressed: () => _logout(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white54),
        ),
        child: const Text('Log out'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPageHeader(
            title: 'Welcome, $name.',
            subtitle: count == 1
                ? 'One meeting is open for check-in today.'
                : '$count meetings are open for check-in today.',
          ),
          const SizedBox(height: 48),
          Semantics(header: true, child: Text('Today', style: text.titleMedium)),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.md;
              final columns = constraints.maxWidth >= 640 ? 2 : 1;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final session in _sessions)
                    SizedBox(width: cardWidth, child: _SessionCard(session: session)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Session {
  const _Session(this.club, this.title, this.room, this.time, this.color, this.tint);

  final String club;
  final String title;
  final String room;
  final String time;
  final Color color;
  final Color tint;
}

class _SessionCard extends StatefulWidget {
  const _SessionCard({required this.session});

  final _Session session;

  @override
  State<_SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<_SessionCard> {
  bool _checkedIn = false;

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final text = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 6, color: session.color),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          session.club,
                          style: text.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: session.tint,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          session.time,
                          style: text.bodySmall?.copyWith(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(session.title, style: text.bodyLarge),
                  const SizedBox(height: 2),
                  Text(session.room, style: text.bodyMedium),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: _checkedIn
                        ? OutlinedButton.icon(
                            onPressed: () => setState(() => _checkedIn = false),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              foregroundColor: session.color,
                              side: BorderSide(color: session.color),
                            ),
                            icon: const Icon(Icons.check_rounded, size: 18),
                            label: const Text('Checked in'),
                          )
                        : FilledButton(
                            onPressed: () => setState(() => _checkedIn = true),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              backgroundColor: session.color,
                            ),
                            child: const Text('Check in'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

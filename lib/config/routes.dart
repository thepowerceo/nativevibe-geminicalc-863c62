import 'package:gemini_calc/screens/calculator_screen.dart';
import 'package:gemini_calc/screens/history_screen.dart';
import 'package:gemini_calc/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main router for the application.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'calculator',
      pageBuilder: (context, state) => _buildPageWithFadeTransition(
        context: context,
        state: state,
        child: CalculatorScreen())),
    GoRoute(
      path: '/history',
      name: 'history',
      pageBuilder: (context, state) => _buildPageWithFadeTransition(
        context: context,
        state: state,
        child: HistoryScreen())),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => _buildPageWithFadeTransition(
        context: context,
        state: state,
        child: SettingsScreen())),
  ]);

// Helper function for a consistent fade transition
CustomTransitionPage<void> _buildPageWithFadeTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child));
}
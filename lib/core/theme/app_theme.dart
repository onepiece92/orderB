import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_decorations.dart';
import 'app_text_styles.dart';

/// Material theme wiring all brand tokens.
final class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.darkBrown,
          onPrimary: AppColors.cream,
          secondary: AppColors.caramel,
          onSecondary: AppColors.white,
          surface: AppColors.warmWhite,
          onSurface: AppColors.text,
          error: AppColors.terracotta,
        ),
        scaffoldBackgroundColor: AppColors.warmWhite,
        textTheme: GoogleFonts.dmSansTextTheme().copyWith(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelMedium: AppTextStyles.label,
          labelSmall: AppTextStyles.labelSmall,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.warmWhite,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: AppColors.darkBrown),
          titleTextStyle: AppTextStyles.headlineLarge,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkBrown,
            foregroundColor: AppColors.cream,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDecorations.radiusL),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: AppTextStyles.buttonPrimary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkBrown,
            side: const BorderSide(color: AppColors.darkBrown, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.softBrown,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDecorations.radiusS),
            ),
          ).copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.darkBrown;
              }
              return AppColors.beige;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return AppColors.cream;
              return AppColors.softBrown;
            }),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.darkBrown;
              }
              return AppColors.beige;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return AppColors.cream;
              return AppColors.softBrown;
            }),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusML)),
            ),
            minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.darkBrown;
              }
              return AppColors.beige;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return AppColors.cream;
              return AppColors.softBrown;
            }),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusS)),
            ),
            side: const WidgetStatePropertyAll(BorderSide.none),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide: const BorderSide(color: AppColors.beige, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide: const BorderSide(color: AppColors.beige, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide: const BorderSide(color: AppColors.caramel, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textLight),
        ),
        dividerColor: AppColors.beige,
        dividerTheme: const DividerThemeData(
          color: AppColors.beige,
          thickness: 1,
          space: 0,
        ),
        cardTheme: const CardThemeData(
          color: AppColors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppDecorations.radiusCard)),
            side: BorderSide(color: AppColors.beige),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.golden,
          labelStyle: AppTextStyles.labelSmall.copyWith(color: AppColors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusSM),
            side: BorderSide.none,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDecorations.radiusCard)),
          ),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          AppThemeExtension(
            productImageGradient: AppColors.productImageGradient,
            primaryGradient: AppColors.primaryGradient,
            heroGradient: AppColors.heroGradient,
          ),
        ],
      );

  // ─── Dark Theme ─────────────────────────────────────────────
  static const _darkSurface = Color(0xFF1A1412);
  static const _darkCard = Color(0xFF251E1A);
  static const _darkDivider = Color(0xFF3A302A);

  static ThemeData get dark => light.copyWith(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.golden,
          onPrimary: AppColors.darkBrown,
          secondary: AppColors.caramel,
          onSecondary: AppColors.darkBrown,
          surface: _darkSurface,
          onSurface: AppColors.cream,
          error: AppColors.terracotta,
          onSurfaceVariant: Color(0xFF9A8B7D),
        ),
        scaffoldBackgroundColor: _darkSurface,
        cardColor: _darkCard,
        dividerColor: _darkDivider,
        appBarTheme: AppBarTheme(
          backgroundColor: _darkSurface,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: AppColors.cream),
          titleTextStyle: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.cream,
          ),
        ),
        cardTheme: const CardThemeData(
          color: _darkCard,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppDecorations.radiusCard)),
            side: BorderSide(color: _darkDivider),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: _darkDivider,
          thickness: 1,
          space: 0,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: _darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDecorations.radiusCard)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _darkCard,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide: const BorderSide(color: _darkDivider, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide: const BorderSide(color: _darkDivider, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            borderSide:
                const BorderSide(color: AppColors.golden, width: 1.5),
          ),
          hintStyle: AppTextStyles.bodyMedium
              .copyWith(color: const Color(0xFF9A8B7D)),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          AppThemeExtension(
            productImageGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2A2220), Color(0xFF352A24)],
            ),
            primaryGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.golden, AppColors.caramel],
            ),
            heroGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2A2220), Color(0xFF352A24), Color(0xFF3D302A)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ],
      );
}

/// Custom theme extension for properties not supported by default ThemeData.
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Gradient productImageGradient;
  final Gradient primaryGradient;
  final Gradient heroGradient;

  const AppThemeExtension({
    required this.productImageGradient,
    required this.primaryGradient,
    required this.heroGradient,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Gradient? productImageGradient,
    Gradient? primaryGradient,
    Gradient? heroGradient,
  }) {
    return AppThemeExtension(
      productImageGradient: productImageGradient ?? this.productImageGradient,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      heroGradient: heroGradient ?? this.heroGradient,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      covariant ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      productImageGradient:
          Gradient.lerp(productImageGradient, other.productImageGradient, t)!,
      primaryGradient:
          Gradient.lerp(primaryGradient, other.primaryGradient, t)!,
      heroGradient: Gradient.lerp(heroGradient, other.heroGradient, t)!,
    );
  }
}

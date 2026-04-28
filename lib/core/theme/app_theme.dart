/// App Theme Constants
/// This file contains theme constants that would be used with Flutter
/// Since Flutter dependencies are not available, this provides the constants
/// that can be used when Flutter is integrated

class AppTheme {
  // Color constants (as hex strings for now, would be Color objects in Flutter)
  static const String primaryColorHex = '#FF6200EE';
  static const String errorColorHex = '#FFD32F2F';
  static const String successColorHex = '#FF388E3C';
  static const String borderColorHex = '#FFE0E0E0';
  static const String textPrimaryHex = '#FF212121';
  static const String textSecondaryHex = '#FF757575';
  static const String scaffoldBgHex = '#FFFAFAFA';

  // Numeric color values (can be used with Color.fromARGB in Flutter)
  static const int primaryColorValue = 0xFF6200EE;
  static const int errorColorValue = 0xFFD32F2F;
  static const int successColorValue = 0xFF388E3C;
  static const int borderColorValue = 0xFFE0E0E0;
  static const int textPrimaryValue = 0xFF212121;
  static const int textSecondaryValue = 0xFF757575;
  static const int scaffoldBgValue = 0xFFFAFAFA;

  // Spacing constants
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;

  // Border radius
  static const double borderRadius12 = 12.0;
  static const double borderRadius16 = 16.0;

  // Theme configuration (as Map for now, would be ThemeData in Flutter)
  static Map<String, dynamic> get lightThemeConfig => {
    'useMaterial3': true,
    'primaryColor': primaryColorHex,
    'errorColor': errorColorHex,
    'successColor': successColorHex,
    'scaffoldBackgroundColor': scaffoldBgHex,
    'borderRadius': borderRadius12,
    'spacing': {
      'small': spacing8,
      'medium': spacing12,
      'large': spacing16,
      'xlarge': spacing24,
    },
  };

  // Input decoration theme configuration
  static Map<String, dynamic> get inputDecorationConfig => {
    'borderRadius': borderRadius12,
    'borderColor': borderColorHex,
    'focusedBorderColor': primaryColorHex,
    'fillColor': '#FFFFFF',
    'contentPadding': {'horizontal': spacing16, 'vertical': spacing12},
  };

  // Helper method to get color as hex string
  static String getColorHex(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return primaryColorHex;
      case 'error':
        return errorColorHex;
      case 'success':
        return successColorHex;
      case 'border':
        return borderColorHex;
      case 'textPrimary':
        return textPrimaryHex;
      case 'textSecondary':
        return textSecondaryHex;
      case 'scaffold':
        return scaffoldBgHex;
      default:
        return primaryColorHex;
    }
  }

  // Helper method to get color as integer value
  static int getColorValue(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return primaryColorValue;
      case 'error':
        return errorColorValue;
      case 'success':
        return successColorValue;
      case 'border':
        return borderColorValue;
      case 'textPrimary':
        return textPrimaryValue;
      case 'textSecondary':
        return textSecondaryValue;
      case 'scaffold':
        return scaffoldBgValue;
      default:
        return primaryColorValue;
    }
  }

  // Demo method to show theme information
  static void demonstrateTheme() {
    print('=== App Theme Information ===');
    print('Primary Color: $primaryColorHex');
    print('Error Color: $errorColorHex');
    print('Success Color: $successColorHex');
    print('Border Radius: ${borderRadius12}px');
    print(
      'Spacing: ${spacing8}px, ${spacing12}px, ${spacing16}px, ${spacing24}px',
    );
    print('Theme configuration ready for Flutter integration');
  }
}

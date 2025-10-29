# HeyGen AI Avatar Integration Setup Guide

## Overview

This implementation integrates HeyGen's interactive AI avatar into your Flutter hero section, providing real-time video streaming and voice interaction capabilities.

## Files Created/Modified

### New Files:

1. **`lib/services/heygen_service.dart`** - WebSocket service for HeyGen API communication
2. **`lib/widgets/interactive_avatar_widget.dart`** - Interactive avatar widget component
3. **`lib/constants/heygen_config.dart`** - Configuration constants for HeyGen

### Modified Files:

1. **`pubspec.yaml`** - Added required dependencies
2. **`lib/widgets/hero_section.dart`** - Integrated the interactive avatar widget

## Dependencies Added

```yaml
web_socket_channel: ^2.4.0 # WebSocket communication
video_player: ^2.8.0 # Video streaming
http: ^1.1.0 # API calls
permission_handler: ^11.0.0 # Camera/microphone permissions
```

## Setup Instructions

### 1. HeyGen Account Setup

1. Create an account at [heygen.com](https://www.heygen.com/)
2. Navigate to your dashboard and create a streaming avatar
3. Generate an API key from your account settings
4. Note down your Avatar ID and Voice ID (optional)

### 2. Configuration

Update `lib/constants/heygen_config.dart` with your actual credentials:

```dart
static const String apiKey = 'YOUR_ACTUAL_API_KEY';
static const String avatarId = 'YOUR_ACTUAL_AVATAR_ID';
static const String voiceId = 'YOUR_ACTUAL_VOICE_ID'; // Optional
```

### 3. Install Dependencies

Run the following command to install the new dependencies:

```bash
flutter pub get
```

## Features Implemented

### Interactive Avatar Widget

- **Real-time Connection**: WebSocket connection to HeyGen streaming service
- **Video Streaming**: Displays avatar video feed (placeholder implementation)
- **Audio Handling**: Captures and processes audio input/output
- **Language Support**: Multi-language support with dropdown selector
- **Status Indicators**: Connection status, speaking, and listening indicators
- **Error Handling**: Graceful fallback states and retry mechanisms

### Connection States

- **Connecting**: Shows loading indicator while establishing connection
- **Connected**: Avatar is active and ready for interaction
- **Disconnected**: Shows error state with retry option
- **Speaking**: Visual indicator when avatar is speaking
- **Listening**: Visual indicator when avatar is listening for input

### Controls

- **Language Selector**: Dropdown to change avatar language
- **Microphone Toggle**: Start/stop listening for voice input
- **Chat Now Button**: Initiates chat interaction

## Usage

The avatar widget automatically:

1. Initializes connection to HeyGen service
2. Establishes WebSocket connection
3. Handles video/audio streaming
4. Manages connection states and errors
5. Provides interactive controls

## Customization

### Adding New Languages

Update the `languages` map in `heygen_config.dart`:

```dart
static const Map<String, String> languages = {
  'en': 'English',
  'es': 'Spanish',
  'fr': 'French',
  'de': 'German',
  'zh': 'Chinese',
  'ja': 'Japanese',
  'ko': 'Korean',
  'your_code': 'Your Language', // Add new languages here
};
```

### Styling

The avatar widget uses the same styling as the original placeholder:

- 400x300 container with rounded corners
- Dark border and shadow effects
- Gradient background when connected
- Consistent color scheme with your app

### Event Handling

Implement custom handlers in `hero_section.dart`:

```dart
void _handleChatNowPressed() {
  // Navigate to chat page or show chat interface
  // Implement your navigation logic here
}

void _handleLanguageChange(String language) {
  // Handle language change
  // Implement your language switching logic here
}
```

## Error Handling

The implementation includes comprehensive error handling:

- Connection timeouts
- WebSocket disconnections
- API errors
- Fallback states for offline scenarios
- Retry mechanisms for failed connections

## Next Steps

1. **Replace placeholder credentials** with your actual HeyGen API key and avatar ID
2. **Test the connection** by running the app
3. **Implement video streaming** by replacing the placeholder video handling
4. **Add audio recording** functionality for voice input
5. **Customize the chat flow** by implementing the `_handleChatNowPressed` method
6. **Add navigation** to a dedicated chat page if needed

## Troubleshooting

### Common Issues:

1. **Connection Failed**: Verify your API key and avatar ID are correct
2. **WebSocket Errors**: Check your internet connection and HeyGen service status
3. **Video Not Displaying**: The current implementation shows a placeholder - implement actual video streaming
4. **Audio Issues**: Implement microphone permissions and audio recording

### Debug Information:

The service logs connection status and errors to the console for debugging purposes.

## Security Notes

- Store API keys securely (consider using environment variables)
- Implement proper error handling to avoid exposing sensitive information
- Use HTTPS/WSS connections for production environments

// GENERATED STUB: Frontend asset registry structure for backend context
// Note: This is a lightweight placeholder to mirror the public site contract.
// If you add or change assets, consider generating a full registry.

/// Minimal compiled asset registry data.
/// Keys can be expanded to include concrete asset listings if needed.
const Map<String, dynamic> compiledAssetRegistry = {
  'images': <String>[],
  'videos': <String>[],
  'other': <String>[],
};

/// Returns a JSON-serializable representation of the asset registry.
Map<String, dynamic> compiledAssetRegistryToJson() {
  return {
    'images': compiledAssetRegistry['images'] ?? <String>[],
    'videos': compiledAssetRegistry['videos'] ?? <String>[],
    'other': compiledAssetRegistry['other'] ?? <String>[],
  };
}

/// Get assets by a simple type classifier.
List<String> getAssetsByType(String type) {
  switch (type) {
    case 'image':
      return List<String>.from(compiledAssetRegistry['images'] ?? const []);
    case 'video':
      return List<String>.from(compiledAssetRegistry['videos'] ?? const []);
    default:
      return List<String>.from(compiledAssetRegistry['other'] ?? const []);
  }
}

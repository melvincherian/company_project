import 'package:flutter/material.dart';

/// Represents an item that can be added to the poster editor.
/// 
/// This class keeps track of the item's position, selection state,
/// scaling, rotation, and the actual widget to display.
class EditorItem {
  /// Unique identifier for the item
  final String id;
  
  /// Current position of the item on the canvas
  Offset position;
  
  /// The actual widget to display (Text, Image, etc.)
  final Widget child;
  
  /// Whether this item is currently selected
  bool isSelected;
  
  /// Current scale factor (for resizing)
  double scale;
  
  /// Current rotation in radians
  double rotation;

  /// Creates a new editor item
  /// 
  /// [id] - Unique identifier for the item
  /// [position] - Initial position on the canvas
  /// [child] - The widget to display
  /// [isSelected] - Whether the item is initially selected
  /// [scale] - Initial scale factor
  /// [rotation] - Initial rotation in radians
  EditorItem({
    required this.id,
    required this.position,
    required this.child,
    this.isSelected = false,
    this.scale = 1.0,
    this.rotation = 0.0,
  });
  
  /// Creates a copy of this item with optional parameter overrides
  EditorItem copyWith({
    String? id,
    Offset? position,
    Widget? child,
    bool? isSelected,
    double? scale,
    double? rotation,
  }) {
    return EditorItem(
      id: id ?? this.id,
      position: position ?? this.position,
      child: child ?? this.child,
      isSelected: isSelected ?? this.isSelected,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
    );
  }
}
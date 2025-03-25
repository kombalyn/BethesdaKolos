import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double opacity;
  final bool showIcon; // Add this line

  GradientButton({
    required this.text,
    required this.gradient,
    required this.onPressed,
    this.opacity = 0.9, // Default opacity value
    this.showIcon = true, // Default to showing the icon
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey.shade600,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

        final textWidth = textPainter.size.width;

        return SizedBox(
          width: textWidth + 150.0, // Add some padding
          height: 50.0, // Set a fixed height
          child: Stack(
            children: [
              // Outline container for shifted shadow effect
              Positioned(
                top: 5.0,
                left: 5.0,
                child: Container(
                  width:
                      textWidth + 100.0, // Adjusted width to match the button
                  height: 40.0, // Adjusted height to match the button
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey.shade600, width: 1.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              // Main button container with static opacity
              Positioned(
                top: 0.0,
                left: 0.0,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: textWidth + 100.0,
                    // Slightly smaller to fit within the outline
                    height: 40.0,
                    // Slightly smaller to fit within the outline
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        // Adjust padding to center text
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: onPressed,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // Center align children
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey.shade600,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (showIcon)
                            Icon(Icons.arrow_right,
                                color: Colors.grey.shade600,
                                size: 30.0), // Adjust size as needed
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

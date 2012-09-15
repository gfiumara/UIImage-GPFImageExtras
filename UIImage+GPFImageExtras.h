//
//  UIImage+GPFImageExtras.h
//

#import <UIKit/UIKit.h>

@interface UIImage (GPFImageExtras)

/// @brief
/// Create a UIImage with a two-color radial gradient.
/// @details
/// Based on http://stackoverflow.com/a/5628594/277718
///
/// @param size
///	The dimensions of the UIImage to create.
/// @param centerColor
///	The color at the center of the gradient.
/// @param outsideColor
///	The color at the outside of the gradient.
/// @param centerPoint
///	Relative point within bounds (0.0 - 1.0).
/// @param radius
///	Relative radius within bounds (0.0 - 1.0);
///
/// @return
///	Autoreleased UIImage with radial gradient.
+ (UIImage *)imageWithRadialGradientWithSize:(CGSize)size
				 centerColor:(UIColor *)centerColor
				outsideColor:(UIColor *)outsideColor
				 centerPoint:(CGPoint)centerPoint
				      radius:(float)radius;

/// @brief
/// Create a UIImage filled with a color.
///
/// @param color
///	Color to fill within the image.
/// @param size
///	Size of the image.
///
/// @return
///	Autoreleased UIImage filled with color.
+ (UIImage *)imageWithColor:(UIColor *)color
		       size:(CGSize)size;

@end

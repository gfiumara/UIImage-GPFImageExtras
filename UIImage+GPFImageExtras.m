//
//  UIImage+GPFImageExtras.m
//

#import "UIImage+GPFImageExtras.h"

@implementation UIImage (GPFImageCategories)

+ (UIImage *)imageWithRadialGradientWithSize:(CGSize)size
				 centerColor:(UIColor *)centerColor
				outsideColor:(UIColor *)outsideColor
				 centerPoint:(CGPoint)centerPoint
				      radius:(float)radius
{
	static const size_t kNumberOfColors = 2;

	UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
	
	// Extract RGB color components from parameters
	size_t numberOfColorComponents = CGColorGetNumberOfComponents([centerColor CGColor]);
	CGFloat *colorComponents = (CGFloat *)calloc(numberOfColorComponents * 2, sizeof(CGFloat));
	if (colorComponents == NULL) {
		UIGraphicsEndImageContext();
		return (nil);
	}
	memcpy(colorComponents, CGColorGetComponents([centerColor CGColor]), numberOfColorComponents * sizeof(CGFloat));
	memcpy(colorComponents + numberOfColorComponents, CGColorGetComponents([outsideColor CGColor]), numberOfColorComponents * sizeof(CGFloat));
	
	// Create the gradient
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, NULL, kNumberOfColors);
	
	// Normalize the center and radius
	CGPoint normalizedCenterPoint = CGPointMake(centerPoint.x * size.width, centerPoint.y * size.height);
	float normalizedRadius = MIN(size.width, size.height) * radius;
	
	// Draw it
	CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), gradient, normalizedCenterPoint, 0, normalizedCenterPoint, normalizedRadius, kCGGradientDrawsAfterEndLocation);
	
	// Grab it as an autoreleased image
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
	// Clean up
	if (colorComponents != NULL)
		free(colorComponents);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
	UIGraphicsEndImageContext();
	
	return (image);
}

+ (UIImage *)imageWithColor:(UIColor *)color
		       size:(CGSize)size
{
	CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return (image);
}

@end

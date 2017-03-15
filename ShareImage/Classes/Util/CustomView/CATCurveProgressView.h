//
//  CATCurveProgressView.h
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CATCurveProgressView : UIView

//Curve background color
@property (nonatomic, strong) IBInspectable UIColor *curveBgColor;

//Enable gradient effect
@property (nonatomic, assign) IBInspectable CGFloat enableGradient;

//Set gradient origin color
@property (nonatomic, assign) IBInspectable UIColor *gradient1;

//Set gradient ending color
@property (nonatomic, assign) IBInspectable UIColor *gradient2;

//Gradient layer1［you can custom gradient effect by set gradient layer1's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer1;

//Gradient layer2［you can custom gradient effect by set gradient layer2's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer2;

//Progress color when gradient effect is disable [!!!do no use clearColor]
@property (nonatomic, strong) IBInspectable UIColor *progressColor;

//Progress line width
@property (nonatomic, assign) IBInspectable CGFloat progressLineWidth;

//Start angle
@property (nonatomic, assign) IBInspectable int startAngle;

//End angle
@property (nonatomic, assign) IBInspectable int endAngle;

//Progress [0.0-1.0]
@property (nonatomic, assign) IBInspectable CGFloat progress;

/**
 *  Set progress
 *
 *  @param progress progress[0.0-1.0]
 *  @param animated enbale animation?
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated compleBlock:(VoidBlock)compleBlock;

@end

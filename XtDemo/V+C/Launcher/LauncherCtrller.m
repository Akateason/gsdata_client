//
//  WarmUpCtrller.m
//  GroupBuying
//
//  Created by teason on 16/3/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "LauncherCtrller.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@interface LauncherCtrller ()
@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@end

@implementation LauncherCtrller

static NSString *const STR_SHOW = @"速报酱·内部·工具" ;

+ (void)modalToLauncherWithCurrentCtrller:(UIViewController *)ctrller
{
    LauncherCtrller *launcher = [[LauncherCtrller alloc] init] ;
    [ctrller presentViewController:launcher
                          animated:NO
                        completion:^{
                            
                        }] ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    
    self.animationLayer = [CALayer layer];
    self.animationLayer.frame = APPFRAME ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self.view.layer addSublayer:self.animationLayer];
    
    [self setupTextLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;

    [self startAnimation];
}

- (void) startAnimation
{
    [self.pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5f;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.delegate = self ;
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    if ([anim.keyPath isEqualToString:@"strokeEnd"])
    {
        sleep(1) ;
        
        [self dismissViewControllerAnimated:YES
                                 completion:^{
            [self.pathLayer removeAllAnimations];
            self.pathLayer = nil ;
            [self.animationLayer removeAllAnimations];
            self.animationLayer = nil ;
        }];
    }
}

- (void)setupTextLayer
{
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 31.0f, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:STR_SHOW
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.animationLayer.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor xt_mainColor].CGColor ;//[UIColor colorWithRed:234.0/255 green:84.0/255 blue:87.0/255 alpha:1].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 2.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.animationLayer addSublayer:pathLayer];
//    self.animationLayer.speed = 1.;
//    self.animationLayer.timeOffset = 0;
    self.pathLayer = pathLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

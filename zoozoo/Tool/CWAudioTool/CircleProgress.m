//
//  CircleProgress.m
//  ZZCircleProgressDemo
//
//  Created by 🍎上的豌豆 on 2019/6/10.
//  Copyright © 2019 YiNain. All rights reserved.
//

#import "CircleProgress.h"


@interface CircleProgress ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat realWidth;//实际边长
@property (nonatomic, assign) CGFloat radius;//半径


@end
@implementation CircleProgress

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
                pathBackColor:(UIColor *)pathBackColor
                pathFillColor:(UIColor *)pathFillColor
                   startAngle:(CGFloat)startAngle
                  strokeWidth:(CGFloat)strokeWidth {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        self.pathBackColor = pathBackColor;
        self.pathFillColor = pathFillColor;
        _startAngle = CircleDegreeToRadian(startAngle);
        _strokeWidth = strokeWidth;
    }
    return self;
}

//初始化数据
- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _pathBackColor = CircleRGB(217, 175, 253);
    _pathFillColor = [UIColor whiteColor];
    
    _strokeWidth = 4;//线宽默认为10
    _startAngle = CircleDegreeToRadian(270);//圆起点位置
    _reduceAngle = CircleDegreeToRadian(0);//整个圆缺少的角度
    
    _duration = 10;//动画时长
    
    //初始化layer
    [self initSubviews];
}

#pragma Get
- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _backLayer.lineWidth = 2;
        _backLayer.strokeColor = _pathBackColor.CGColor;
        _backLayer.lineCap = @"round";
    }
    return _backLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _progressLayer.lineWidth = 4;
        _progressLayer.strokeColor = _pathFillColor.CGColor;
        _progressLayer.lineCap = @"round";
    }
    return _progressLayer;
}

- (UIImageView *)pointImage {
    if (!_pointImage) {
        _pointImage = [[UIImageView alloc] init];
       [_pointImage setImage:[UIImage imageNamed:@"circle_point1.png"]];
    }
    return _pointImage;
}

- (CAAnimation *)pathAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = _duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:_progress];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    return pathAnimation;
}

- (CAAnimation *)pointAnimation {
    CAKeyframeAnimation *pointAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pointAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pointAnimation.fillMode = kCAFillModeForwards;
    pointAnimation.calculationMode = @"paced";
    pointAnimation.removedOnCompletion = NO;
    pointAnimation.duration = _duration;
    pointAnimation.delegate = self;
    
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_radius startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle)*_progress+_startAngle clockwise:YES];
    pointAnimation.path = imagePath.CGPath;
    
    return pointAnimation;
}

- (void)setProgress:(CGFloat)progress {
    _progress = MAX(MIN(1, progress), 0);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}

#pragma Methods
- (void)startAnimation {
    [self.progressLayer addAnimation:[self pathAnimation] forKey:@"strokeEndAnimation"];
    
    CAAnimation *pointAnimation = [self pointAnimation];
    [self.pointImage.layer addAnimation:pointAnimation forKey:@"pointAnimation"];
    
    if (_progress == 0.0) {
        [self.pointImage.layer removeAllAnimations];
    }

}

- (UIBezierPath *)getNewBezierPath {
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_radius startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle+_startAngle) clockwise:YES];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && anim == [self.pointImage.layer animationForKey:@"pointAnimation"]) {
        [self updatePointPosition];
    }
}

- (void)updatePointPosition {
    CGFloat currentEndAngle = (2*M_PI-_reduceAngle)*_progress+_startAngle;
    [_pointImage.layer removeAllAnimations];
    _pointImage.center = CGPointMake(_realWidth/2.0+_radius*cosf(currentEndAngle), _realWidth/2.0+_radius*sinf(currentEndAngle));
}

#pragma initSubviews
- (void)initSubviews {
    [self.layer addSublayer:self.backLayer];
    [self.layer addSublayer:self.progressLayer];
    
    [self addSubview:self.pointImage];
   
}

#pragma layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.realWidth = MIN(CircleSelfWidth, CircleSelfHeight);
    self.radius = _realWidth/2.0 - _strokeWidth/2.0;
    
    self.backLayer.frame = CGRectMake(0, 0, _realWidth, _realWidth);
    self.backLayer.lineWidth = 2;
    self.backLayer.path = [self getNewBezierPath].CGPath;
    
    self.progressLayer.frame = CGRectMake(0, 0, _realWidth, _realWidth);
    self.progressLayer.lineWidth = _strokeWidth;
    self.progressLayer.path = [self getNewBezierPath].CGPath;
    self.progressLayer.strokeEnd = 0.0;
    self.pointImage.frame = CGRectMake(0, 0, 10, 10);
    [self updatePointPosition];
    
}



@end

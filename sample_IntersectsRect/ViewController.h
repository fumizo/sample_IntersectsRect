//
//  ViewController.h
//  sample_IntersectsRect
//
//  Created by 山本文子 on 2015/12/17.
//  Copyright © 2015年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate> {
    UIView *moveView;
    UIView *judgeView;
    UIView *rightJudgeView;
    UIView *leftJudgeView;
    UIView *downJudgeView;
    
    int animationSpeedX ;
    int animationSpeedY ;
    
    int direction;
}


@end


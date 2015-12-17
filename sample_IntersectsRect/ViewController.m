//
//  ViewController.m
//  sample_IntersectsRect
//
//  Created by 山本文子 on 2015/12/17.
//  Copyright © 2015年 山本文子. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self makeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeView{
    
    [self setAnimationSettings];

    //スクリーンのサイズを取得
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat sw = screenFrame.size.width;
    CGFloat sh = screenFrame.size.height;
    
    moveView = [[UIView alloc] init];
    moveView.frame = CGRectMake(320/2 - 50 , 300, 100, 100);
    moveView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:moveView];

    judgeView = [[UIView alloc] init];
    judgeView.frame = CGRectMake(320/2 - 50 , 50, 100, 100);
    judgeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:judgeView];
    
    rightJudgeView = [[UIView alloc] init];
    rightJudgeView.frame = CGRectMake(sw, 0, 10, sh);
    [self.view addSubview:rightJudgeView];
    
    leftJudgeView = [[UIView alloc] init];
    leftJudgeView.frame = CGRectMake(0 - 10, 0, 10, sh);
    [self.view addSubview:leftJudgeView];
    
    downJudgeView = [[UIView alloc] init];
    downJudgeView.frame = CGRectMake(0, sh + 10, sw, 10);
    [self.view addSubview:downJudgeView];
    
    
    /* 上スワイプ */
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
    [up setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [moveView addGestureRecognizer:up];
    /* 下スワイプ */
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
    [down setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [moveView addGestureRecognizer:down];
    /* 右スワイプ */
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    [right setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [moveView addGestureRecognizer:right];
    /* 上スワイプ */
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [moveView addGestureRecognizer:left];
    
}

- (void)swipeUp:(UISwipeGestureRecognizer *)sender{
    NSLog(@"swipeUpが呼ばれたよ");
    [self setTimer];
    direction = 1;
}
- (void)swipeDown:(UISwipeGestureRecognizer *)sender{
    [self setTimer];
    direction = 2;
}
- (void)swipeRight:(UISwipeGestureRecognizer *)sender{
    [self setTimer];
    direction = 3;
}
- (void)swipeLeft:(UISwipeGestureRecognizer *)sender{
    [self setTimer];
    direction = 4;
}

- (void)moveUp:(NSTimer *)timer  {
    moveView.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない

    float posX = moveView.center.x;
    float posY = moveView.center.y;
    //ラベルを移動させる
//    posX -= animationSpeedX;
    posY -= animationSpeedY;
    
    //座標反映
    moveView.center = CGPointMake(posX, posY);
    [self judge];
}

- (void)moveDown:(NSTimer *)timer  {
    moveView.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない

    float posX = moveView.center.x;
    float posY = moveView.center.y;
    //ラベルを移動させる
    posY += animationSpeedY;
    
    //座標反映
    moveView.center = CGPointMake(posX, posY);
    [self judge];
}

- (void)moveRight:(NSTimer *)timer  {
    moveView.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない

    float posX = moveView.center.x;
    float posY = moveView.center.y;
    //ラベルを移動させる
    posX += animationSpeedX;
    
    //座標反映
    moveView.center = CGPointMake(posX, posY);
    [self judge];
}

- (void)moveLeft:(NSTimer *)timer  {
    moveView.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない

    float posX = moveView.center.x;
    float posY = moveView.center.y;
    //ラベルを移動させる
    posX -= animationSpeedX;
    
    //座標反映
    moveView.center = CGPointMake(posX, posY);
    [self judge];
}

//タイマー定義
- (void)setTimer
{
    //0.01秒毎に呼ぶ
    // 1上 2下 3右　4左
    switch (direction) {
        case 1:[NSTimer scheduledTimerWithTimeInterval:0.01
                                                target:self
                                              selector:@selector(moveUp:)
                                              userInfo:nil
                                               repeats:YES];
            break;
            
        case 2:[NSTimer scheduledTimerWithTimeInterval:0.01
                                                target:self
                                              selector:@selector(moveDown:)
                                              userInfo:nil
                                               repeats:YES];
            break;
            
        case 3:[NSTimer scheduledTimerWithTimeInterval:0.01
                                                target:self
                                              selector:@selector(moveRight:)
                                              userInfo:nil
                                               repeats:YES];
            break;
            
        case 4:[NSTimer scheduledTimerWithTimeInterval:0.01
                                                target:self
                                              selector:@selector(moveLeft:)
                                              userInfo:nil
                                               repeats:YES];
            break;
            
        default:
            break;
    }
    
}

- (void)setAnimationSettings {
    //ラベルのアニメーションスピード
    animationSpeedX = 5;
    animationSpeedY = 5;
}


- (void)judge{
    //ビューと画像が重なり合ったか判定
    if (CGRectIntersectsRect(judgeView.frame, moveView.frame)) {
        NSLog(@"重なった");
        [moveView removeFromSuperview];
    } else if (CGRectIntersectsRect(rightJudgeView.frame, moveView.frame) |
               CGRectIntersectsRect(leftJudgeView.frame, moveView.frame) |
               CGRectIntersectsRect(downJudgeView.frame, moveView.frame))
    {
        animationSpeedX = -animationSpeedX ;
        animationSpeedY = -animationSpeedY ;
    }
}


@end

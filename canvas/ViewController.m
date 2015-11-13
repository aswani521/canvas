//
//  ViewController.m
//  canvas
//
//  Created by Aswani Nerella on 11/12/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (nonatomic, assign) CGPoint trayOriginalCenter;
@property (nonatomic, assign) CGPoint trayCenterOpen;
@property (nonatomic, assign) CGPoint trayCenterClosed;
// Down = NO, Up = YES;
@property (nonatomic, assign) BOOL direction;

@end

@implementation ViewController
- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    // Absolute (x,y) coordinates in parentView
    CGPoint translatedLocation = [sender translationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.trayOriginalCenter = self.trayView.center;

//        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(self.trayOriginalCenter));
    } else if (sender.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(location));
        NSLog(@"Velocity: %@", NSStringFromCGPoint([sender velocityInView:self.view]));
        
        if ([sender velocityInView:self.view].y > 0) {
            self.direction = NO;
        } else {
            self.direction = YES;
        }
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + translatedLocation.y);
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(location));
                self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + translatedLocation.y);
        
        if (self.direction) {
            self.trayView.center = self.trayCenterOpen;
        } else {
            self.trayView.center = self.trayCenterClosed;
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.trayCenterOpen = self.trayView.center;
    
    self.trayCenterClosed = CGPointMake(self.trayView.center.x, CGRectGetMaxY(self.view.frame) + 70);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

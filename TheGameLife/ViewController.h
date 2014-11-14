//
//  ViewController.h
//  TheGameLife
//
//  Created by Jose Alberto Reyes Juarez on 11/13/14.
//  Copyright (c) 2014 Jose Alberto Reyes Juarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *myView;
@property NSInteger varY;
@property NSInteger varX;
@property NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UIButton *start;

@end


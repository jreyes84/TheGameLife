//
//  ViewController.m
//  TheGameLife
//
//  Created by Jose Alberto Reyes Juarez on 11/13/14.
//  Copyright (c) 2014 Jose Alberto Reyes Juarez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSArray *game[9][36];
NSMutableArray *Game;
NSInteger *stop;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildPanel];
    self.stopped = 0;
    //[startSimulation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildPanel{
    int count = 0;
    _varY = 50;
    _varX = 5;
    _array = [[NSMutableArray alloc] init];
    Game = [[NSMutableArray alloc] init];
    for (int i=0; i < 9; i++) {
        NSMutableArray *second = [[NSMutableArray alloc] init];
        for (int j=0; j < 36; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
            [ button setTag: count ];
            //NSLog(@"%ld", (long)[button tag]);
            [button setTitle:@"Show View" forState:UIControlStateNormal];
            button.frame = CGRectMake( _varX, _varY, 17, 26);
            button.selected = false;
            [button setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
            [button setExclusiveTouch:YES];
            [self.myView addSubview:button];
            _varX = _varX + 17;
            [_array addObject:[NSString stringWithFormat:@"%i-%i", i, j]];
            NSNumber *anumber = [NSNumber numberWithInteger:0];
            [second addObject:anumber];
            count += 1;
        }
        [Game addObject:second];
        _varX = 5;
        _varY = _varY + 26;
    }
}


-(void)aMethod:(id)sender{
    UIButton *button = (UIButton *)sender;
    long i = (long)button.tag;
    NSArray* foo = [_array[i] componentsSeparatedByString: @"-"];
    
    int varI = [foo[0] integerValue];
    int varJ = [foo[1] integerValue];
    
    BOOL value = false;
    
    int number = [Game[varI][varJ] integerValue];
    
    if(number == 0){
        value = true;
    }
    button.selected = value;
    
    if (value) {
        [button setTitle:[NSString stringWithFormat:@"1"] forState:UIControlStateNormal];
        Game[varI][varJ] = @"1";
    }else{
        [button setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        Game[varI][varJ] = @"0";
    }
}

- (IBAction)start:(id)sender {
    _time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(proceso) userInfo:nil repeats:YES];
}

-(void)proceso{
    NSMutableArray *newConfig =[[NSMutableArray alloc]initWithArray:Game];
    //    newConfig = Game;
    newConfig = [self copyArray:Game];
    for (int y = 0; y < 9; y++) {
        for (int x = 0; x < 36; x++) {
            int numOfOne = 0;
            numOfOne = [self getNumOfOne:Game y:y x:x];
            int cell = [newConfig[y][x] integerValue];
            if(cell == 1){
                if(numOfOne==2 || numOfOne == 3){
                    newConfig[y][x] = @"1";
                }else{
                    newConfig[y][x] = @"0";
                }
            }
            else
            {
                if(numOfOne == 3){
                    newConfig[y][x] = @"1";
                }else{
                    newConfig[y][x] = @"0";
                }
            }
        }
    }
    Game = newConfig; //Copiamos el nuevo array
    [self updateButtons:Game];
}

-(int)getNumOfOne:(NSMutableArray*)array y:(int)y x:(int)x{
    int numOfOne=0;
    if((y - 1) != -1 && (x - 1) != -1 ){
        if([array[y - 1][ x -1 ] integerValue] == 1){ // left Up
            numOfOne += 1;
        }
    }
    
    if((x - 1)!= -1){
        if([array[ y ][ x - 1] integerValue] ==1){ // left middle
            numOfOne += 1;
        }
    }
    
    if((y + 1) < 9 && ( x - 1) != -1)
    {
        if([array[y + 1][x - 1] integerValue] == 1){ // left down
            numOfOne += 1;
        }
    }
    
    if((y - 1) !=-1 ){
        if ([array[y - 1][x] integerValue] == 1){ //middle up
            numOfOne += 1;
        }
    }
    
    if((y + 1 )< 9 ){
        if ([array[y + 1][x] integerValue] == 1){ //middle down
            numOfOne += 1;
        }
    }
    
    if((y - 1) !=-1 && (x + 1) <36){
        if ([array[y - 1][x +1] integerValue] == 1){ //right up
            numOfOne += 1;
        }
    }
    
    if((x + 1) < 36){
        if ([array[ y ][x + 1] integerValue] == 1){ //right middle
            numOfOne += 1;
        }
    }
    
    if((y + 1) <9 && (x + 1) < 36){
        if ([array[y + 1][x + 1] integerValue] == 1){ //right down
            numOfOne += 1;
        }
    }
    return numOfOne;
}
-(NSMutableArray*)copyArray:(NSMutableArray*)array{
    NSMutableArray *first =[[NSMutableArray alloc]init];
    for (int y = 0; y < 9; y++) {
        NSMutableArray *second =[[NSMutableArray alloc]init];
        for (int x = 0; x < 36; x++) {
            [second addObject:array[y][x] ];
        }
        [first addObject:second];
    }
    return first;
}

-(void)updateButtons:(NSMutableArray*)array{
    int count=0;
    for (int y = 0; y < 9; y++) {
        for (int x = 0; x < 36; x++) {
            int numOfOne = 0;
            
            numOfOne = [self getNumOfOne:array y:y x:x];
            
            BOOL val = false;
            int vals = 0;
            int cell = [array[y][x] integerValue];
            
            if(cell == 1){
                if(numOfOne ==2 || numOfOne == 3){
                    val=true;
                    vals = 1;
                }
            }
            else
            {
                if(numOfOne == 3){
                    val=true;
                    vals = 1;
                }else{
                    
                }
            }
            for (id object in [self.myView subviews]) {
                if ([object isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton*)object;
                    if (btn.tag == count) {
                                [btn setTitle:[NSString stringWithFormat:@"%i",vals] forState:UIControlStateNormal];
                                btn.selected =val;
                    }
                }
            }
            [self.myView setNeedsDisplay];
            count += 1;
        }
    }
}

@end

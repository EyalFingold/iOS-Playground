//
//  FirstViewController.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/22/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *FirstViewMainLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self FirstViewMainLabel] setText:@"test"];
     // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]){
     [[self FirstViewMainLabel] setText:@"btn Clicked"];
        [(UIButton*)sender setTitle:@"clicked" forState:(UIControlStateNormal)];
    }
}
@end

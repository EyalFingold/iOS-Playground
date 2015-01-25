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
   
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, 60, 30)];
    [newButton setTitle:@"newbtn" forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor redColor]];
    [newButton addTarget:self
                  action:@selector(myButtonTapped:)
        forControlEvents:UIControlEventTouchUpInside
     ];
    [[self view] addSubview:newButton];
     
}

- (void) myButtonTapped:(UIButton*)btn
{
    [btn setBackgroundColor:[UIColor blueColor]];
    [[self view] setBackgroundColor:[UIColor greenColor]];
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

//
//  DetailViewController.m
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import "DetailViewController.h"
#import "Pokedex-Swift.h"
#import "Pokemon.h"


@interface DetailViewController ()

// MARK:- Outlets
@property (strong, nonatomic) IBOutlet UIImageView *spriteImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *ability1Label;
@property (strong, nonatomic) IBOutlet UILabel *ability2Label;
@property (strong, nonatomic) IBOutlet UILabel *ability3Label;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

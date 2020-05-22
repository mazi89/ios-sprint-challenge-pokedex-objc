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
#import "PokemonBase.h"

void *KVOContext = &KVOContext;
@interface DetailViewController ()

// MARK:- Outlets
@property (strong, nonatomic) IBOutlet UIImageView *spriteImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *ability1Label;
@property (strong, nonatomic) IBOutlet UILabel *ability2Label;
@property (strong, nonatomic) IBOutlet UILabel *ability3Label;

// MARK:- CATCH EM ALL
@property (nonatomic) Pokemon *pokewap;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpLabels];
    [APIController.sharedController addObserver:self forKeyPath:@"finished" options:0 context:KVOContext];
    [APIController.sharedController fillInDetailsFor:self.pokefetty];
}


//- (void)setPokewap:(Pokemon *)pokewap {
//    if(pokewap != _pokewap) {
//        [_pokewap removeObserver:self forKeyPath:@"finished" context:KVOContext];
//        _pokewap = pokewap;
//        [_pokewap addObserver:self forKeyPath:@"finished" options:0 context:KVOContext];
//    }
//}


- (void)setUpLabels {
    [self.nameLabel setText:[NSString stringWithFormat:@"Name: %@", self.pokefetty.name]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"finished"]) {
            NSLog(@"Hit observer");
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

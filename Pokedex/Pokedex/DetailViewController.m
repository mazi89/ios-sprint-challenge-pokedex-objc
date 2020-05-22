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

    [APIController.sharedController fillInDetailsFor:self.pokewap];
}

- (void)setPokefetty:(PokemonBase *)pokefetty {
    if(pokefetty != _pokefetty) {

        _pokefetty = pokefetty;
        _pokewap = [[Pokemon alloc] initWithName:self.pokefetty.name];
        self.pokewap.url = self.pokefetty.url;

        [APIController.sharedController addObserver:self forKeyPath:@"finished" options:0 context:KVOContext];
        [APIController.sharedController addObserver:self forKeyPath:@"id" options:0 context:KVOContext];
        [APIController.sharedController addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
        [APIController.sharedController addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    }
}

//- (void)setPokewap:(Pokemon *)pokewap {
//    if(pokewap != _pokewap) {
//        [_pokewap removeObserver:self forKeyPath:@"finished" context:KVOContext];
//        _pokewap = pokewap;
//        [_pokewap addObserver:self forKeyPath:@"finished" options:0 context:KVOContext];
//    }
//}


- (void)setUpLabels {
    [self.nameLabel setText:[NSString stringWithFormat:@"Name: %@", self.pokewap.name]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"finished"]) {
            NSLog(@"Hit observer");
        } else if ([keyPath isEqualToString:@"id"]) {

            [self.idLabel setText:[NSString stringWithFormat:@"%d", self.pokewap.iD]];

        } else if ([keyPath isEqualToString:@"abilities"]) {

            switch (self.pokewap.abilities.count) {
                case 1:
                    [self.ability1Label setHidden:NO];
                    [self.ability1Label setText:self.pokewap.abilities[0]];
                    break;
                case 2:
                    [self.ability1Label setHidden:NO];
                    [self.ability1Label setText:self.pokewap.abilities[0]];
                    [self.ability2Label setHidden:NO];
                    [self.ability2Label setText:self.pokewap.abilities[1]];
                    break;
                case 3:
                    [self.ability1Label setHidden:NO];
                    [self.ability1Label setText:self.pokewap.abilities[0]];
                    [self.ability2Label setHidden:NO];
                    [self.ability2Label setText:self.pokewap.abilities[1]];
                    [self.ability3Label setHidden:NO];
                    [self.ability3Label setText:self.pokewap.abilities[2]];
                    break;
                default:
                    break;
            }
            [self.idLabel setText:[NSString stringWithFormat:@"%d", self.pokewap.iD]];

        } else if ([keyPath isEqualToString:@"image"]) {

            [self.spriteImage setImage:[UIImage imageWithData:self.pokewap.imageData]];

        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
});
}

@end

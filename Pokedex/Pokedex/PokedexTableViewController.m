//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "DetailViewController.h"
#import "Pokedex-Swift.h"
#import "Pokemon.h"
#import "PokemonBase.h"

@interface PokedexTableViewController ()

@property (nonatomic, readonly) APIController *pokedex;
@property (nonatomic) NSMutableArray<PokemonBase *> *pokemonsters;

@end

@implementation PokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokedex = APIController.sharedController;
        _pokemonsters = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokedex fetchAllPokemonWithCompletion:^(NSArray<PokemonBase *> * _Nullable pokemen, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }

        if(pokemen) {
            self.pokemonsters = [NSMutableArray arrayWithArray:pokemen];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonsters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Pokeball" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.textLabel setText:self.pokemonsters[indexPath.row].name];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokeDetail"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokefetty = self.pokemonsters[indexPath.row];
    }
}

@end

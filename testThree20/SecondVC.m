//
//  SecondVC.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondVC.h"
#import "GuluContactModel.h"


@implementation SecondVC
@synthesize launcherView = _launcherView;
@synthesize contacts = _contacts;

- (id) initWithName:(NSString *)name query:(NSDictionary *)query
{
    if ( self = [self initWithNibName:nil bundle:nil] )
    {
        _contacts = [query objectForKey:@"contacts"];
    }

    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds]; 
    _launcherView.persistenceMode = TTLauncherPersistenceModeAll;
    _launcherView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _launcherView.delegate = self;    
    
    
    TTLauncherItem *launcherItem;
    
    for (GuluContactModel *contact in _contacts) {                        
            NSLog(@"%@", [contact getFullName]);
            NSLog(@"%@", [contact profile_pic]);
            
            launcherItem = [[TTLauncherItem alloc] initWithTitle:[contact getFullName] image:contact.profile_pic URL:nil canDelete:YES];
        
            [_launcherView addItem:launcherItem animated:NO];
    }

    [_launcherView restoreLauncherItems];
    
    [self.view addSubview:_launcherView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"project_papper.png"]];    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    TTOpenURLFromView(item.URL, self.view);
}

- (void)launcherView:(TTLauncherView*)launcher didRemoveItem:(TTLauncherItem*)item {
    
}

- (void)launcherView:(TTLauncherView*)launcher didMoveItem:(TTLauncherItem *)item {
    
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                 target:_launcherView action:@selector(endEditing)]animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                 target:self action:@selector(addButtonClicked:)] animated:YES];
}

@end

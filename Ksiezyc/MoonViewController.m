//
//  MoonViewController.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "MoonViewController.h"

@implementation MoonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) self.view = [[MoonView alloc] init];
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.view showMoon];
}

@end
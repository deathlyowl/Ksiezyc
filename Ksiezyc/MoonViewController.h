//
//  MoonViewController.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoonView.h"
#import "Moon.h"

@interface MoonViewController : UIViewController {
    Moon *moon;
    MoonView *moonView;
    
    int day;
}

@property (nonatomic, retain) MoonView *view;

@end

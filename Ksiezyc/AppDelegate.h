//
//  AppDelegate.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoonView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    MoonView *_glView;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet MoonView *glView;

@end

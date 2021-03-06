//
//  ABSearchBarMapViewIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 30.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABSearchBarDelegateZoomInMapViewIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UISearchBarDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

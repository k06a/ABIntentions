//
//  ABMapViewActionsIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ABMapViewActionsIntention : NSObject

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)setMapTypeStandard:(id)sender;
- (IBAction)setMapTypeHybrid:(id)sender;
- (IBAction)setMapTypeSatellite:(id)sender;
- (IBAction)setMapTypeNext:(id)sender;

- (IBAction)setUsertrackingModeFollow:(id)sender;
- (IBAction)setUsertrackingModeFollowWithHeading:(id)sender;
- (IBAction)setUsertrackingModeNone:(id)sender;
- (IBAction)setUsertrackingModeNext:(id)sender;

@end

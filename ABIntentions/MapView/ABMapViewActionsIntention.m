//
//  ABMapViewActionsIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ABMapViewActionsIntention.h"

@interface ABMapViewActionsIntention ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ABMapViewActionsIntention

#pragma mark - Map Type

- (IBAction)setMapTypeStandard:(id)sender
{
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)setMapTypeHybrid:(id)sender
{
    self.mapView.mapType = MKMapTypeHybrid;
}

- (IBAction)setMapTypeSatellite:(id)sender
{
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)setMapTypeNext:(id)sender
{
    switch (self.mapView.mapType)
    {
        case MKMapTypeStandard:
            return [self setMapTypeHybrid:sender];
        case MKMapTypeHybrid:
            return [self setMapTypeSatellite:sender];
        case MKMapTypeSatellite:
            return [self setMapTypeStandard:sender];
    }
}

#pragma mark - User Tracking Mode

- (IBAction)setUsertrackingModeFollow:(id)sender
{
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (IBAction)setUsertrackingModeFollowWithHeading:(id)sender
{
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

- (IBAction)setUsertrackingModeNone:(id)sender
{
    self.mapView.userTrackingMode = MKUserTrackingModeNone;
}

- (IBAction)setUsertrackingModeNext:(id)sender
{
    switch (self.mapView.userTrackingMode)
    {
        case MKUserTrackingModeFollow:
            return [self setUsertrackingModeFollowWithHeading:sender];
        case MKUserTrackingModeFollowWithHeading:
            return [self setUsertrackingModeNone:sender];
        case MKUserTrackingModeNone:
            return [self setUsertrackingModeFollow:sender];
    }
}


@end

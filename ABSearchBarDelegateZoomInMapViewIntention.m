//
//  ABSearchBarMapViewIntention.m
//  Parking
//
//  Created by Антон Буков on 30.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ABSearchBarDelegateZoomInMapViewIntention.h"

@interface ABSearchBarDelegateZoomInMapViewIntention () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet id<UISearchBarDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ABSearchBarDelegateZoomInMapViewIntention

#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.region = self.mapView.region;
    request.naturalLanguageQuery = searchBar.text;
    [[[MKLocalSearch alloc] initWithRequest:request] startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) {
            //[SVProgressHUD showErrorWithStatus:@"Nothing found on the map"];
            return;
        }
        MKMapItem *mapItem = response.mapItems.firstObject;
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(mapItem.placemark.region.center, mapItem.placemark.region.radius, mapItem.placemark.region.radius) animated:YES];
    }];
    [searchBar resignFirstResponder];
    
    if ([self.nextDelegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
        [self.nextDelegate searchBarSearchButtonClicked:searchBar];
}

#pragma mark - Message Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    return [self.nextDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.nextDelegate;
}

@end

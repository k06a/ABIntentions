//
//  ABButtonCycledChangeImagesIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABButtonCycledChangeImagesIntention.h"

@interface ABButtonCycledChangeImagesIntention ()

@property (strong, nonatomic) NSString *path1;
@property (strong, nonatomic) NSString *path2;
@property (strong, nonatomic) NSString *path3;
@property (strong, nonatomic) NSString *path4;
@property (strong, nonatomic) NSString *path5;
@property (readonly, nonatomic) NSArray *paths;

@property (strong, nonatomic) NSMutableDictionary *buttonToImageIndex;

@end

@implementation ABButtonCycledChangeImagesIntention

- (NSArray *)paths
{
    return @[self.path1 ?: @"",
             self.path2 ?: @"",
             self.path3 ?: @"",
             self.path4 ?: @"",
             self.path5 ?: @"",
             ];
}

- (NSMutableDictionary *)buttonToImageIndex
{
    if (_buttonToImageIndex == nil)
        _buttonToImageIndex = [NSMutableDictionary dictionary];
    return _buttonToImageIndex;
}

- (IBAction)changeImage:(UIButton *)sender
{
    NSValue *value = [NSValue valueWithPointer:(__bridge const void *)(sender)];
    NSInteger index = [self.buttonToImageIndex[value] integerValue] + 1;
    if ([self.paths[index] length] == 0)
        index = 0;
    self.buttonToImageIndex[value] = @(index);
    
    UIImage *image = [UIImage imageNamed:self.paths[index]];
    [sender setImage:image forState:(UIControlStateNormal)];
}

@end

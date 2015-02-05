//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HorizontalScroller;


@protocol HorizontalScrollerDelegate<NSObject>

@required

// ask the delegate how many views he wants to present inside the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller*)scroller;

// ask the delegate to return the view that should appear at <index>
- (UIView*)horizontalScroller:(HorizontalScroller*)scroller viewAtIndex:(int)index;

// inform the delegate what the view at <index> has been clicked
- (void)horizontalScroller:(HorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional

// ask the delegate for the index of the initial view to display. this method is optional
// and defaults to 0 if it's not implemented by the delegate
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller*)scroller;
@end

@interface HorizontalScroller : UIView

@property(nonatomic,weak) id<HorizontalScrollerDelegate> delegate;

- (void)reload;

@end

//
//  HorizontalScroller.m
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import "HorizontalScroller.h"


// 1

#define VIEW_PADDING 10

#define VIEW_DIMENSIONS 100

#define VIEWS_OFFSET 100

// 2

@interface HorizontalScroller () <UIScrollViewDelegate>

@end

// 3
@implementation HorizontalScroller
{
    
    UIScrollView *scroller;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scroller.delegate = self;
        [self addSubview:scroller];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [scroller addGestureRecognizer:tapRecognizer];
        
    }
    return self;
    
}

- (void)reload
{
    
    // 1 - nothing to load if there's no delegate
    if (self.delegate == nil) return;
    
    // 2 - remove all subviews
    [scroller.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    // 3 - xValue is the starting point of the views inside the scroller
    CGFloat xValue = VIEWS_OFFSET;
    for (int i=0; i<[self.delegate numberOfViewsForHorizontalScroller:self]; i++)
    {
        // 4 - add a view at the right position
        xValue += VIEW_PADDING;
        UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        
        [scroller addSubview:view];
        xValue += VIEW_DIMENSIONS+VIEW_PADDING;
    }
    
    // 5
    [scroller setContentSize:CGSizeMake(xValue+VIEWS_OFFSET, self.frame.size.height)];
    
    // 6 - if an initial view is defined, center the scroller on it
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)])
    {
        NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        [scroller setContentOffset:CGPointMake(initialView*(VIEW_DIMENSIONS+(2*VIEW_PADDING)), 0) animated:YES];
    }
    
}

- (void)didMoveToSuperview
{
    [self reload];
}

- (void)centerCurrentView
{
    int xFinal = scroller.contentOffset.x + (VIEWS_OFFSET/2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS+(2*VIEW_PADDING));
    xFinal = viewIndex * (VIEW_DIMENSIONS+(2*VIEW_PADDING));
    // scroller offset
    [scroller setContentOffset:CGPointMake(xFinal,0) animated:YES];
    // update Data
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
    
}

#pragma mark- ScrollView Delegate
- (void)scrollerTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    
    // we can't use an enumerator here, because we don't want to enumerate over ALL of the UIScrollView subviews.
    // we want to enumerate only the subviews that we added
    
    for (int index=0; index<[self.delegate numberOfViewsForHorizontalScroller:self]; index++)
    {
        UIView *view = scroller.subviews[index];
        if (CGRectContainsPoint(view.frame, location))
        {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];
            CGFloat contentoffsetX = view.frame.origin.x + view.frame.size.width/2 - self.frame.size.width/2;
            //            NSLog(@"offset: %.2f %.2f",contentoffsetX,self.frame.size.width/2.0);
            [scroller setContentOffset:CGPointMake(contentoffsetX, 0) animated:YES];
            break;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerCurrentView];
}

@end

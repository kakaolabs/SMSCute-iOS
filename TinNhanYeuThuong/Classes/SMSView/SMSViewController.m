//
//  SMSViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "DBEngine.h"
#import "JASidePanelController.h"
#import "MainViewController.h"
#import "TextViewController.h"
#import "SMSViewController.h"

@implementation SMSViewController

- (id) initWithData:(NSArray *) _data atIndex:(int) _index;
{
    self = [super initWithNibName:@"SMSViewController" bundle:nil];
    if (self) {
        data = _data;
        index = _index;
    }   
    
    return self;
}

- (void) setUpPageViewController
{
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageController.dataSource = self;
    pageController.delegate = self;
    CGSize size = self.view.frame.size;
    [[pageController view] setFrame:CGRectMake(0, 70, size.width, size.height - 70)];
    
    TextViewController *controller = (TextViewController *)[self viewControllerAtIndex:index];
    
    NSArray *viewControllers = [NSArray arrayWithObject:controller];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
}

- (void) setUpLikeButton
{
    NSString *smsId = data[index][@"id"];
    NSDictionary *item = [[DBEngine sharedEngine] getSMSContentWithId:smsId];
    likeButton.selected = [item[@"isFavourite"] intValue] == 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPageViewController];
    [self setUpLikeButton];
}

#pragma mark - Handle button
- (IBAction) closeButtonPressed:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction) shareButtonPressed:(id) sender
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
	if ([MFMessageComposeViewController canSendText]) {
		controller.body = [data[index][@"content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		controller.messageComposeDelegate = self;
		[self presentViewController:controller animated:YES completion:^{}];
	}
}

- (void) hideMessageView
{
    [UIView animateWithDuration:0.5 animations:^{
        messageView.frame = CGRectMake(0, 20, messageView.frame.size.width, messageView.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

- (IBAction) likeButtonPressed:(id) sender
{
    DBEngine *db = [DBEngine sharedEngine];
    NSString *smsId = data[index][@"id"];
    if (likeButton.selected) {
        [db markSMSContentIsFavourite:smsId isFavourite:NO];
        messageLabel.text = @"REMOVE ITEM FROM FAVOURITE";
    } else {
        [db markSMSContentIsFavourite:smsId isFavourite:YES];
        messageLabel.text = @"ADD ITEM TO FAVOURITE";
    }
    likeButton.selected = !likeButton.selected;
    
    [UIView animateWithDuration:0.5 animations:^{
        messageView.frame = CGRectMake(0, 70, messageView.frame.size.width, messageView.frame.size.height);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideMessageView) withObject:self afterDelay:2.0f];
    }];
}

# pragma mark - SMS handle
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_NAME
                                                            message:@"Unknown Error"
														   delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
			[alert show];
			break;
        }
		case MessageComposeResultSent:
        {            
            // update db
            DBEngine *db = [DBEngine sharedEngine];
            NSString *smsId = data[index][@"id"];
            [db markSMSContentIsRead:smsId isRead:YES];
			break;
        }
		default:
			break;
	}

    [controller dismissViewControllerAnimated:YES completion:^{}];
}

# pragma mark - Page controller source
- (UIViewController *) viewControllerAtIndex:(int) i
{
    NSString *content = data[i][@"content"];
    TextViewController *controller = [[TextViewController alloc] initWithText:content withIndex:i];
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    TextViewController *currentVC = (TextViewController *) viewController;
    int nextIndex = currentVC.index - 1;
    if (nextIndex < 0) {
        nextIndex = (int)data.count - 1;
    }
    return [self viewControllerAtIndex:nextIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    TextViewController *currentVC = (TextViewController *) viewController;
    int nextIndex = currentVC.index + 1;
    if (nextIndex >= data.count) {
        nextIndex = 0;
    }
    return [self viewControllerAtIndex:nextIndex];
}

# pragma mark - Page Controller delegate
- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed) {
        return;
    }
    // hide messageView
    [self hideMessageView];
    
    // update like button and index
    TextViewController *controller = (TextViewController *)[pvc.viewControllers lastObject];
    index = controller.index;
    [self setUpLikeButton];
}

@end

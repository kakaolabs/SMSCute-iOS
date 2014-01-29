//
//  SMSViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <MessageUI/MessageUI.h>
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

- (void) setUpPageViewContorller
{
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageController.dataSource = self;
    CGSize size = self.view.frame.size;
    [[pageController view] setFrame:CGRectMake(0, 70, size.width, size.height - 70)];
    
    TextViewController *initialViewController = [[TextViewController alloc] initWIthText:data[index][@"content"]];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPageViewContorller];
    textView.text = data[index][@"content"];
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
		controller.body = data[index][@"content"];
		controller.messageComposeDelegate = self;
		[self presentViewController:controller animated:YES completion:^{}];
	}
}

- (IBAction) likeButtonPressed:(id) sender
{

}

# pragma mark - SMS handle
- (UIViewController *) viewControllerAtIndex:(int) i
{
    TextViewController *controller = [[TextViewController alloc] initWIthText:data[i][@"content"]];
    return controller;
}

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
			break;
		default:
			break;
	}
    [controller dismissViewControllerAnimated:YES completion:^{}];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    --index;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    index++;
    
    if (index == data.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

@end

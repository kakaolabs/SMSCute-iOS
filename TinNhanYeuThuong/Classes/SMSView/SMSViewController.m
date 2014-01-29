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

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Gesture handle
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

- (UITextView *) createNewTextViewWithText:(NSString *) text
{
    UITextView *newTextView = [[UITextView alloc] initWithFrame:textView.frame];
    newTextView.backgroundColor = [UIColor clearColor];
    newTextView.font = textView.font;
    newTextView.textColor = textView.textColor;
    newTextView.editable = NO;
    newTextView.text = text;
    return newTextView;
}

- (void)  transitionToNewTextView:(UITextView *) newTextView isFromLeftToRight:(BOOL) isTransitionFromLeft
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = isTransitionFromLeft ? kCATransitionFromLeft : kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:newTextView];
    [textView removeFromSuperview];
    textView = newTextView;
}

- (IBAction) handlePan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // set up new text view
        int newIndex = (index + 1) % data.count;
        NSString *newText = data[newIndex][@"content"];
        UITextView *newTextView = [self createNewTextViewWithText:newText];
        index = newIndex;
        
        // do transition animation
        CGPoint velocity = [recognizer velocityInView:self.view];
        BOOL isTransitionFromLeft = velocity.x > 0;
        [self transitionToNewTextView:newTextView isFromLeftToRight:isTransitionFromLeft];
    }
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
			break;
		default:
			break;
	}
    [controller dismissViewControllerAnimated:YES completion:^{}];
}
@end

//
//  UIViewController+MessageHandle.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 2/2/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "DBEngine.h"
#import "UIViewController+MessageHandle.h"

@implementation UIViewController (MessageHandle)
- (void) presentViewControllerToSendSMSWithContent:(NSString *) smsContent
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
	if ([MFMessageComposeViewController canSendText]) {
		controller.body = [smsContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		controller.messageComposeDelegate = self;
		[self presentViewController:controller animated:YES completion:^{}];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result withSMSId:(NSString *) smsId
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
            [db markSMSContentIsRead:smsId isRead:YES];
			break;
        }
		default:
			break;
	}
    
    [controller dismissViewControllerAnimated:YES completion:^{}];
}
@end

//
//  UIViewController+MessageHandle.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 2/2/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>

@interface UIViewController (MessageHandle)
- (void) presentViewControllerToSendSMSWithContent:(NSString *) smsContent;
- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result withSMSId:(NSString *) smsId;
@end

/*
 * Copyright 2014 Coodly LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "Social/Social.h"
#import "CDYSocialShare.h"
#import "CDYSocialMessage.h"

@implementation CDYSocialShare

+ (CDYSocialShare *)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[CDYSocialShare alloc] initSingleton];
    });
    return _sharedObject;

}

- (id)initSingleton {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must use [%@ %@] instead",
                                                                     NSStringFromClass([self class]),
                                                                     NSStringFromSelector(@selector(sharedInstance))]
                                 userInfo:nil];
    return nil;
}

- (void)shareToFacebook:(CDYSocialMessage *)message onController:(UIViewController *)controller {
    [self shareToService:SLServiceTypeFacebook message:message onController:controller];
}

- (void)shareToTwitter:(CDYSocialMessage *)message onController:(UIViewController *)controller {
    [self shareToService:SLServiceTypeTwitter message:message onController:controller];
}

- (void)shareToService:(NSString *)service message:(CDYSocialMessage *)message onController:(UIViewController *)controller {
    if (![SLComposeViewController isAvailableForServiceType:service]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CDYSocial.cant.share.alert.title", nil)
                                                            message:NSLocalizedString(@"CDYSocial.cant.share.alert.message", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"CDYSocial.cant.share.alert.dismiss.button", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }

    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:service];
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {

    };

    [vc setCompletionHandler:myBlock];
    [vc setInitialText:message.message];
    [vc addURL:message.url];
    [vc addImage:message.image];
    [controller presentViewController:vc animated:YES completion:Nil];
}

@end

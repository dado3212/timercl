#import <objc/runtime.h>

// IPC Notifications for third-party keyboards
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFNotificationCenter.h>
extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

// Headers
@interface CTMessageCenter
+(id) sharedMessageCenter;
-(BOOL) sendSMSWithText:(id)arg1 serviceCenter:(id)arg2 toAddress:(id)arg3;
@end

@interface TimerManager
+(instancetype)sharedManager;
-(double)defaultDuration;
-(NSString *)defaultSound;
-(void)scheduleAt:(double)arg1 withSound:(id)arg2;
-(BOOL)cancel;
-(BOOL)resume;
-(BOOL)pause;
@end

%hook SpringBoard

  void pause(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    TimerManager *timeManager = [%c(TimerManager) sharedManager];
    [timeManager pause];
  }

  void resume(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    TimerManager *timeManager = [%c(TimerManager) sharedManager];
    [timeManager resume];
  }

  void cancel(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    TimerManager *timeManager = [%c(TimerManager) sharedManager];
    [timeManager cancel];
  }

  void set(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    TimerManager *timeManager = [%c(TimerManager) sharedManager];
    [timeManager scheduleAt:(CFAbsoluteTimeGetCurrent() + [[(__bridge NSDictionary *)userInfo objectForKey:@"delay"] doubleValue]) withSound:[timeManager defaultSound]];
  }

  -(id)init {
    // Set up all listeners

    // Pause timer
    CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
      NULL,
      &pause,
      CFSTR("com.hackingdartmouth.timercl.pause"),
      NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately);

    // Resume timer
    CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
      NULL,
      &resume,
      CFSTR("com.hackingdartmouth.timercl.resume"),
      NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately);

    // Cancel timer
    CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
      NULL,
      &cancel,
      CFSTR("com.hackingdartmouth.timercl.cancel"),
      NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately);

    // Set a timer
    CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
      NULL,
      &set,
      CFSTR("com.hackingdartmouth.timercl.set"),
      NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately);
  	return %orig;
  }
%end

%ctor {
	%init;
}

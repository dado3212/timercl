#include <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#import "objc/runtime.h"

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

const char helpText[] = "Usage:\n - Pause: `TimerCL pause`\n - Resume: `TimerCL resume`\n - Cancel: `TimerCL cancel`\n - Set: `TimerCL set <seconds>`\n";

int main(int argc, char **argv, char **envp) {
	if (argc == 1) {
		printf(helpText);
	} else if (argc == 2) {
		if (strcmp(argv[1], "pause") == 0) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(),
			CFSTR("com.hackingdartmouth.timercl.pause"),
			NULL,
			NULL,
			kCFNotificationDeliverImmediately);
		} else if (strcmp(argv[1], "resume") == 0) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(),
			CFSTR("com.hackingdartmouth.timercl.resume"),
			NULL,
			NULL,
			kCFNotificationDeliverImmediately);
		} else if (strcmp(argv[1], "cancel") == 0) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(),
			CFSTR("com.hackingdartmouth.timercl.cancel"),
			NULL,
			NULL,
			kCFNotificationDeliverImmediately);
		} else {
			printf(helpText);
		}
	} else if (argc == 3) {
		if (strcmp(argv[1], "set") == 0) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(),
				CFSTR("com.hackingdartmouth.timercl.set"),
				NULL,
				(__bridge CFDictionaryRef) @{ @"delay" : [NSString stringWithUTF8String:argv[2]] },
				kCFNotificationDeliverImmediately);
		} else {
			printf(helpText);
		}
	}
	return 0;
}

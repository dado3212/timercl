ARCHS = armv7 armv7s arm64

include /var/theos/makefiles/common.mk

TOOL_NAME = timercl
timercl_FILES = main.mm
timercl_FRAMEWORKS = Foundation CoreFoundation
ADDITIONAL_OBJCFLAGS = -fobjc-arc

SUBPROJECTS = Tweak

include /var/theos/makefiles/tool.mk
include /var/theos/makefiles/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"

# TimerCL

TimerCL is a Cydia command line tool for iOS that allows you to control the timer through the command line.

The current options are
 - Pause: `timercl pause`
 - Resume: `timercl resume`
 - Cancel: `timercl cancel`
 - Set: `timercl set <seconds>`
 
This was created to use with Activator through the 'command line' options.  Unfortunately, a straight command line doesn't have access to the private MobileTimer framework, so instead this has a tweak that injects into SpringBoard that can interface with the timer, and is connected to the command line tool through IPC.

### Installation

To install it, either install from the .deb, or add the repository http://cydia.alexbeals.com to Cydia and download TimerCL.

---

<ul>
  <li>
  Objective-C
  <ul>
  <li>THEOS</li>
  </ul>
  </li>
</ul>

**Created by Alex Beals © 2017**

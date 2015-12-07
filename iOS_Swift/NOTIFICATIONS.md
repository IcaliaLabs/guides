# iOS Notifications

### What are they?

Notifications are a way for your app to reach out to users while your app is not running. This may be just to notify them of something, or to bring them back into your app to perform some action.

### Local Notifications

Local notifications are notifications that are created locally, meaning on the phone, as opposed to by some backend service.

Since iOS does not show notifications while the app is open you might think that there is no reason to send a local notification, but there is.

You can schedule a local notification to be sent at a different times (or perhaps on a recurring scheduling) while the app is not open. Or your app may be running in the background because it was awoken for a short time (like entering a Beacon or GPS region) and you may send a local notification to let the user know.

### Push Notifications

Push notifications look the same as a local notification. A user would usually not know the difference between a local and a push notification; the only difference is that a push notification is sent by a backend service.

### Setup & Handling Notifications

For your app to be able to receive notifications you must first register for notifications. This step will ask the user for permission and is done in the app delegate. If permission is granted you will get a callback in the app delegate.

Afterwards, if your app receives a notification while it's running in the foreground or background it won't show the notification, but you will get a callback to this method.

If the notification was received while the app was completely terminated and the notification was "opened" then you will not get a callback to that method, you will get a notification payload in the appDidFinishLaunching method.

	- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
	{
	    NSLog(@"APPLICATION : DID REGISTER FOR REMOTE NOTIFICATIONS");
	    // Store the deviceToken in the current installation and save it to Parse.
	    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	    [currentInstallation setDeviceTokenFromData: deviceToken];
	    [currentInstallation saveInBackground];
	}
	
	- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
	{
	    NSLog(@"APPLICATION : DID FAIL TO REGISTER FOR REMOTE NOTIFICATIONS");
	    NSLog(@"ERROR : %@", error);
	}
	
	- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
	{
	    NSLog(@"APPLICATION: RECEIVED PUSH NOTIFICATION");
	    [[NSNotificationCenter defaultCenter] postNotificationName: kPushNotificationReceivedNotification
	                                                        object: self
	                                                      userInfo: userInfo];
	}

### Certificates

To be able to send notifications, your backend or service that you will be using needs to have the appropiate certificates to verify its identity.

You will need a Development Push Certificate and a Production Push Certificate. 

![Push Certificates](http://danielozano.com/images/PushCertificates.png)

### Parse

Implementing push notifications in your custom backend is generally a hassle, which can be avoided by using a free service like Parse. It's really simple to set up; you just have to upload your push certificates to Parse and you're all set to send push notifications using any of their SDKs or even through their web console.

![Parse](http://danielozano.com/images/ParsePush.png)

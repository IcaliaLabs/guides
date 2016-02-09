# Manual Deployments

When it comes to creating manual deployments, either for weekly testing, or production you should do this usually through trough [Apple's official tools](https://itunesconnect.apple.com). There are unusual cases in which we have used [Fabric](https://fabric.io) for progress weekly deployments for the client, but those are rare cases where the client doesn't want their build to expire after the 60 days that apple gives for a build in test, or when the number of testers exceed the 2,000 users that you can assign. 

In this guide we explain the manual process that we follow in order to make a build for in development app progress build deployments, and also production Appstore build releases. 

>**Important:** This guide is just in case you need to make a manual build, but setting up and **using a Continuous Deployment Tool is highly encouraged** for a more agile process of delivery. Refer to this guide instead: [Continuous Deployments]()

## Testflight and/or Appstore Manual Deployments

The first steps required to build a Testflight or an Appstore release are basicly the same so start with the following steps for the both of them:

1. First you'll need to make sure that you have created the distribution provisioning profile for the application in the [developer portal](https://idmsa.apple.com/IDMSWebAuth/login?&appIdKey=891bd3417a7776362562d2197f89480a8547b108fd934911bcbea0110d07f757&path=%2F%2Fmembercenter%2Findex.action). If you have no idea what I am talking about on this point, go and follow the steps for creating an [appstore distribution profile]() on [the certificate guide]().
2. Go to your XCode project and make sure it has downloaded that certificate to your local machine. To do this go to `XCode>Preferences>Accounts`. 
3. Then select your account and the left panel. And on the right panel select your organization, which in the case of internal build it should be **_Naoui Software Labs S. de R.L de C.V._**, for external releases select the clients organization.
4. Now click on the button that says **_View Details..._** A view with two panels should appear.
5. In the first panel where it says _Signing Identities_, select **_iOS Distribution_**, and then click on the **_Download all_** button. After this you should see your certificate on the bottom panel.
6. You can close now Xcode preferences and go to your project **_Build Settings_** and then go to **_Provisioning Profile_** that is in the _Code Signing Section_. Expand the Configurations for this section with the small arrow that apear on the left, and for each of your release configurations select your distribution provisioning profile.
7. Now is time to go to the [iTunes Connect Portal](https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa), sign in, and make sure your app is already configured. If it is jump to step number 9, otherwise continue on step 8.
8. To create your app in iTunnes connect, go to _MyApps_ section and select the plus sign, from there select the **New App** option. Fill the fields of the form (for the sku, use the same as the bundle id unless specified otherwise).
9. Select the app and check if there are already build for the versión that you are working, if the versión that you will upload has not been created, add it in the portal.
10. Once you have spoted the last build uploaded for your versión, if any go back to your XCode app and update your target's general setting so that it has your current versión and the build number should be one number bigger than the one on iTunes connect.
11. After this is time to archive the project, select `Project > Archive` (If this option is grayed out make sure that the device selected is not an iOS simulator, it must be either a physical device or the option that says iOS Device).
12. Once it has finished archiving the Organizer will open to show the new archive. Select it and then on the bar of the right if your build is for the appstore then select validate, otherwise you can skip validation and select upload to app store. (For both of this processes you will need to select the right organization before continuing)
13. If everything went right, congratulations you have done the hardest part you should be able now to go and see your build on iTunnes Connect in the Activity Section. Before you can continue to the next steps the build will have to change from the In porcess status to ready. This process can take from a few minutes to several hours so you can do other stuff meanwhile. _(There has been cases where the status never changes due to apple problems with their interface so if after about 6 or 7 hours the build hasn't changed status upload another one)_ 

>Important to know on this process is that even though the accounts of the developer portal, and iTunnes Connect account can be different. The organization in which the provisioning profile was created and the organization to which the iTunnes connect account belongs must be the same, otherwise you won't be able to upload your build to iTunnes Connect due to lack of permissions. 
<br/><br/>

From here on the process for testflight and the appstore diverge:

#### Appstore

After following the above [steps](https://github.com/IcaliaLabs/icalia_guides/tree/master/iOS_Swift/deployments#Testflight_and/or_Appstore_Manual_Deployments):

14. For the appstore the only thing left now is to select the build to be submited int the version form.

#### TestFlight

After following the above [steps](https://github.com/IcaliaLabs/icalia_guides/tree/master/iOS_Swift/deployments#Testflight_and/or_Appstore_Manual_Deployments):

#####Internal Testers

14. For Testflight you have to go add users if they aren't on itunnes Connect yet. You must also make sure that those users have Testflight permission.
15. Once the users are added to iTunnes Connect and they accept and create their accounts, you can go add the in the internal Testing section of Testflight. After that you just select save, and they will be able to test instantly.

#####External Testers

14. When using iTunnes Connect external testing you just add the build you want your testers to test in the External Testing section of TestFlight in iTunnesConnect, and add the mails of the people you want to test your aplication.
15. Then you just select start testing and your build will wait for review of apple, when apple approves it a mail will be sent to your testers.

## Fabric Manual Deployments
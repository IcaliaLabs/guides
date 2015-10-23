## Certificates & Provisioning Profiles

### Xcode

The latest version's of **X-Code** *do* these things automatically, supposedly. But in our experience they usually mess things up and create an enormous amount of certificates and provisioning profiles. So we highly recommend doing all these manually in the **Apple Developer - Member Center**, and give them all descriptive names. By doing this you avoid trouble and learn a little bit about this whole proccess and how everything works together.

### Certificates

Certificates are electronic credentials that are used to certify the identities of individuals or computer systems. Apple uses them in order to certify that only the appropiate developers or computers can develop or distribute certain apps by forcing developers to sign the apps with their certificates.

### Development Certificates

Development certificates are are used by the developer to sign applications and run them on their own devices.

You have to enter the **Apple Developer - Member Center**, click on the **Certificates, Identifiers & Profiles** link, then on **Certificates**. There you can click on the `+` sign in the top right corner, choose an **iOS App Development** certificate and follow the instructions to create your Developer Certificate, which will be linked to the computer you are using to create it.

![Development Certificate](http://danielozano.com/images/DevelopmentCertificate.png)

### Distribution Certificates

You create a distribution certificate in the same way as with the development certificate, but now you have to choose **App Store and Ad Hoc** under the **Production** section. Be sure you are on the computer you will be using to distribute to iTunes Connect (Testflight & App Store).

![Distribution Certificate](http://danielozano.com/images/DistributionCertificate.png)

### Push Certificates

If your app is going to be using **push notifications** you have to follow the same steps as with the previous certificates, but choosing **Apple Push Notification Service SSL** as the certificate type.


### Development Provisioning Profile

Ok, so that's it for certificates. Now comes the provisioning profile. The profile is basically the glue that brings together a certificate, an app identifier, and one or several devices.

What the provisioning profile "says" to Apple is: Use **this certificate**, for **this app** (id), with **these devices**.

In the same part of the **member center** as before go to the **provisioning profiles** section. Click on the `+` sign and then choose **ioS App  Development** as the provisioning profile type.

First, choose the App you want to create the profile for. If you haven't added the app, add it first under the **App Ids** section. Then choose the **certificate** you want to use, in this case it would be the **development certificate** you just created with **your** computer. Lastly, select the **devices** you want to be able to use this provisioning profile.

That's it. Don't download it yet, we will get to this soon.

### App Store/Ad Hoc Provisioning Profile

To create a **distribution** or **app store/ad-hoc** provisioning profile the process is the same as with the developer profile. You just have to choose **app store** or **ad-hoc** as the type. (Depending on if you just want to distribute to testflight, add hoc, or to the app store).

And remember to choose the **distribution** certificate you created before.

### Setting them up in Xcode

Lastly, the simplest way to get this all synced up in your Xcode project I recommend you open your **Xcode** settings, and go to the **accounts** pane.

![Xcode Settings](http://danielozano.com/images/XcodeSettings.png)

In here, open your apple developer account by clicking on **view details**. In there, press **download all** or just download the provisioning profiles you just created. 

Afterwards, to avoid **Xcode** confusion, go into the **build settings** for your project, under the **code signing** section, be sure to select the appropiate **provisioning profile** for each of your targets. After choosing the provisioning profile first, you can also chooose the certificates for each target as they will already be the first option there since you've already told **Xcode** you want to use that **certificate** by choosing the appropiate **provisioning profile**.

![Build Settings](http://danielozano.com/images/BuildSettings.png)

That is all! That way everything was created manually, and now you have everything in the correct place hard-coded into your Xcode project. That way you can prevent any problems with Xcode trying to do things on it's own.
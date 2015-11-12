#New Project Setup

All projects in Icalia will need the following setups

## Multiple Environment Configuration

You will need to create diferent configurations, to be able to easily switch between Staging, Production environments as well as Internal, and External app configurations.

1. To start configuring this go to your projects info section:<br/>
<img src="./images/Screen Shot 2015-11-05 at 1.19.26 p.m..png" height="300px"/>

2. In the configurations you see select the **+** icon. To make duplicate versions of this given configurations. Usually we have the following configurations:

   * DebugInternalStaging
   * DebugInternalStagingLogging
   * DebugExternalProduction
   * DebugExternalStaging
   * ReleaseInternalStaging
   * ReleaseExternalStaging
   * ReleaseExternalProduction
   
   This are not necessary the ones you will create, you can create whichever configurations
   
3. After creating your different configurations it is time to give the different settings to setup this configurations. Go to the settings tab, and there you can go to different sections and configure specific settings for each of the configurations you have created. Usually things that we configure in here are the corresponding provisioning profiles, Project Bundle Identifier, as well as swift or objective-c flags that you can use in your code to do different thing deppending on the configuration (we usually use this flags only in the Constants header or swift file described in step 5).<br/><br/>
**Swift:**<br/>
<img src="./images/Screen Shot 2015-11-12 at 12.33.27 p.m..png" height="150px"/><br/><br/>
**Objective-C:**<br/>
<img src="./images/Screen Shot 2015-11-12 at 12.42.29 p.m..png" height="270px"/>

4. You can also create your own user defined settings, by selecting the plus sign on the top of the build settings tab.<br/> 
<img src="./images/Screen Shot 2015-11-12 at 12.06.54 p.m..png" height="100px"/><br/>
You can use these user defined settings for selecting values in an info.plist dynamically according to your configuration, like for example facebook keys. Any setting that you give in here is available as a console variable ${_YOUR_USER_DEFINED_SETTING_}

5. Now for choosing between those setting in code we usually have a Constants file were we deffine all our constants and with the help with the flags created in the macros we can make our code define the constant according to our environment, here are examples in swift, and objective-c of how to use them.<br/><br/>
**Swift:**<br/>
<img src="./images/Screen Shot 2015-11-12 at 1.06.44 p.m..png" height="140px"/>
<br/>
**Objective-C:**<br/>
<img src="./images/Screen Shot 2015-11-12 at 2.42.59 p.m..png" height="110px"/>

6. Last but not least, to switch between the different configurations we have created, we need to create different schemes and choose the right configurations for each schema. **Important:** you must select the shared option for each scheme you want to share through github otherwise schemes stay local.<br/>
<img src="./images/Screen Shot 2015-11-12 at 2.44.58 p.m..png" height="110px"/><br/>
<img src="./images/Screen Shot 2015-11-12 at 2.46.38 p.m..png" height="330px"/><br/>
<img src="./images/Screen Shot 2015-11-12 at 2.47.33 p.m..png" height="360px"/>

7. Now that you have finished you can easily switch between environments by selecting the scheme section<br/>
<img src="./images/Screen Shot 2015-11-12 at 2.57.23 p.m..png" height="160px"/>
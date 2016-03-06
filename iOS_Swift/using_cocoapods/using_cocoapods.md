
# Using CocoaPods

![Cocoapods icon](http://cdn1.raywenderlich.com/wp-content/uploads/2015/02/cocoapods_logo.png)

## What's CocoaPods?

**CocoaPods** is a dependency manager for Swift and Objective-C Cocoa projects. In other words, these are cool libraries that make your life easier when developing an app.

## How to install

For instalation instructions go to the [Installing CocoaPods](https://github.com/IcaliaLabs/icalia_guides/blob/installingCocoapods/iOS_Swift/installing_cocoapods/installing_cocoapods.md) guide.

## Using CocoaPods

Once you have CocoaPods installed and a new project set up, you'll have to go over to your Terminal and do the following steps:

1. Go to the path where you created your Xcode project

	```
	$ cd path/to/your/project
	```
	
2. Run the following command:

	```
	$ pod init
	```
	
	This command will create a podfile for your project and a new **.xcworkspace**. This file is very important, because this will be the one from where you'll be working from now on.
	 

## Finding Cool Pods

The best place to find pods is from a page called [Cocoa Controls](https://www.cocoacontrols.com).


Once you find some pods that'll be useful for your project, you will have to open you **Podfile** and add the Pods names like so:

```
target 'YourProjectName' do

pod 'ThePodYouSelected'

end
```

Note: This name usually appears on the Github page of the pod you selected, if not you can find it on the official [CocoaPods](https://cocoapods.org) page. 


## Installing & updating your Pods

Once you have added the pods you like to your Podfile, you need to head over to your Terminal and run the following command:

```
$ pod install
```

This command will install all the libraries you selected and from now on you'll be able to use them for your project.

Note: You'll have to follow this step every time you add a new pod to your Podfile.

Sometimes pod authors will make relevant changes to their pods according to new releases of Apple or effciency related. To get the new versions of the pods you're using, run the following command on the Terminal:

```
$ pod update
```

## The Podfile

To edit the Podfile you'll want to use a text editor or you can edit it directly from Xcode.

One tip is to never use Apple's *Text Editor* because it changes some characters from your file and you won't be able to install your pods.

Here's a peek of what a Podfile looks like:

<br>

<img src="Podfile.png" alt="Podfile" style="width:auto;height:230px;">

<br>

**Once you do all this you'll be able to start coding and making some awesome apps!**

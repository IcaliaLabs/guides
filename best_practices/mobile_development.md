# Mobile Development

We don't do a lot of it, yet there are some cases where we actually dig in.

## Stack selection criteria for new projects where Mobile workflows are involved

1. We'll try to go towards a Progressive Web Application (PWA) first, due to several advantages:
  - Complete control over the release cycle (i.e. no App store approval for each release)
  - Using 100% tech we're highly skilled: Web
2. If one platform is prefered over another one (only iOS or only Android), we'll should go completely native.
3. If both platforms are required, and iOS and Android devs are available, and the client is able (and willing) to afford it, we should also go native.
4. If the project really needs both platforms, no PWA, **LAST RESORT**, we should go with a ReactNative project, or if there's something better please let's do.

ABSOLUTELY NO CORDOVA-BASED PROJECTS (phonegap, ionic, etc)

### iOS and XCode

#### Working with multiple XCode versions

When working with React Native projects, it's common to have a project that works with an older version of XCode...
**but completely fails to build with the XCode version available in your mac**.

That's why it's important to use a utility called [`xcode-install`](https://github.com/xcpretty/xcode-install) - think of it as an "XCode Version Manager" or `rvm` for XCode.

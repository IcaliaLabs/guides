# React Native

## DR;TL

Not feasible for long-term iOS & Android projects with small-to-medium teams.

The same reasons as PhoneGap, Cordova, Ionic, etc apply, regardless of the underlying technology being different.

### Details

I see several weak points to the tech - all will require constant updating, which is something we've never achieved :(

- [ ] Keep dependencies up-to-date. New Xcode releases will break some react dependencies,
      and not every team in charge of those dependencies will. At some point, you'll be required to update Xcode, and if
      your project isn't up-to-date, your app will break, end of story.
- [ ] A typical react-native app will be composed of TONS of npm packages. Not every package's team will have the same
      schedule, priorities or urge to make their package compatible with changes on Xcode. Unless you have a big team,
      with people willing to contribute and/or maintain open-source projects, this is a big disadvantage.



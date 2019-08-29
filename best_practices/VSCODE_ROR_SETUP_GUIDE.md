# VS Code Ruby on Rails setup 
## Requirements
- You need to have **ruby** installed in your system(You can install ruby with **chruby** in your system with this [tutorial](https://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you))
- **VS Code** installed in your system.

## Setup linter config files 
First you need to download the **IcaliaLabs** linter configuration files in the **home** directory of your system:

*Before running this commands, be sure that you are on your home directory by typing `cd` on the **terminal***.
<!-- TODO: Replace this donwload links with the master branch links -->
```
wget -O .rubocop.yml "https://raw.githubusercontent.com/miguejs/guides/update-rubocop-config-0.74/best_practices/code-analysis/.rubocop-rails.yml" 
```

```
wget -O .rubocop-base.yml "https://raw.githubusercontent.com/miguejs/guides/update-rubocop-config-0.74/best_practices/code-analysis/.rubocop.yml" 
```

```
wget -O .eslintrc.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/default.eslintrc.yml" 
```

```
wget -O .reek.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/reek-rails.yml" 
```

Open `.rubocop.yml` and replace the second line with `.rubocop-base.yml` to finish the linter configuration.

## installing required gems

Then you need to install the following gems in your system:

`‌gem install solargraph`

`gem install rubocop -v 0.74.0`

`gem install rubocop-rspec`

`gem install reek -v 5.0.2`

~~Disclaimer about .ruby-version use case~~


## Install fira code fonts
Install `fonts-firacode` package(**Ubuntu (17.04), Debian (9) or newer**) either by executing:

`sudo apt install fonts-firacode`

[Install fonts-firacode in **Mac OSX**](https://medium.com/@qjli/daily-dev-tips-96-visual-studio-code-how-to-enable-this-new-sexy-fira-code-font-89bafbfa245f)

[Instructions for other linux distros](https://github.com/tonsky/FiraCode/wiki/Linux-instructions)


## Installing Vscode extensions:

[Install Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension on your  VS Code Editor

Then  click on **Download Public Gist Link** in the extension settings page.

After that use the next gist id: `51ba87e124d8e6ed72760bb767c8a64f` to download the **VS Code** settings.

After the configuration is done, we need to set the `Eslint` configuration file path:

<!-- TODO: Add image of Eslint configuration -->

```
"eslint.options": { 
	"configFile": "/Users/your_home_directory/.eslintrc.yml"
}
```
And thats all, you are ready to code like a boss, be free to change the the theme or the font as you like 

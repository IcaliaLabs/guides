# VS Code Ruby on Rails setup 
## Requirements
- You need to have **ruby** installed in your system, you can install ruby with **chruby** in your system with these tutorials: 
	- [Ubuntu installation](https://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you)
	- [Mac Osx installation](https://ryanbigg.com/2015/06/mac-os-x-ruby-ruby-install-chruby-and-you)

- **[VS Code](https://code.visualstudio.com/)** installed in your system.

## Setup linter config files 
First you need to download the **IcaliaLabs** linter configuration files in the **home** directory of your system:

```
wget -O ~/.rubocop.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/.rubocop-rails.yml" 
```

```
wget -O ~/.rubocop-base.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/.rubocop.yml" 
```

```
wget -O ~/.eslintrc.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/default.eslintrc.yml" 
```

```
wget -O ~/.reek.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/code-analysis/reek-rails.yml" 
```

Open `~/.rubocop.yml` and replace the second line with `.rubocop-base.yml` to finish the linter configuration.

## installing required gems

Then you need to install the following gems in your system:

`‌gem install solargraph`

`gem install rubocop -v 0.74.0`

`gem install rubocop-rspec`

`gem install reek -v 5.0.2`

## Install fira code fonts
Install `fonts-firacode` package(**Ubuntu (17.04), Debian (9) or newer**) either by executing:

`sudo apt install fonts-firacode`

[Install fonts-firacode in **Mac OSX**](https://medium.com/@qjli/daily-dev-tips-96-visual-studio-code-how-to-enable-this-new-sexy-fira-code-font-89bafbfa245f)

[Instructions for other linux distros](https://github.com/tonsky/FiraCode/wiki/Linux-instructions)


## Installing Vscode extensions:

Install the [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension in your VS Code Editor.

Click on **Download Public Gist Link** in the extension settings page and put the next gist id: `51ba87e124d8e6ed72760bb767c8a64f` to download the **VS Code** settings and extensions.

After importing the gist, we need to set the `Eslint` configuration file path:

- Press `ctrl(Command for Mac OSX) + comma` to open the vscode settings
- search for Eslint in the extensions tab 
- Click on `edit on settings.json` to open the settings.json file and put your home folder in the confiFile option  

```
"eslint.options": { 
	"configFile": "/Users/your_home_directory/.eslintrc.yml"
}
```
And thats all, you are ready to code like a boss.

## Extensions installed with this configuration
- [rails](https://marketplace.visualstudio.com/items?itemName=bung87.rails): Ruby on Rails support for Visual Studio Code
- [vscode-gemfile](https://marketplace.visualstudio.com/items?itemName=bung87.vscode-gemfile): provide hover link in Gemfile refers to online site
-	[solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph): Code completion, intellisense, and inline documentation
- [vscode-eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint): Integrates ESLint JavaScript into VS Code.
- [noctis](https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis): Collection of light & dark themes with a well balanced blend of warm and cold colors
- [theme-monokai-pro-vscode](https://monokai.pro): monokai theme
- [vscode-docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker): Adds syntax highlighting, commands, hover tips, and linting for Dockerfile and docker-compose files.
- [vsliveshare](https://visualstudio.microsoft.com/es/services/live-share/): Real-time collaborative development from the comfort of your favorite tools.
- [ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby): Ruby language support and debugging for Visual Studio Code
- [slim](https://marketplace.visualstudio.com/items?itemName=sianglim.slim): Slim language support based on https://github.com/slim-template/ruby-slim.tmbundle
- [simple-ruby-erb](https://marketplace.visualstudio.com/items?itemName=vortizhe.simple-ruby-erb): Provides simple Ruby and ERB language, code snippets and ERB tag

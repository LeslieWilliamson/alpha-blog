# README

## Add Bootstrap to an existing project

### Prequisites

The following software was already installed
```
yarn 1.22.22
rvm 1.29.12
npm 10.9.2
ruby 3.3.7 (2025-01-15 revision be31f993d7) [x86_64-linux] 
Rails 8.0.1
```
The existing project was created with default options

```rails new "install_bs"```

### Steps
```
bundle add cssbundling-rails
rails css:install:bootstrap
```
To create a custom css file, add a file with an .sccs extension to the app/assets/stylesheets folder (e.g. custom_css.scss) and add an import statement to the ```application.bootstrap.scss``` file.

    @import 'custom_css';


## Assets not updated in dev mode

At some point I ran rails assets:precompile which meant I has to recompile the assets everytime I made a change as precompiled assets are served over the dynamically created assets. 
I figured out how to undo this.

```1. rails assets:clobber```

This triggers the following error:

```The asset “application.js” is not present in the asset pipeline```

To fix this, I followed the installation instructions for [cssbundling-rails](https://github.com/rails/cssbundling-rails)

```
2. yarn build
3. bundle add cssbundling-rails
4. rails css:install:bootstrap
5. bin/dev
```

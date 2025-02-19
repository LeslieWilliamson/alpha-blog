# README

## Steps to add Bootstrap to a preexisting Rails 8 project

Add jsbundling-rails and cssbundling-rails to the Gem file

    # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
    gem "jsbundling-rails"

    # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
    gem "cssbundling-rails"

Remove importmap-rails and run bundle install

Rename application.css to application.bootstrap.scss and add the following lines

    @import 'bootstrap/scss/bootstrap';
    @import 'bootstrap-icons/font/bootstrap-icons';

Add these lines to the head section of application.html.erb

    <%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>

Add this line to applications.js

    import * as bootstrap from "bootstrap"

Replace contents of index.js

    import { application } from "./application"
    import HelloController from "./hello_controller"
    application.register("hello", HelloController)

Add this line to assets.rb

    Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")

Delete the file importmap.rb

Run yarn init and add the following lines to the resulting package.json

```    {
    "devDependencies": {
        "esbuild": "^0.25.0"
    },
    "scripts": {
        "build": "esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets",
        "build:css:compile": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules",
        "build:css:prefix": "postcss ./app/assets/builds/application.css --use=autoprefixer --output=./app/assets/builds/application.css",
        "build:css": "yarn build:css:compile && yarn build:css:prefix",
        "watch:css": "nodemon --watch ./app/assets/stylesheets/ --ext scss --exec \"yarn build:css\""
    },
    "dependencies": {
        "@hotwired/stimulus": "^3.2.2",
        "@hotwired/turbo-rails": "^8.0.12",
        "@popperjs/core": "^2.11.8",
        "autoprefixer": "^10.4.20",
        "bootstrap": "^5.3.3",
        "bootstrap-icons": "^1.11.3",
        "nodemon": "^3.1.9",
        "postcss": "^8.5.2",
        "postcss-cli": "^11.0.0",
        "sass": "^1.85.0"
    },
    "browserslist": [
        "defaults"
    ]
    }
```

run rails assets:precompile
run rails server

Before checking in the changes to your git repo, add the following lines to your .gitignore file

```    # ignore precompiled assets
    /app/assets/builds/*
    !/app/assets/builds/.keep

    /node_modules

```

To create a custom css file, add a file with an .sccs extension to the app/assets/stylesheets folder (e.g. custom_css.scss) and add an import statement to the application.bootstrap.scss file.

    @import 'custom_css';



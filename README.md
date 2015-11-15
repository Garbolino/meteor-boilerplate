meteor-boilerplate
==================

This is a simple boilerplate structure for typical meteor projects. Includes iron-router, Bootstrap 3, Font Awesome, LESS, coffescript, spinner and more.

## <a name="included-packages"></a> Included Packages

* Meteor Version:
  * 1.2.1
* Router:
  * [iron:router](https://github.com/EventedMind/iron-router)
* Coffeescript
* meteorhacks:npm
  * Use npm modules with your Meteor App
* Collection2
  * A Meteor package that allows you to attach a schema to a Mongo.Collection by @aldeed
* [Less](http://lesscss.org)
  * [Bootstrap](http://getbootstrap.com)
  * [Font Awesome](http://fontawesome.io)
* Misc:
  * [Moment.js](http://momentjs.com/)
* UI:
  * [sacha:spin](https://github.com/SachaG/meteor-spin/)
* Meteor-useraccounts:
  * Easily add accounts templates to your project, writing just a very few lines of code.(http://useraccounts.meteor.com/)

## <a name="file-structure"></a> File Structure

We have a common file structure we use across all of our Meteor apps. Client-only files are stored in the `client` directory, server-only files are stored in the `server` directory, and shared files are stored in the root.

```
.meteor/
client/
  ├── helpers/
  ├── lib/
  └── stylesheets/
    ├── style.less
  └── views/
    └── layouts/
      layout.html
    └── includes/
    └── errors/
    home.html
both/
  ├── collections/
  ├── config/
  router.coffee
packages/
public/
server/
  ├── publications.coffee
```

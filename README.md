meteor-boilerplate
==================

This is a simple boilerplate structure for typical meteor projects. Includes iron-router, Bootstrap 3, Font Awesome, LESS, coffescript, spinner and more.

## <a name="included-packages"></a> Included Packages

* Router:
  * [iron:router](https://github.com/EventedMind/iron-router)
* Coffeescript
* meteorhacks:npm
  * Use npm modules with your Meteor App
* Kadira
  * Performance Monitoring for Meteor
* [Less](http://lesscss.org)
  * [Bootstrap](http://getbootstrap.com)
  * [Font Awesome](http://fontawesome.io)
* Misc:
  * [Moment.js](http://momentjs.com/)
* UI:
  * [sacha:spin](https://github.com/SachaG/meteor-spin/)

## <a name="file-structure"></a> File Structure

We have a common file structure we use across all of our Meteor apps. Client-only files are stored in the `client` directory, server-only files are stored in the `server` directory, and shared files are stored in the root.

```
.meteor/
client/
  ├── helpers/
  ├── lib/
  └── stylesheets/
    ├── bootstrap-3.2.0/
    ├── font-awesome-4.2.0/
    ├── style.less
  └── views/
    └── layouts/
    └── includes/
both/
  ├── collections/
  router.coffee
packages/
public/
 ├── font-awesome-4.2.0/
server/
  ├── publications.coffee
```

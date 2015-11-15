Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  notFoundTemplate: '404'


Router.map ->
  @route "homePage",
    path: "/"

Router.map ->
  @route "dashboardPage",
    path: "/dashboard"


AccountsTemplates.configure
  defaultLayout: 'layout'

AccountsTemplates.configureRoute 'signIn',
  redirect: '/dashboard'

AccountsTemplates.configureRoute 'signUp',
  redirect: '/dashboard'

AccountsTemplates.configureRoute 'ensureSignedIn',
  template: 'homePage'
  layoutTemplate: 'layout'


Router.plugin 'ensureSignedIn', except: [
  'homePage'
]

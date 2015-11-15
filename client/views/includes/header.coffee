Template.header.events
  'click #logout': () ->
    if Meteor.userId()
      AccountsTemplates.logout()

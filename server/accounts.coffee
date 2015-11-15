Accounts.onCreateUser (options, user) ->
  userProperties =
    profile: options.profile || {}

  user = _.extend user, userProperties

registration_code = 'thisiscool'

Meteor.methods
  validateCode: (code) ->
    if code is registration_code then true else false

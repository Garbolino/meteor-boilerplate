UI.registerHelper('userIdentity', (userId) ->
  getUser = Meteor.users.findOne({_id: userId})
  if getUser
	  if getUser.services
	    services = getUser.services
	    getService = switch
	      # when services.facebook then services.facebook.email
	      # when services.github then services.github.email
	      # when services.google then services.google.email
	      when services.twitter then services.twitter.screenName
	      when services.instagram then services.instagram.username
	      else false
	    getService
	  else
	    getUser.profile.name
)


UI.registerHelper('getImageUser', (userId) ->
	user = Meteor.users.findOne({_id: userId})
	if user
		if user.services
			services = user.services
			getService = switch
				when services.twitter then services.twitter.profile_image_url
				when services.google then services.google.picture
				when services.instagram then services.instagram.profile_picture
				else false
			getService
		else
		    "images/avatar3.png"
)
UI.registerHelper "prettifyDate", (timestamp) ->
	moment(new Date(timestamp)).fromNow()

UI.registerHelper "compactDate", (timestamp) ->
	moment(new Date(timestamp)).format("H:mm:ss DD/MM/YY")

UI.registerHelper 'pluralize', (n, thing) ->
  # fairly stupid pluralizer
  if n == 0
    return ''
  if typeof n == 'undefined'
    return ''
  if n == 1
    '1 ' + thing
  else
    n + ' ' + thing + 's'

UI.registerHelper "truncateString", (string, length) ->
	truncate = string.substring(0,length)
	if string.length > length
		truncate += '...'
	truncate


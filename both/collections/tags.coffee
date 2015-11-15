@Tags = new Meteor.Collection("tags")

# Tags.allow
#   insert: (userId, doc) ->
#     !!userId
#   update: (userId, doc) ->
#     !!userId
#   remove: (userId, doc) ->
#     !!userId


TagsSchema = new SimpleSchema
  # userId:
  #   type: String
  #   index: 1
  name:
    type: String
  createdAt:
    type: Date

Tags.attachSchema TagsSchema


if Meteor.isServer
  Meteor.methods
    'searchInQuoraByTag': (tag) ->
      # userId = Meteor.userId()
      encodedTag = encodeURIComponent(tag)
      url ="http://www.quora.com/search?q=#{encodedTag}"
      agent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

      options =
        url: url
        method: "GET"
        headers:
          "User-Agent": agent

      request.get options, Meteor.bindEnvironment (error, response, body) ->
        if error
          console.log(error)
        else
          if response.statusCode is 200
            tag = Tags.findOne('name': encodedTag)
            if !tag
              tagObject =
                name: encodedTag
                # userId: userId
                createdAt: new Date()
              tagId = Tags.insert(tagObject)
            else
              tagId = tag._id

            $ = cheerio.load(body)
            $('div.pagedlist_item').each (i, element) ->
              item = $(this).children()
              title = item.find('a.question_link').text()
              link = item.find('a.question_link').attr('href')
              if title? and link?
                addedQuestion = Questions.findOne({path: link})
                if !addedQuestion
                  questionObject =
                    title: title
                    path: link
                    createdAt: new Date()
                    tagId: tagId
                    scrapped: false

                  questionId = Questions.insert(questionObject)
                  addJob('scrapQuoraQuestion', {questionId:questionId})

@Questions = new Meteor.Collection("questions")


QuestionsSchema = new SimpleSchema
  'tagId':
    type: String
    index: 1
  'title':
    type: String
  'path':
    type: String
    index: 1
  'scrapped':
    type: Boolean
    index: 1
  'createdAt':
    type: Date
  'answers.$.views':
    type: Number
    optional: true
  'answers.$.votes':
    type: Number
    optional: true
  'answers.$.writtenAt':
    type: String
    optional: true
  'answers.$.ordering':
    type: Number
    optional: true

Questions.attachSchema QuestionsSchema

Questions.allow
  insert: (userId, doc) ->
    !!userId
  update: (userId, doc) ->
    !!userId
  remove: (userId, doc) ->
    !!userId

if Meteor.isServer
  Meteor.methods
    'getQuestionInformation': (questionId) ->
      question = Questions.findOne questionId

      url ="http://www.quora.com#{question.path}"
      agent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

      options =
        url: url
        method: "GET"
        headers:
          "User-Agent": agent
        proxy: 'http://elevenyellow:3l3v3npr0xy@37.220.9.252:60099'
      console.log(url)
      request.get options, Meteor.bindEnvironment (error, response, body) ->
        if error
          console.log(error)
        else
          if response.statusCode is 200
            # get anwers
            answers = []
            $ = cheerio.load(body)
            $('div.pagedlist_item').each (i, element) ->
              item = $(this).children()
              footer = item.find('div.AnswerFooter')
              written = footer.find('a.answer_permalink').text()
              views = footer.text()
              votes = item.find('a.vote_item_link').find('span.count').text()
              myviews = views.replace(written, '').replace('views','').replace(' .','').replace('. ','')

              writtenAt = written.replace('Written ', '').replace('w ago','')
              if writtenAt? and writtenAt isnt ''
                answer =
                  'views': parseInt(myviews)
                  'votes': parseInt(votes)
                  'writtenAt': writtenAt
                  'ordering': i
                answers.push(answer)

            updateOptions =
              $set:
                'answers': answers
                'scrapped': true
            Questions.update({_id: question._id}, updateOptions)

            # get related questions
            $('li.related_question').each (i, element) ->
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
                    tagId: question.tagId
                    scrapped: false
                  questionId = Questions.insert(questionObject)
                  addJob('scrapQuoraQuestion', {questionId:questionId})






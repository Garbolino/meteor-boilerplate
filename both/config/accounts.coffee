AccountsTemplates.configure
  confirmPassword: false
  enablePasswordChange: false
  forbidClientAccountCreation: false
  overrideLoginErrors: true
  sendVerificationEmail: false
  lowercaseUsername: false
  showAddRemoveServices: false
  showForgotPasswordLink: true
  showLabels: true
  showPlaceholders: true
  showResendVerificationEmailLink: false
  continuousValidation: false
  negativeFeedback: false
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true
  showValidating: true
  privacyUrl: 'privacy'
  termsUrl: 'terms-of-use'
  homeRoutePath: '/'
  redirectTimeout: 4000
  # onLogoutHook: myLogoutFunc
  # onSubmitHook: mySubmitFunc
  # preSignUpHook: myPreSubmitFunc
  texts:
    button: signUp: 'Register Now!'
    socialSignUp: 'Register'
    socialIcons: 'meteor-developer': 'fa fa-rocket'
    title: forgotPwd: 'Recover Your Password'

AccountsTemplates.configure texts: inputIcons:
  isValidating: 'fa fa-spinner fa-spin'
  hasSuccess: 'fa fa-check'
  hasError: 'fa fa-times'

pwd = AccountsTemplates.removeField('password')
AccountsTemplates.removeField 'email'
AccountsTemplates.addFields [
  {
    _id: 'email'
    type: 'email'
    required: true
    displayName: 'email'
    re: /.+@(.+){2,}\.(.+){2,}/
    errStr: 'Invalid email'
  }
  {
    _id: 'reg_code'
    displayName: 'Registration Code'
    type: 'text'
    required: true
    placeholder: {
      signUp: "Registration Code"
    }
    func: (value) ->
      if Meteor.isClient
        console.log 'Validating reg_code...'
        self = @
        Meteor.call 'validateCode', value, (err, validateCode) ->
          if validateCode
            self.setSuccess()
          else
            self.setError 'Invalid Registration code!'
          self.setValidating false
          return
        return

    errStr: 'Invalid Registration code!'
  }
  pwd
]


myPostLogout = ->
  #example redirect after logout
  Router.go '/'
  return

AccountsTemplates.configure onLogoutHook: myPostLogout

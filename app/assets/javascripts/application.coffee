#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require materialize-sprockets
#= require nprogress
#= require nprogress-turbolinks
#= require_tree .

$(document).on 'ready page:load', ->
  $('select').material_select()
  $('.dropdown-button').dropdown()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#owl-product').owlCarousel
    autoPlay: false
    items: 3
    stopOnHover: true
    navigation: true
    pagination: false
    navigationText: [
      '<span class=\'glyphicon glyphicon-chevron-left\'></span>',
      '<span class=\'glyphicon glyphicon-chevron-right\'></span>'
    ]

  $('.navbar .dropdown').hover (->
    $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown()
    return
  ), ->
    $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    return

  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    return

  return
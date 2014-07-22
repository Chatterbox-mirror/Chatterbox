window.Puller = (url) ->
  locking = false

  ->
    locking = true
    $.get(url, {
      after: $('#comments').children().last().data('comment-id')
    }).done (data) ->
      $('#comments').append(data)
      $('#comments').scrollTo('100%')
      $('#comments').timeago('refresh')
    .always ->
      locking = false



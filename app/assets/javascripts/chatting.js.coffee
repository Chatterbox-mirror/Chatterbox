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


$(document).on 'keydown', 'textarea', (e) ->
    # ctrl + enter, newline
    # enter, invoke commentCreate function
    # console.log(e)
    if (e.ctrlKey || e.metaKey) && e.which == 13 || e.which == 10
      # this.value += "\n"
    # else if e.which == 13 || e.which == 10

      $(this.form).trigger('submit.rails') if $.trim(this.value) != ''
      # e.preventDefault()
      false

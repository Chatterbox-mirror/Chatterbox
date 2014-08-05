class window.Puller
  constructor: (@url, @period) ->
    @locking = false
    @running = false
    @timer = null
  start: ->
    @running = true
    @timer = setTimeout(( => @pull()), @period)
  stop: ->
    @running = false
    clearTimeout @timer
  pull: (toAlert = true) ->
    return if @locking
    @locking = true
    $.get(@url, {
      after: $('#comments').children().last().data('comment-id')
    }).done (data) ->
      $('#comments').append(data)
      if data.length > 0
        $('#comments').scrollTo('100%')
        window.alertSound.play() if window.alertSound and toAlert
      $('#comments').timeago('refresh')
    .always =>
      @locking = false
      if @timer
        clearTimeout(@timer)
      if @running
        @start()




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

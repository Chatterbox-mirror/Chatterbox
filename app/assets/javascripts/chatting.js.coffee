class window.Puller
  constructor: (@url, @period) ->
    @locking = false
    @running = false
    @timer = null
    @unread = 0
    @originalTitle = document.title

  start: ->
    @running = true
    @timer = setTimeout(( => @pull()), @period)
  stop: ->
    @running = false
    clearTimeout @timer
  updateTitle: (nodes) ->
    if nodes
      @unread += nodes.length
    if window.focused
      @unread = 0
    if @unread == 0
      document.title = @originalTitle
    else
      document.title = "(#{@unread}) #{@originalTitle}"

  pull: (toAlert = true) ->
    return if @locking
    @locking = true
    $.get(@url, {
      after: $('#comments').children().last().data('comment-id')
    }).done (data) =>
      nodes = $(data)
      $('#comments').append(nodes)
      if data.length > 0
        $('#comments').scrollTo('100%')
        window.alertSound.play() if window.alertSound and toAlert
        @updateTitle(nodes)
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

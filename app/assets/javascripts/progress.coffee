$ ->
  $(document).on 'click', '.mark-book', (e) ->
    e.preventDefault()

    onePercent = $('.progress-bar').data('onePercent')
    markedBooks = parseInt($('.progress-bar').attr('data-marked-books')) + 1

    $('.progress-bar').attr('data-marked-books', markedBooks)

    newProgress = parseInt($('.progress-bar').attr('data-marked-books') / onePercent)

    $('.progress-bar').text("#{newProgress} %")
    $('.progress-bar').attr('style', "width: #{newProgress}%;")

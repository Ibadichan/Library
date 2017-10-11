$ ->
  access = (event, element) ->
    event.preventDefault()

    $.ajax
      url: element.attr('href')
      type: 'PATCH'
      dataType: 'JSON'
      success: (data) ->
        if element.hasClass('block-user')
          element.text('Unblock User')
          element.attr("href", "/admin/users/#{data.id}/unblock" )
        else
          element.text('Block User')
          element.attr("href", "/admin/users/#{data.id}/block" )

        element.toggleClass('btn-danger')
        element.toggleClass('btn-success')
        element.toggleClass('block-user')
        element.toggleClass('unblock-user')

  $(document).on 'click', '.block-user', (e) ->
    access(e, $(this) )
  $(document).on 'click', '.unblock-user', (e) ->
    access(e, $(this) )

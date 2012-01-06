class StoreButtons
  constructor: ->
    $('.lesson_action').on('click', @create_usership)
    
  create_usership: ->
    id = $(this).attr('id')
    $.getJSON("#{studyegg_path}/create_usership/#{id}?callback=?", (json, status) => 
      if status == 'success'
        $(this).html("<a href='"+studyegg_path+"/review/"+$(this).attr('id')+"'>Review Now!</a>")
      )

$ ->
    resizeContents = ->
        footer = $('#footer')
        contents = $('#main')
        header = $('#header')
        
        footerY = footer.height()
        contentsY = contents.height()
        headerY = header.height()
        viewportY = $(window).height()
        
        difference = viewportY - footerY - headerY - 33;

        newContentsY = difference;

        #set min height
        contents.css('minHeight', newContentsY+'px')

    #init
    init = ->
        resizeContents()
        buttons = new StoreButtons()
    init()
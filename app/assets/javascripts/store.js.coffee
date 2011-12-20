$ ->
    resizeContents = ->
        footer = $('#footer')
        contents = $('#main')
        header = $('#header')
        
        footerY = footer.height()
        console.log(footerY)
        contentsY = contents.height()
        console.log(contentsY)
        headerY = header.height()
        console.log(headerY)
        viewportY = $(window).height()
        console.log(viewportY)
        
        difference = viewportY - footerY - headerY - 13;

        newContentsY = difference;

        #set min height
        contents.css('minHeight', newContentsY+'px')

    #init
    init = ->
        resizeContents()
    init()
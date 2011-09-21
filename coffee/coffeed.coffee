JFeed = (xml) ->
  @parse xml  if xml
jQuery.getFeed = (options) ->
  options = jQuery.extend(
    url: null
    data: null
    cache: true
    success: null
    failure: null
  , options)
  if options.url
    $.ajax 
      type: "GET"
      url: options.url
      data: options.data
      cache: options.cache
      dataType: (if (jQuery.browser.msie) then "text" else "xml")
      success: (xml) ->
        feed = new JFeed(xml)
        options.success feed  if jQuery.isFunction(options.success)
      
      error: (xhr, msg, e) ->
        options.failure msg, e  if jQuery.isFunction(options.failure)

JFeed:: = 
  type: ""
  version: ""
  title: ""
  link: ""
  description: ""
  parse: (xml) ->
    if jQuery.browser.msie
      xmlDoc = new ActiveXObject("Microsoft.XMLDOM")
      xmlDoc.loadXML xml
      xml = xmlDoc
    if jQuery("channel", xml).length == 1
      @type = "rss"
      feedClass = new JRss(xml)
    else if jQuery("feed", xml).length == 1
      @type = "atom"
      feedClass = new JAtom(xml)
    jQuery.extend this, feedClass  if feedClass

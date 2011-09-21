JRss = (xml) ->
  @_parse xml
JRss:: = _parse: (xml) ->
  if jQuery("rss", xml).length == 0
    @version = "1.0"
  else
    @version = jQuery("rss", xml).eq(0).attr("version")
  channel = jQuery("channel", xml).eq(0)
  @title = jQuery(channel).find("title:first").text()
  @link = jQuery(channel).find("link:first").text()
  @description = jQuery(channel).find("description:first").text()
  @language = jQuery(channel).find("language:first").text()
  @updated = jQuery(channel).find("lastBuildDate:first").text()
  @items = new Array()
  feed = this
  jQuery("item", xml).each ->
    item = new JFeedItem()
    item.title = jQuery(this).find("title").eq(0).text()
    item.link = jQuery(this).find("link").eq(0).text()
    item.description = jQuery(this).find("description").eq(0).text()
    item.updated = jQuery(this).find("pubDate").eq(0).text()
    item.id = jQuery(this).find("guid").eq(0).text()
    feed.items.push item

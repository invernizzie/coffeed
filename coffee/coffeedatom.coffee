CoffeedAtom = (xml) ->
  @_parse xml
CoffeedAtom:: = _parse: (xml) ->
  channel = jQuery("feed", xml).eq(0)
  @version = "1.0"
  @title = jQuery(channel).find("title:first").text()
  @link = jQuery(channel).find("link:first").attr("href")
  @description = jQuery(channel).find("subtitle:first").text()
  @language = jQuery(channel).attr("xml:lang")
  @updated = jQuery(channel).find("updated:first").text()
  @items = new Array()
  feed = this
  jQuery("entry", xml).each ->
    item = new CoffeedItem()
    item.title = jQuery(this).find("title").eq(0).text()
    item.link = jQuery(this).find("link").eq(0).attr("href")
    item.description = jQuery(this).find("content").eq(0).text()
    item.updated = jQuery(this).find("updated").eq(0).text()
    item.id = jQuery(this).find("id").eq(0).text()
    feed.items.push item

class CoffeedAtom

    constructor: (xml) ->
        @_parse xml

    _parse: (xml) ->
        channel = jQuery("feed", xml).eq(0)
        @version = "1.0"
        @title = jQuery(channel).find("title:first").text()
        @link = jQuery(channel).find("link:first").attr("href")
        @description = jQuery(channel).find("subtitle:first").text()
        @language = jQuery(channel).attr("xml:lang")
        @updated = jQuery(channel).find("updated:first").text()

        @items = []
        feed = this
        jQuery("entry", xml).each ->
            item = new CoffeedItem()
            item.title =        {text: jQuery(this).find("title").eq(0).text()}
            item.link =         {text: jQuery(this).find("link").eq(0).attr("href")}
            item.description =  {text: jQuery(this).find("content").eq(0).text()}
            item.updated =      {text: jQuery(this).find("pubDate").eq(0).text()}
            item.id =           {text: jQuery(this).find("guid").eq(0).text()}

            feed.items.push(item)

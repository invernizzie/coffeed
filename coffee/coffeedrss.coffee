$ = jQuery

class CoffeedRss

    constructor: (xml) ->
        @_parse xml

    _parse: (xml) ->
        if $('rss', xml).length == 0
            @version = '1.0'
        else
            @version = $('rss', xml).eq(0).attr('version')

        channel = $($('channel', xml).eq(0))

        @title = channel.find('title:first').text()

        @title = channel.find('title:first').text()
        @link = channel.find('link:first').text()
        @description = channel.find('description:first').text()
        @language = channel.find('language:first').text()
        @updated = channel.find('lastBuildDate:first').text()

        @items = []
        feed = this;

        $('item', xml).each ->

            item = new CoffeedItem();

            item.title = $(this).find('title').eq(0).text()
            item.link = $(this).find('link').eq(0).text()
            item.description = $(this).find('description').eq(0).text()
            item.updated = $(this).find('pubDate').eq(0).text()
            item.id = $(this).find('guid').eq(0).text()

            $(this).children().each ->
                item[@tagName] = $(this).text() unless item[@tagName]?
                ###
                if item[this.tagName]?
                    item[this.tagName] = [item[this.tagName]] unless $.isArray(item[this.tagName])
                    item[this.tagName].push($(this).text())
                else
                    item[this.tagName] = $(this).text()
                ###

            feed.items.push(item)
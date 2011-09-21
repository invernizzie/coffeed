###
    coffeed : jQuery feed parser plugin in CoffeeScript, with support for non-standard item tags
    Copyright (C) 2011 Esteban Ignacio Invernizzi - invernizzie@gmail.com
    Licensed under the MIT (MIT-license.txt) license.
    github.com/invernizzie/coffeed

    based on...

    jFeed : jQuery feed parser plugin
    Copyright (C) 2007 Jean-François Hovinne - http://www.hovinne.com/
###

jQuery.getFeed = (options) ->
    options = jQuery.extend(
        url: null
        data: null
        cache: true
        success: null
        failure: null,
        options)

    if options.url?
        $.ajax
            type: "GET"
            url: options.url
            data: options.data
            cache: options.cache
            dataType: if jQuery.browser.msie then "text" else "xml"
            success: (xml) ->
                feed = new Coffeed(xml)
                options.success(feed) if jQuery.isFunction(options.success)

            error: (xhr, msg, e) ->
                options.failure(msg, e) if jQuery.isFunction(options.failure)

class Coffeed
    type: ""
    version: ""
    title: ""
    link: ""
    description: ""

    constructor: (xml) ->
        @parse xml if xml?

    parse: (xml) ->
        if jQuery.browser.msie
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM")
            xmlDoc.loadXML(xml)
            xml = xmlDoc

        if jQuery("channel", xml).length == 1
            @type = "rss"
            feedClass = new CoffeedRss(xml)

        else if jQuery("feed", xml).length == 1
            @type = "atom"
            feedClass = new CoffeedAtom(xml)

        jQuery.extend(this, feedClass) if feedClass?

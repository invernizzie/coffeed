###
    coffeed : jQuery feed parser plugin in CoffeeScript, with support for non-standard item tags
    Copyright (C) 2011 Esteban Ignacio Invernizzi - invernizzie@gmail.com
    Licensed under the MIT (MIT-license.txt) license.
    github.com/invernizzie/coffeed

    based on...

    jFeed : jQuery feed parser plugin
    Copyright (C) 2007 Jean-François Hovinne - http://www.hovinne.com/
###

$ = jQuery
# Support old version of jQuery
unless $.isArray?
    $.isArray = Array.isArray or (obj) -> !!(obj and obj.concat and obj.unshift and not obj.callee)

$.getFeed = (options) ->
    options = $.extend(
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
            dataType: if $.browser.msie then "text" else "xml"
            success: (xml) ->
                feed = new Coffeed(xml)
                options.success(feed) if $.isFunction(options.success)

            error: (xhr, msg, e) ->
                options.failure(msg, e) if $.isFunction(options.failure)

class Coffeed
    type: ""
    version: ""
    title: ""
    link: ""
    description: ""

    constructor: (xml) ->
        @parse xml if xml?

    parse: (xml) ->
        if $.browser.msie
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM")
            xmlDoc.loadXML(xml)
            xml = xmlDoc

        if $("channel", xml).length == 1
            @type = "rss"
            feedClass = new CoffeedRss(xml)

        else if $("feed", xml).length == 1
            @type = "atom"
            feedClass = new CoffeedAtom(xml)

        $.extend(this, feedClass) if feedClass?

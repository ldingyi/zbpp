;(function ($, window, document, undefined) {
    'use strict';

    function Sliders(element, options) {
        this.element = element;
        this.options = {
            vWidth: options.vWidth || element.width(),
            current: options.current || 1,
            imgArr: options.imgArr,
            len: options.imgArr.length,
            autoLoop: options.autoLoop,
            time: options.time || 4000
        };
        this.init();
    }

    Sliders.prototype = {
        constructor: Sliders,
        init: function () {
            this.createHtml();
            this.bindEvent();
            this.hackLoop();
        },
        createHtml: function () {
            var me = this;
            var imgArr = me.options.imgArr,
                len = me.options.len,
                content = [],
                pointer = [],
                current = me.options.current;
            content.push("<button type='button' class='preBtn' id='preBtn'><</button>");
            content.push("<button type='button' class='nextBtn' id='nextBtn'>></button>");
            content.push("<ul class='sliderUl'>");
            pointer.push("<ul class='pointer'>");
            for (var i = 0; i < len; i++) {
                content.push("<li class='sliderLi'><img class='block' src=" + imgArr[i] + " title=" + imgArr[i] + "></li>")
                if ((current - 1) !== i) {
                    pointer.push("<li data-index=" + (i + 1) + "></li>");
                } else {
                    pointer.push("<li data-index=" + (i + 1) + " class=" + 'current' + "></li>");
                }
            }
            pointer.push("</ul>");
            content.push("<li class='sliderLi'><img class='block' src=" + imgArr[0] + " title=" + imgArr[0] + "></li></ul>");
            me.element.html((content.concat(pointer)).join(''));
        },
        bindEvent: function () {
            var me = this;
            me.element.on('mouseenter', '.sliderUl', function () {
                clearInterval(me.timer);
            });
            me.element.on('mouseleave', '.sliderUl', function () {
                me.hackLoop();
            });
            me.element.on('click', '.pointer li', function () {
                clearInterval(me.timer);
                var index = parseInt($(this).data('Home.html'));
                me.goPage(index);
            });
            me.element.on('click', '#preBtn', function () {
                clearInterval(me.timer);
                var current = me.options.current, len = me.options.len;
                if (current === 1) {
                    var vWidth = me.options.vWidth;
                    var temp = (-len * vWidth);
                    me.element.children('.sliderUl').css({
                        "-webkit-transform": "translateX(" + temp + "px)",
                        "transform": "translateX(" + temp + "px)",
                        "transition-duration": "none",
                        "transition-timing-function": "none",
                        "transition-property": "none"
                    });
                    me.options.current = len - 1;
                } else if (current === len) {
                    me.options.current = len - 2;
                } else {
                    me.options.current = 0;
                }
                setTimeout(function () {
                    me.loop();
                }, 10);
            });
            me.element.on('click', '#nextBtn', function () {
                clearInterval(me.timer);
                var current = me.options.current, len = me.options.len;
                me.options.current = current === len ? len : current; // 20190430 15:18更改 len ? 0 : current
                me.loop();
            });
        },
        loop: function () {
            var me = this;
            var current = me.options.current, vWidth = me.options.vWidth, len = me.options.len;
            var temp = (-current * vWidth);
            var sliderUl = me.element.children('.sliderUl');
            sliderUl.css({
                "-webkit-transform": "translateX(" + temp + "px)",
                "transform": "translateX(" + temp + "px)",
                "transition-duration": "0.4s",
                "transition-timing-function": "ease-in",
                "transition-property": "transform"
            });
            var pointerLi = me.element.children('.pointer').children("li");
            pointerLi.removeClass("current");
            pointerLi.eq(current === len ? 0 : current).addClass("current");
            if (me.options.current === len) {
                setTimeout(function () {
                    sliderUl.css({
                        "-webkit-transform": "translateX(0px)",
                        "transform": "translateX(0px)",
                        "transition-duration": "none",
                        "transition-timing-function": "none",
                        "transition-property": "none"
                    });
                    //时间必须不小于动画所需时间
                }, 500);
            }
            me.options.current = (len !== current) ? ++current : 1;
        },
        hackLoop: function () {
            var me = this;
            if (me.options.autoLoop) {
                me.timer = setInterval(function () {
                    me.loop();
                }, me.options.time);
            }
        },
        goPage: function (index) {
            var me = this;
            var vWidth = me.options.vWidth;
            me.options.current = index;
            me.element.children('.sliderUl').css({
                "-webkit-transform": "translateX(" + (-(index - 1) * vWidth) + "px)",
                "transform": "translateX(" + (-(index - 1) * vWidth) + "px)",
                "transition-duration": "0.4s",
                "transition-timing-function": "ease-in",
                "transition-property": "transform"
            });
            var pointerLi = me.element.children('.pointer').children("li");
            pointerLi.removeClass("current");
            pointerLi.eq(index - 1).addClass("current");
        }
    };
    $.fn.sliders = function (options) {
        return new Sliders($(this), options);
    }
})(jQuery, window, document);
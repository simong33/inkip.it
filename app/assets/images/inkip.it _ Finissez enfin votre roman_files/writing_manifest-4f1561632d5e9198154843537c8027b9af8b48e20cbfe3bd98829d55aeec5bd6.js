// /* =============================================================
//  * bootstrap-typeahead.js v2.3.2
//  * http://twitter.github.com/bootstrap/javascript.html#typeahead
//  * =============================================================
//  * Copyright 2012 Twitter, Inc.
//  *
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  * http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  * ============================================================ */


// !function($){

//   "use strict"; // jshint ;_;


//  /* TYPEAHEAD PUBLIC CLASS DEFINITION
//   * ================================= */

//   var Typeahead = function (element, options) {
//     this.$element = $(element)
//     this.options = $.extend({}, $.fn.typeahead.defaults, options)
//     this.matcher = this.options.matcher || this.matcher
//     this.sorter = this.options.sorter || this.sorter
//     this.highlighter = this.options.highlighter || this.highlighter
//     this.updater = this.options.updater || this.updater
//     this.source = this.options.source
//     this.$menu = $(this.options.menu)
//     this.shown = false
//     this.listen()
//   }

//   Typeahead.prototype = {

//     constructor: Typeahead

//   , select: function () {
//       var val = this.$menu.find('.active').attr('data-value')
//       this.$element
//         .val(this.updater(val))
//         .change()
//       return this.hide()
//     }

//   , updater: function (item) {
//       return item
//     }

//   , show: function () {
//       var pos = $.extend({}, this.$element.position(), {
//         height: this.$element[0].offsetHeight
//       })

//       this.$menu
//         .insertAfter(this.$element)
//         .css({
//           top: pos.top + pos.height
//         , left: pos.left
//         })
//         .show()

//       this.shown = true
//       return this
//     }

//   , hide: function () {
//       this.$menu.hide()
//       this.shown = false
//       return this
//     }

//   , lookup: function (event) {
//       var items

//       this.query = this.$element.val()

//       if (!this.query || this.query.length < this.options.minLength) {
//         return this.shown ? this.hide() : this
//       }

//       items = $.isFunction(this.source) ? this.source(this.query, $.proxy(this.process, this)) : this.source

//       return items ? this.process(items) : this
//     }

//   , process: function (items) {
//       var that = this

//       items = $.grep(items, function (item) {
//         return that.matcher(item)
//       })

//       items = this.sorter(items)

//       if (!items.length) {
//         return this.shown ? this.hide() : this
//       }

//       return this.render(items.slice(0, this.options.items)).show()
//     }

//   , matcher: function (item) {
//       return ~item.toLowerCase().indexOf(this.query.toLowerCase())
//     }

//   , sorter: function (items) {
//       var beginswith = []
//         , caseSensitive = []
//         , caseInsensitive = []
//         , item

//       while (item = items.shift()) {
//         if (!item.toLowerCase().indexOf(this.query.toLowerCase())) beginswith.push(item)
//         else if (~item.indexOf(this.query)) caseSensitive.push(item)
//         else caseInsensitive.push(item)
//       }

//       return beginswith.concat(caseSensitive, caseInsensitive)
//     }

//   , highlighter: function (item) {
//       var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
//       return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
//         return '<strong>' + match + '</strong>'
//       })
//     }

//   , render: function (items) {
//       var that = this

//       items = $(items).map(function (i, item) {
//         i = $(that.options.item).attr('data-value', item)
//         i.find('a').html(that.highlighter(item))
//         return i[0]
//       })

//       items.first().addClass('active')
//       this.$menu.html(items)
//       return this
//     }

//   , next: function (event) {
//       var active = this.$menu.find('.active').removeClass('active')
//         , next = active.next()

//       if (!next.length) {
//         next = $(this.$menu.find('li')[0])
//       }

//       next.addClass('active')
//     }

//   , prev: function (event) {
//       var active = this.$menu.find('.active').removeClass('active')
//         , prev = active.prev()

//       if (!prev.length) {
//         prev = this.$menu.find('li').last()
//       }

//       prev.addClass('active')
//     }

//   , listen: function () {
//       this.$element
//         .on('focus',    $.proxy(this.focus, this))
//         .on('blur',     $.proxy(this.blur, this))
//         .on('keypress', $.proxy(this.keypress, this))
//         .on('keyup',    $.proxy(this.keyup, this))

//       if (this.eventSupported('keydown')) {
//         this.$element.on('keydown', $.proxy(this.keydown, this))
//       }

//       this.$menu
//         .on('click', $.proxy(this.click, this))
//         .on('mouseenter', 'li', $.proxy(this.mouseenter, this))
//         .on('mouseleave', 'li', $.proxy(this.mouseleave, this))
//     }

//   , eventSupported: function(eventName) {
//       var isSupported = eventName in this.$element
//       if (!isSupported) {
//         this.$element.setAttribute(eventName, 'return;')
//         isSupported = typeof this.$element[eventName] === 'function'
//       }
//       return isSupported
//     }

//   , move: function (e) {
//       if (!this.shown) return

//       switch(e.keyCode) {
//         case 9: // tab
//         case 13: // enter
//         case 27: // escape
//           e.preventDefault()
//           break

//         case 38: // up arrow
//           e.preventDefault()
//           this.prev()
//           break

//         case 40: // down arrow
//           e.preventDefault()
//           this.next()
//           break
//       }

//       e.stopPropagation()
//     }

//   , keydown: function (e) {
//       this.suppressKeyPressRepeat = ~$.inArray(e.keyCode, [40,38,9,13,27])
//       this.move(e)
//     }

//   , keypress: function (e) {
//       if (this.suppressKeyPressRepeat) return
//       this.move(e)
//     }

//   , keyup: function (e) {
//       switch(e.keyCode) {
//         case 40: // down arrow
//         case 38: // up arrow
//         case 16: // shift
//         case 17: // ctrl
//         case 18: // alt
//           break

//         case 9: // tab
//         case 13: // enter
//           if (!this.shown) return
//           this.select()
//           break

//         case 27: // escape
//           if (!this.shown) return
//           this.hide()
//           break

//         default:
//           this.lookup()
//       }

//       e.stopPropagation()
//       e.preventDefault()
//   }

//   , focus: function (e) {
//       this.focused = true
//     }

//   , blur: function (e) {
//       this.focused = false
//       if (!this.mousedover && this.shown) this.hide()
//     }

//   , click: function (e) {
//       e.stopPropagation()
//       e.preventDefault()
//       this.select()
//       this.$element.focus()
//     }

//   , mouseenter: function (e) {
//       this.mousedover = true
//       this.$menu.find('.active').removeClass('active')
//       $(e.currentTarget).addClass('active')
//     }

//   , mouseleave: function (e) {
//       this.mousedover = false
//       if (!this.focused && this.shown) this.hide()
//     }

//   }


//   /* TYPEAHEAD PLUGIN DEFINITION
//    * =========================== */

//   var old = $.fn.typeahead

//   $.fn.typeahead = function (option) {
//     return this.each(function () {
//       var $this = $(this)
//         , data = $this.data('typeahead')
//         , options = typeof option == 'object' && option
//       if (!data) $this.data('typeahead', (data = new Typeahead(this, options)))
//       if (typeof option == 'string') data[option]()
//     })
//   }

//   $.fn.typeahead.defaults = {
//     source: []
//   , items: 8
//   , menu: '<ul class="typeahead dropdown-menu"></ul>'
//   , item: '<li><a href="#"></a></li>'
//   , minLength: 1
//   }

//   $.fn.typeahead.Constructor = Typeahead


//  /* TYPEAHEAD NO CONFLICT
//   * =================== */

//   $.fn.typeahead.noConflict = function () {
//     $.fn.typeahead = old
//     return this
//   }


//  /* TYPEAHEAD DATA-API
//   * ================== */

//   $(document).on('focus.typeahead.data-api', '[data-provide="typeahead"]', function (e) {
//     var $this = $(this)
//     if ($this.data('typeahead')) return
//     $this.typeahead($this.data())
//   })

// }(window.jQuery);
// /*jslint forin: true */

// ;(function($) {
//     $.fn.extend({
//         mention: function(options) {
//             this.opts = {
//                 users: [],
//                 delimiter: '@',
//                 sensitive: true,
//                 emptyQuery: false,
//                 queryBy: ['name', 'username'],
//                 typeaheadOpts: {}
//             };

//             var settings = $.extend({}, this.opts, options),
//                 _checkDependencies = function() {
//                     if (typeof $ == 'undefined') {
//                         throw new Error("jQuery is Required");
//                     }
//                     else {
//                         if (typeof $.fn.typeahead == 'undefined') {
//                             throw new Error("Typeahead is Required");
//                         }
//                     }
//                     return true;
//                 },
//                 _extractCurrentQuery = function(query, caratPos) {
//                     var i;
//                     for (i = caratPos; i >= 0; i--) {
//                         if (query[i] == settings.delimiter) {
//                             break;
//                         }
//                     }
//                     return query.substring(i, caratPos);
//                 },
//                 _matcher = function(itemProps) {
//                     var i;

//                     if(settings.emptyQuery){
//                       var q = (this.query.toLowerCase()),
//                         caratPos = this.$element[0].selectionStart,
//                         lastChar = q.slice(caratPos-1,caratPos);
//                       if(lastChar==settings.delimiter){
//                         return true;
//                       }
//                     }

//                     for (i in settings.queryBy) {
//                         if (itemProps[settings.queryBy[i]]) {
//                             var item = itemProps[settings.queryBy[i]].toLowerCase(),
//                                 usernames = (this.query.toLowerCase()).match(new RegExp(settings.delimiter + '\\w+', "g")),
//                                 j;
//                             if ( !! usernames) {
//                                 for (j = 0; j < usernames.length; j++) {
//                                     var username = (usernames[j].substring(1)).toLowerCase(),
//                                         re = new RegExp(settings.delimiter + item, "g"),
//                                         used = ((this.query.toLowerCase()).match(re));

//                                     if (item.indexOf(username) != -1 && used === null) {
//                                         return true;
//                                     }
//                                 }
//                             }
//                         }
//                     }
//                 },
//                 _updater = function(item) {
//                     var data = this.query,
//                         caratPos = this.$element[0].selectionStart,
//                         i;

//                     for (i = caratPos; i >= 0; i--) {
//                         if (data[i] == settings.delimiter) {
//                             break;
//                         }
//                     }
//                     var replace = data.substring(i, caratPos),
//                       textBefore = data.substring(0, i),
//                       textAfter = data.substring(caratPos),
//                       data = textBefore + settings.delimiter + item + textAfter;

//                     this.tempQuery = data;

//                     return data;
//                 },
//                 _sorter = function(items) {
//                     if (items.length && settings.sensitive) {
//                         var currentUser = _extractCurrentQuery(this.query, this.$element[0].selectionStart).substring(1),
//                             i, len = items.length,
//                             priorities = {
//                                 highest: [],
//                                 high: [],
//                                 med: [],
//                                 low: []
//                             }, finals = [];
//                         if (currentUser.length == 1) {
//                             for (i = 0; i < len; i++) {
//                                 var currentRes = items[i];

//                                 if ((currentRes.username[0] == currentUser)) {
//                                     priorities.highest.push(currentRes);
//                                 }
//                                 else if ((currentRes.username[0].toLowerCase() == currentUser.toLowerCase())) {
//                                     priorities.high.push(currentRes);
//                                 }
//                                 else if (currentRes.username.indexOf(currentUser) != -1) {
//                                     priorities.med.push(currentRes);
//                                 }
//                                 else {
//                                     priorities.low.push(currentRes);
//                                 }
//                             }
//                             for (i in priorities) {
//                                 var j;
//                                 for (j in priorities[i]) {
//                                     finals.push(priorities[i][j]);
//                                 }
//                             }
//                             return finals;
//                         }
//                     }
//                     return items;
//                 },
//                 _render = function(items) {
//                     var that = this;
//                     items = $(items).map(function(i, item) {

//                         i = $(that.options.item).attr('data-value', item.username);

//                         var _linkHtml = $('<div />');

//                         if (item.image) {
//                             _linkHtml.append('<img class="mention_image" src="' + item.image + '">');
//                         }
//                         if (item.name) {
//                             _linkHtml.append('<b class="mention_name">' + item.name + '</b>');
//                         }
//                         if (item.username) {
//                             _linkHtml.append('<span class="mention_username"> ' + settings.delimiter + item.username + '</span>');
//                         }

//                         i.find('a').html(that.highlighter(_linkHtml.html()));
//                         return i[0];
//                     });

//                     items.first().addClass('active');
//                     this.$menu.html(items);
//                     return this;
//                 };

//             $.fn.typeahead.Constructor.prototype.render = _render;

//             return this.each(function() {
//                 var _this = $(this);
//                 if (_checkDependencies()) {
//                     _this.typeahead($.extend({
//                         source: settings.users,
//                         matcher: _matcher,
//                         updater: _updater,
//                         sorter: _sorter
//                     }, settings.typeaheadOpts));
//                 }
//             });
//         }
//     });
// })(jQuery);
var editor = new MediumEditor('.editable', {
  toolbar: {
      /* These are the default options for the toolbar,
         if nothing is passed this is what is used */
      allowMultiParagraphSelection: true,
      buttons: ['bold', 'italic', 'underline'],
      diffLeft: 0,
      diffTop: -10,
      firstButtonClass: 'medium-editor-button-first',
      lastButtonClass: 'medium-editor-button-last',
      relativeContainer: null,
      standardizeSelectionStart: false,
      static: false,
      /* options which only apply when static is true */
      align: 'center',
      sticky: false,
      updateOnEmptySelection: false
  },
  placeholder: {
      /* This example includes the default options for placeholder,
         if nothing is passed this is what it used */
      text: 'Il était une fois...',
      hideOnClick: true
  }
});


if ($('#progress-bar-book').length) {
  var line = new ProgressBar.Line('#progress-bar-book', {
    strokeWidth: 4,
    easing: 'easeIn',
  });
  $(document).ready(function(){

    line.animate(gon.word_goal_ratio, {
      duration: 800,
      from: { color: '#eee' },
      to: { color: '#000' },
    }, function() {
    });
  });
}



// AUTO-SAVE WHEN USER STOP WRITING

//setup before functions
var typingTimer ;
var doneTypingInterval = 2000 ;
var $form = $('#form') ;
var $save = $('.saving-status');

//on keyup, start the countdown
$form.on('keyup', function () {
  $save.removeClass("saving-status--saved");
  $save.html("Sauvegarde...");
  clearTimeout(typingTimer);
  typingTimer = setTimeout(doneTyping, doneTypingInterval);
});

//on keydown, clear the countdown
$form.on('keydown', function () {
  clearTimeout(typingTimer);
});

// user is "finished typing," do something
function doneTyping () {
  $form.submit();
  $save.addClass("saving-status--saved");
  $save.html("Enregistré !");
  if ($('#progress-bar-book').length) {
    $.get(gon.fetch_refresh_wordcount_url,function(data){
         console.log(data)
         line.animate(data);
      });
  }
}

// INKS ANIMATION

// https://codepen.io/ohansemmanuel/pen/dVdvJQ

const inkdrop = document.getElementById('inkdrop')
const inkIcon = document.getElementById('inkdrop-icon')
const inkCount = document.getElementById('ink-count')
const inkTotalCount = document.getElementById('ink-total-count')
const initialNumberOfInks = gon.inks;
const tlDuration = 300
let numberOfInks = gon.user_inks
let inkHold;

inkTotalCount.innerHTML = gon.inks

const triangleBurst = new mojs.Burst({
  parent: inkdrop,
  radius: {50:95},
  count: 5,
  angle: 30,
  children: {
    shape: 'polygon',
    radius: {6: 0},
    scale: 1,
    stroke: 'rgba(211,84,0 ,0.5)',
    strokeWidth: 2,
    angle: 210,
    delay: 30,
    speed: 0.2,
    easing: mojs.easing.bezier(0.1, 1, 0.3 ,1),
    duration: tlDuration
  }
})

const circleBurst = new mojs.Burst({
  parent: inkdrop,
  radius: {50:75},
  angle: 25,
  duration: tlDuration,
  children: {
    shape: 'circle',
    fill: 'rgba(149,165,166 ,0.5)',
    delay: 30,
    speed: 0.2,
    radius: {3: 0},
    easing: mojs.easing.bezier(0.1, 1, 0.3, 1),
  }
})

const countAnimation = new mojs.Html({
  el: '#ink-count',
  isShowStart: false,
  isShowEnd: true,
  y: {0: -30},
  opacity: {0:1},
  duration: tlDuration
}).then({
  opacity: {1:0},
  y: -80,
  delay: tlDuration/2
})

const countTotalAnimation = new mojs.Html({
  el: '#ink-total-count',
  isShowStart: true,
  isShowEnd: true,
  opacity: {1:1},
  delay: 3*(tlDuration)/2,
  duration: tlDuration,
})

const scaleButton = new mojs.Html({
  el: '#inkdrop',
  duration: tlDuration,
  scale: {1.3: 1},
  easing: mojs.easing.out
})

inkdrop.style.transform = "scale(1, 1)"

const animationTimeline = new mojs.Timeline()
animationTimeline.add([
  triangleBurst,
  circleBurst,
  countAnimation,
  countTotalAnimation,
  scaleButton
])

inkdrop.addEventListener('click', function() {
   repeatInking();
})

inkdrop.addEventListener('mousedown', function() {
   inkHold = setInterval(function() {
   repeatInking();
   }, 400)
})

inkdrop.addEventListener('mouseup', function() {
 clearInterval(inkHold);
})

function repeatInking() {
  updateNumberOfInks()
  animationTimeline.replay()
  inkIcon.classList.add('checked')
}

function updateNumberOfInks() {
  numberOfInks < 50 ? numberOfInks++ : null
  inkCount.innerHTML = "+" + numberOfInks
  inkTotalCount.innerHTML = gon.inks
}
;

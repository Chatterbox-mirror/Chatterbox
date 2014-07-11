/* *
 * markdownEditor (http://gitcafe.com/Qianfeng/markdownEditor/)
 * Released under MIT license
 * Copyright (c) 2012-2012 Qianfeng <wu1990@gmail.com> (http://qianfeng.gitcafe.com/)
 * 时间关系，功能非常不全面。
 * 依赖 :
 *   * markdown-js - https://github.com/evilstreak/markdown-js
 *   * jQuery - https://jquery.com
 */

(function (editorName) {

  /* ---------------------------
   * Editor Class
   */
  function Editor(settings) {
    var editor;
    var isIE = !-[1, ];
    this.cmd = {};

    var trim = function (str) {
      var m = str.length;
      for (var i = 0; i < m; i++) {
        if (str.charCodeAt(i) > 32) {
          break;
        }
      }

      for (var j = m - 1; j > i; j--) {
        if (str.charCodeAt(j) > 32) {
          break;
        }
      }

      return str.slice(i, j + 1);
    };

    var locales = {
      'en': {
        head3: 'Header 3',
        bold: 'Bold',
        italic: 'Italic',
        quote: 'Blockquote',
        code: 'Code',
        pre: 'Code Block',
        ul: 'Unordered list',
        ol: 'Ordered list',
        link: 'Link',
        picture: 'Picture',
        preview: 'Preview',
        link_to: 'Link to URL',
        image_url: 'Link to image'
      },
      'zh-CN': {
        head3: '三级标题',
        bold: '粗体',
        italic: '斜体',
        quote: '引用',
        code: '代码',
        pre: '代码块',
        ul: '无序列表',
        ol: '有序列表',
        link: '链接',
        picture: '图片',
        preview: '预览',
        link_to: '链接地址',
        image_url: "图片地址"
      },
      'zh-TW': {
        head3: '三級標題',
        bold: '粗體',
        italic: '斜體',
        quote: '引用',
        code: '代碼',
        pre: '代碼塊',
        ul: '無序列表',
        ol: '有序列表',
        link: '鏈接',
        picture: '圖片',
        preview: '預覽',
        link_to: '鏈接地址',
        image_url: "圖片地址"
      }
    };

    var T = locales[$('html').attr('lang')];

    this._init = function (settings) {
      this.settings = settings;

      this.wrap = this.createWrap(); // 创建编辑器html对象
      this.preview = this.wrap.find(".editor-preview"); //预览区域
      this.toolbar = this.wrap.find(".editor-toolbar"); //工具栏
      this.textarea = settings.textarea; // 直接使用原本的textarea对象

      this.textarea[0][editorName] = editor = this; //
      settings = undefined;

      this.textarea.after(editor.wrap); // 在页面中加入编辑器
      this.textarea.remove(); // 去掉原本的textarea
      this.wrap.find(".editor-textarea").append(editor.textarea); //将原本的textarea加到编辑器中~
      this.bindEvents();
      this.cmd.textareaChange();
      //return;
    }

    this.createWrap = function () {
      var toolbarButtons = {
        head3: '<li class="editor-toolbar-button-head3"><a title="' + T.head3 + '" href="javascript:;"><i class="editor-icon-head"></i></a></li>',
        bold: '<li class="editor-toolbar-button-bold"><a title="' + T.bold + '" href="javascript:;"><i class="editor-icon-blod"></i></a></li>',
        italic: '<li class="editor-toolbar-button-italic"><a title="' + T.italic + '" href="javascript:;"><i class="editor-icon-italic"></i></a></li>',
        quote: '<li class="editor-toolbar-button-quote"><a title="' + T.quote + '" href="javascript:;"><i class="editor-icon-quote"></i></a></li>',
        code: '<li class="editor-toolbar-button-code"><a title="' + T.code + '" href="javascript:;"><i class="editor-icon-code"></i></a></li>',
        pre: '<li class="editor-toolbar-button-pre"><a title="' + T.pre + '" href="javascript:;"><i class="editor-icon-pre"></i></a></li>',
        ul: '<li class="editor-toolbar-button-ul"><a title="' + T.ul + '" href="javascript:;"><i class="editor-icon-ul"></i></a></li>',
        ol: '<li class="editor-toolbar-button-ol"><a title="' + T.ol + '" href="javascript:;"><i class="editor-icon-ol"></i></a></li>',
        link: '<li class="editor-toolbar-button-link"><a title="' + T.link + '" href="javascript:;"><i class="editor-icon-link"></i></a></li>',
        picture: '<li class="editor-toolbar-button-picture"><a title="' + T.picture + '" href="javascript:;"><i class="editor-icon-picture"></i></a></li>'
      }
      var actionsHTML = [];
      if (this.settings.actions) {
        var actions = this.settings.actions
      } else {
        var actions = ['head3', 'bold', 'italic', 'quote', 'code', 'pre', 'ul', 'ol', 'link', 'picture'];
      }

      for (var k in actions) {
        toolbarButtons[actions[k]] && actionsHTML.push(toolbarButtons[actions[k]]);
      }
      var editorHTML = [
        '<div class="editor-wrap">',
        ' <div class="editor-head">',
        '   <ul class="editor-toolbar">' + actionsHTML.join('') + '</ul>',
        '   <a href="javascript:;" class="btn2 editor-preview-toggle">' + T.preview + '</a>',
        ' </div>',
        ' <div class="editor-textarea"></div>',
        ' <div class="editor-preview hide">',
        '   <div class="editor-preview-body"></div>',
        ' </div>',
        '</div>'].join('');

      return $(editorHTML);
    }

    this.bindEvents = function () {
      for (var func in this.bindEvents) {
        this.bindEvents[func]();
      }
    }

    /**
     * 编辑器命令
     */
    this.cmd.common = function (prefix, suffix, settings) {
      var defaultSettings = {
        rule: 'normal',
        eachline: true,
        clearBR: false
      };
      if (settings) {
        for (k in defaultSettings) {
          if (settings[k] == undefined) {
            settings[k] = defaultSettings[k];
          }
        }
      } else {
        settings = defaultSettings;
      }
      var rangeData = editor.cursorPosition.get();
      var start = rangeData.start;
      var resultText = rangeData.text;
      if (settings.clearBR) {
        resultText = resultText.replace(/\n/g, " ");
      }
      if (settings.rule == 'replace') {
        resultText = '';
      }

      selectedTextLengh = resultText.length;
      var lines = resultText.split("\n");

      if (settings.eachline && lines.length > 1) {
        for (var n in lines) {
          if (trim(lines[n]).length > 0) {
            lines[n] = prefix + trim(lines[n]) + suffix;
          }
        }
        resultText = lines.join("\n");
      } else {
        resultText = prefix + resultText + suffix;
      }

      editor.cursorPosition.insert(rangeData, resultText, selectedTextLengh == 0 ? -suffix.length : 0);
      return true;
    }

    this.cursorPosition = {};
    this.cursorPosition.get = function () {
      var textarea = editor.textarea[0];
      var rangeData = {
        text: "",
        start: 0,
        end: 0
      };

      if (textarea.setSelectionRange) { // W3C
        textarea.focus();
        rangeData.start = textarea.selectionStart;
        rangeData.end = textarea.selectionEnd;
        rangeData.text = (rangeData.start != rangeData.end) ? textarea.value.substring(rangeData.start, rangeData.end) : "";
      } else if (document.selection) { // IE
        textarea.focus();
        var i,
          oS = document.selection.createRange(),
          // Don't: oR = textarea.createTextRange()
          oR = document.body.createTextRange();

        oR.moveToElementText(textarea);

        rangeData.text = oS.text;
        rangeData.bookmark = oS.getBookmark();
        // object.moveStart(sUnit [, iCount])
        // Return Value: Integer that returns the number of units moved.
        for (i = 0; oR.compareEndPoints('StartToStart', oS) < 0 && oS.moveStart("character", -1) !== 0; i++) {
          // Why? You can alert(textarea.value.length)
          if (textarea.value.charAt(i) == '\r') {
            i++;
          }
        }
        rangeData.start = i;
        rangeData.end = rangeData.text.length + rangeData.start;
      }

      return rangeData;
    }

    this.cursorPosition.set = function (rangeData) {
      var textarea = editor.textarea[0];
      var oR, start, end;
      if (!rangeData) {
        alert("You must get cursor position first.")
      }
      textarea.focus();
      if (textarea.setSelectionRange) { // W3C
        textarea.setSelectionRange(rangeData.start, rangeData.end);
      } else if (textarea.createTextRange) { // IE
        oR = textarea.createTextRange();
        // Fixbug : ues moveToBookmark()
        // In IE, if cursor position at` the end of textarea, the set function don't work
        if (textarea.value.length === rangeData.start) {
          oR.collapse(false);
          oR.select();
        } else if (rangeData.bookmark !== undefined) {
          oR.moveToBookmark(rangeData.bookmark);
          oR.select();
        } else {
          oR.collapse(true);
          oR.moveEnd('character', rangeData.start);
          oR.moveStart('character', rangeData.end);
          oR.select();
        }
      }
    }
    this.cursorPosition.insert = function (rangeData, text, offsetFocus) {
      var textarea = editor.textarea[0];
      var oValue, nValue, oR, sR, nStart, nEnd, st;
      this.set(rangeData);

      if (textarea.setSelectionRange) { // W3C
        oValue = textarea.value;
        nValue = oValue.substring(0, rangeData.start) + text + oValue.substring(rangeData.end);
        nStart = nEnd = rangeData.start + text.length;
        st = textarea.scrollTop;
        textarea.value = nValue;
        // Fixbug:
        // After textarea.values = nValue, scrollTop value to 0
        if (textarea.scrollTop != st) {
          textarea.scrollTop = st;
        }
        nStart += offsetFocus;
        nEnd += offsetFocus;
        textarea.setSelectionRange(nStart, nEnd);
      } else if (textarea.createTextRange) { // IE
        sR = document.selection.createRange();
        sR.text = text;
        sR.setEndPoint('StartToEnd', sR);
        if (offsetFocus) {
          sR.collapse(true);
          sR.moveStart('character', offsetFocus);
          sR.moveEnd('character', offsetFocus);
        }
        sR.select();
      }
    }

    this.cmd.bold = function () {
      this.common("**", "**")
    }
    this.cmd.italic = function () {
      this.common("_", "_")
    }
    this.cmd.quote = function () {
      this.common(">", "", {
        eachline: true
      })
    }
    this.cmd.code = function () {
      this.common("`", "`")
    }
    this.cmd.pre = function () {
      this.common("    ", "", {
        eachline: true
      })
    }
    this.cmd.head3 = function () {
      this.common("### ", "")
    }
    this.cmd.link = function () {
      var link = prompt(T.link_to, "http://");
      if (!link) return;
      if (editor.cursorPosition.get().text.length > 0) {
        this.common("[", "](" + link + ")", {
          clearBR: true
        });
      } else {
        this.common("<", link + ">", {
          clearBR: true
        });
      }
    }
    this.cmd.ul = function () {
      this.common("- ", "")
    }
    this.cmd.ol = function () {
      this.common("0. ", "")
    }
    this.cmd.picture = function (url) {
      if (url == undefined) {
        url = prompt(T.image_url, "http://");
      }
      url && this.common("![", "](" + url + ")", {
        rule: 'replace'
      });
      // ![](/path/to/img.jpg "Optional title")
    }
    this.cmd.textareaChange = function () {
      var value = editor.textarea.val();
      value = markdown.toHTML(value);
      editor.preview.find(".editor-preview-body").html(value);
    }
    this.cmd.previewToggle = function () {
      $(this).toggleClass('active');
      editor.preview.toggleClass("hide");
    }

    /**
     * 绑定事件
     */
    this.bindEvents.setup = function () {
      if (editor.settings['previewBodyClass']) {
        editor.preview.find(".editor-preview-body").addClass(editor.settings['previewBodyClass'])
      }
    }

    this.bindEvents.textareaKeyup = function () {
      editor.textarea.keyup(editor.cmd.textareaChange);
      editor.textarea.keyup(function (e) {
        if (e.keyCode == 13) {
          var lines = editor.textarea.val().split("\n");
          var lineTotal = lines.length;

          if (lineTotal > 1) {
            var linePrefix = /^\*\s+|^\-\s+|^_\s+|^[0-9]+\.\s+/.exec(lines[lineTotal - 2]);
            if (linePrefix) {
              linePrefix = linePrefix[0];
              editor.cmd.common(linePrefix, "", {});
            }
          }
          return true;
        }
      });
    }

    this.bindEvents.previewToggleClick = function () {
      editor.wrap.find(".editor-preview-toggle").click(editor.cmd.previewToggle)
    }

    this.bindEvents.toolbarButtonClick = function () {
      editor.toolbar.find("li").click(function () {
        var cmdName = $(this).attr("class").replace("editor-toolbar-button-", "");
        if (cmdName in editor.cmd) {
          (editor.cmd[cmdName])();
        }

        editor.cmd.textareaChange();
      })
    }

    this._init(settings);
  }

  // var editorFactory = {};
  // editorFactory.create = function(settings)
  // {
  //   return new Editor(settings);
  // }
  // window[editorName] = editorFactory;

  jQuery.fn[editorName] = function (settings) {
    var editors = [];
    this.each(function () {
      if ($(this)[0][editorName]) {
        editors.push($(this)[0][editorName]);
      } else {
        var _settings = jQuery.extend({
          textarea: $(this)
        }, settings, {
          previewBodyClass: 'markdown'
        });
        editors.push(new Editor(_settings));
      }
    })
    return editors;
  };

})('markDownEditor');

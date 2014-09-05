module Redcarpet
  module Render
    class HTMLwithPygments < HTML
      def block_code(code, language)
        language = 'text' if language.blank?

        if Pygments::Lexer.find(language)
          lang_div = '<div class="highlight-lang"><span><i class="fa fa-code"></i> ' + language + '</span></div>'
          lang_div + Pygments.highlight(code, :lexer => language, :options => {:encoding => 'utf-8'})
        else
          Pygments.highlight(code, :options => {:encoding => 'utf-8'})
        end
      end
    end
    class HTMLwithPygmentsWithoutScriptTag < HTMLwithPygments
      def block_html(raw_html)
        raw_html.gsub(/<(\/?)script([^>]*)>/, '&lt;\1script\2&gt;')
      end

      def raw_html(raw_html)
        raw_html.gsub(/<(\/?)script([^>]*)>/, '&lt;\1script\2&gt;')
      end
    end
  end
end

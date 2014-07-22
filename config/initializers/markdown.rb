module Redcarpet
  module Render
    class HTMLwithPygments < HTML
      def block_code(code, language)
        language = 'text' if language.blank?

        if Pygments::Lexer.find(language)
          Pygments.highlight(code, :lexer => language, :options => {:encoding => 'utf-8'})
        else
          Pygments.highlight(code, :options => {:encoding => 'utf-8'})
        end
      end
    end
  end
end

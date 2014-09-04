
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  scope :after, -> (start) { where("id > ?", start) }
  scope :before, -> (e) { where("id < ?", e) }
  scope :archive, -> { where(status: 'closed') }
  # validates :content, presence: true
  before_save :filter_keywords

  def author_name
    user.try( :name) || "Guest"
  end

  def html_content
    markdown(content)
  end

  class << self
    def new_with_cast(*a, &b)
      if (h = a.first).is_a? Hash and (type = h.delete(:type) || h.delete('type')) and (klass = type.constantize) != self
        raise "wtF hax!!"  unless klass < self  # klass should be a descendant of us
        return klass.new(*a, &b)
      end
      new_without_cast(*a, &b)
    end

    alias_method_chain :new, :cast
  end
protected

    def convert_content
      self.content_html = markdown(content)
    end

    def close_tags(html, selector = '.markdown')
      doc = Nokogiri::HTML.parse(html)
      doc.at(selector).to_html.html_safe
    end
  def markdown(text)
      html = Redcarpet::Markdown.new(Redcarpet::Render::HTMLwithPygmentsWithoutScriptTag,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        strikethrough: true,
        lax_html_blocks: true
      ).render(text)

      close_tags "<div class='markdown'>#{html}</div>"
    end
    def filter_keywords
      self.content = Keyword.filter content
    end
end

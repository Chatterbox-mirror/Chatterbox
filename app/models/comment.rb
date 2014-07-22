
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  scope :after, -> (start) { where("id > ?", start) }
  scope :before, -> (e) { where("id < ?", e) }
  validates :content, presence: true


  def author_name
    user.try( :name) || "Guest"
  end

  def html_content
    markdown(content)
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
      html = Redcarpet::Markdown.new(Redcarpet::Render::HTMLwithPygments,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        strikethrough: true,
        lax_html_blocks: true
      ).render(text)

      close_tags "<div class='markdown'>#{html}</div>"
    end
end

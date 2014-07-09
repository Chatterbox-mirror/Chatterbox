module ApplicationHelper
  def render_templates
    Dir["#{Rails.root}/app/views/tmpl/*"].map do |path|
      extname = File.extname(path)
      basename = File.basename(path, extname)
      render(template: "tmpl/#{basename}").html_safe
    end.join.html_safe
  end
end

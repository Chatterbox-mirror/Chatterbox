class Keyword
  Path = Rails.root.join('config/keywords.txt').freeze
  def self.filter(content)
    content.gsub(regexp, '**') if regexp
  end

  def self.load
    IO.read(Path).split if File.exists?(Path)
  end

  def self.save(keywords)
    IO.write(Path, keywords.join("\n"))
  end

  def self.regexp
    s =  Array(load).map{|t| Regexp.escape(t) }.join("|")
    @regexp ||= Regexp.new s if s.size > 0
  end
end

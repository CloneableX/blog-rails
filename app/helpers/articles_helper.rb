module ArticlesHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end

    def block_quote(quote)
      %(<blockquote class="article-quote">#{quote}</blockquote>)
    end
  end

  def markdown_to_html(content)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: '_blank' }
    }

    extensions = {
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      autolink: true,
      lax_spacing: true
    }

    renderer = CodeRayify.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(content).html_safe
  end
end

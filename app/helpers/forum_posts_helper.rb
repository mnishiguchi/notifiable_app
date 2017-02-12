module ForumPostsHelper
  # https://github.com/jch/html-pipeline
  # gem 'html-pipeline'
  # gem 'github-markdown'
  # gem 'sanitize'
  def markdownify(content)
    pipeline_context = { gfm: true}
    pipeline_filters = [
      HTML::Pipeline::MarkdownFilter,     # Transform Markdown source into Markdown HTML.
      HTML::Pipeline::SanitizationFilter, # Filter out script tags. Always use it.
    ]
    pipeline = HTML::Pipeline.new(pipeline_filters, pipeline_context)
    pipeline.call(content)[:output].to_s.html_safe
  end
end

=begin
A simple Ruby/Jekyll plugin, to insert an example file in-line
(instead of duplicating the text by including the example file in the markdown).

Usage example (in a _post/XXXX file):

   {% insert_example lib/awk/eliza.awk %}

Will insert the content of './lib/awk/eliza.awk' in the post.
Combine with Pygments hightlighting for full effect:

   {% highlight awk %}
   {% insert_example lib/awk/eliza.awk %}
   {% endhighlight %}

Author:
  gordon

=end

module Jekyll
	class InsertExampleTag < Liquid::Tag

		def initialize(tag_name, text, tokens)
			super
			@filename = text.strip
		end

		def render(context)
			begin
				result = ""
				file = File.new(@filename);
				while (line = file.gets)
					line = line.chomp
					# The magic marker at the end of AWK examples
					# don't include the comments following this line
					# in the Jekyll generated page.
					break if line == "## awk.info:"
					result = result + line + "\n"
				end
				result
			rescue => err
				"Insert_Example Error: failed to " \
				     "find example file '#{@filename}': #{err}"
			end
		end
	end
end

Liquid::Template.register_tag('insert_example', Jekyll::InsertExampleTag)

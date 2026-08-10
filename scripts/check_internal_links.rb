#!/usr/bin/env ruby

require "nokogiri"
require "pathname"
require "uri"

site_root = Pathname.new(ARGV.fetch(0, "_site")).expand_path
failures = []
html_files = Dir[site_root.join("**", "*.html")]

html_files.each do |html_file|
  document = Nokogiri::HTML(File.read(html_file))

  document.css("[href], [src]").each do |node|
    raw_url = node["href"] || node["src"]
    next if raw_url.nil? || raw_url.empty? || raw_url.start_with?("#", "//")

    begin
      uri = URI.parse(raw_url)
    rescue URI::InvalidURIError
      failures << "#{html_file}: invalid URL #{raw_url.inspect}"
      next
    end

    next if uri.scheme
    next if uri.path.nil? || uri.path.empty?

    decoded_path = URI::DEFAULT_PARSER.unescape(uri.path)
    candidate = if decoded_path.start_with?("/")
                  site_root.join(decoded_path.delete_prefix("/"))
                else
                  Pathname.new(html_file).dirname.join(decoded_path).cleanpath
                end

    possible_files = [candidate]
    possible_files << candidate.join("index.html")
    possible_files << Pathname.new("#{candidate}.html") if candidate.extname.empty?

    next if possible_files.any?(&:file?)

    failures << "#{html_file}: missing internal target #{raw_url.inspect}"
  end
end

if failures.any?
  warn failures.uniq.sort.join("\n")
  abort "Internal link check failed with #{failures.uniq.length} problem(s)."
end

puts "Checked #{html_files.length} HTML files; all internal targets exist."

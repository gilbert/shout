class DebugController < ApplicationController
  def index
    @links = [
      ['icons/solid/badge-check', 'View All Icons', '/debug/icons'],
      ['icons/solid/color-swatch', 'View Tailwind Colors', '/debug/colors'],
      ['icons/solid/mail', 'View Action Mailer Previews', '/rails/mailers'],
    ]
  end

  def icons
    @solid = Dir[File.join(Rails.root, "/app/views/icons/solid/*")].map do |path|
      OpenStruct.new(
        name: File.basename(path, '.html.erb').sub(/^_/, ''),
        type: 'solid',
      )
    end

    @outline = Dir[File.join(Rails.root, "/app/views/icons/outline/*")].map do |path|
      OpenStruct.new(
        name: File.basename(path, '.html.erb').sub(/^_/, ''),
        type: 'outline',
      )
    end
  end

  def colors
    @colors = %w(gray blue indigo teal red orange yellow)
  end
end

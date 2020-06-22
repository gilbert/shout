module ApplicationHelper
  # Used for rendering icons
  def splat_attrs(local_assigns)
    raw local_assigns.map {|attr,value| %Q{#{attr}="#{value}"} }.join(' ')
  end
end

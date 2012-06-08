module ApplicationHelper
  # From Railscasts, Ryan Bates, http://railscasts.com/episodes/197-nested-model-form-part-2
  def link_to_remove_fields(name, f, html_options = {})
	  # Add classes to work with jQuery UI
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", 
		:class => "ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only " + html_options[:class],
		:role => "button",
		:aria_disabled => "false")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      logger.debug("------------" + render(association.to_s.singularize + "_fields", :f => builder))
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    logger.debug("********* Fields ********* : " + fields)
    link_to_function(name, "add_fields_by_container(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "button")
  end

  # From: http://railscasts.com/episodes/30-pretty-page-title
  def title(page_title)
    content_for(:title) { page_title }
  end

# These are so we can use the devise views anywhere we want
# See https://github.com/plataformatec/devise/wiki/How-To:-Display-a-custom-sign_in-form-anywhere-in-your-app
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end


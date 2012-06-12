<% if params[:was_missing] %>

$("#element_<%= @element.id %>_content_missing").replaceWith('<%= escape_javascript(
  render(
    :partial => "alchemy/essences/#{@content.essence_partial_name}_editor",
    :locals => @locals
  )
) %>')

<% else %>

$("<%= @content_dom_id %>").before('<%= escape_javascript(
  render(
    :partial => "alchemy/essences/#{@content.essence_partial_name}_editor",
    :locals => @locals
  )
) %>')
Alchemy.enableButton('.disabled.button')
Alchemy.overlayObserver('#<%= content_dom_id(@content) %>')

<% end %>

<% if @content.essence_type == "Alchemy::EssencePicture" %>

$('#picture_to_assign_<%= @content.ingredient.id %> a').attr('href', '#').off('click')

<% if @contents_of_this_type.length > 1 %>
$('#element_<%= @element.id %>_contents .essence_picture_editor').addClass('dragable_picture')
<% end %>

<% if !max_image_count.blank? && @contents_of_this_type.length >= max_image_count %>
$("#add_content_<%= @element.id %>").remove()
<% end %>

Alchemy.SortableContents('#element_<%= @element.id %>_contents', '<%= form_authenticity_token %>')

<% elsif @content.essence_type == "Alchemy::EssenceDate" %>

Alchemy.Datepicker('#element_<%= @element.id %> input.date')

<% elsif @content.essence_type == "Alchemy::EssenceRichtext" %>

Alchemy.Tinymce.addEditor('contents_content_<%= @content.id %>_body')

<% end %>

Alchemy.reloadPreview()
Alchemy.closeCurrentWindow()
Alchemy.SelectBox("#element_<%= @element.id %> select.alchemy_selectbox")

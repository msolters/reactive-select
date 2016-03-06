Template.select.created = ->
  @autorun =>
    value = Template.currentData().value
    unless @selected_text?
      @selected_text = new ReactiveVar value
    else
      @selected_text.set value

Template.select.helpers
  selected_text: ->
    Template.instance().selected_text.get()
  selected: ->
    return true if Template.instance().selected_text.get() is @text
    return false

Template.select.events =
  'change select': (event, template) ->
    new_value = $(event.target).find('option:selected').text()
    template.selected_text.set new_value
    @value = new_value

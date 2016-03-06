Template.select.created = ->
  @autorun =>
    choice = Template.currentData().choice
    unless @selected_choice?
      @selected_choice = new ReactiveVar choice
    else
      @selected_choice.set choice

Template.select.helpers
  selected: ->
    choice = Template.instance().selected_choice.get()
    return true if (choice.value is @value) or (choice.text is @text)
    return false

Template.select.events =
  'change select': (event, template) ->
    #
    # Construct a new "choice" object
    #
    selected_choice = $(event.target).find('option:selected')
    new_choice =
      text: selected_choice.text()
      value: selected_choice.val()
    #
    # Update reactive and non-reactive data sources
    #
    template.selected_choice.set new_choice
    @choice = new_choice

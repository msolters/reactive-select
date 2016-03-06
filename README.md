# msolters:reactive-select

This package allows you to create simple drop downs where the options and the currently selected choice can be reactively get and/or set.

This package is based off [this gist](https://gist.github.com/tmeasday/3368472) by MDG's Tom Coleman.  I've simply made it more convenient to get/set the current choice.

## Use:
To create a dropdown, here's the template code showing all available options:

```
{{> select id="mySelectID" name="mySelectName" include_blank=true options=selectOptions value=currentChoice }}
```

> Note: Only `options` and `value` are required parameters. `id`, `name`, and `include_blank` are optional.

### Reactive set/get of Current Choice
Here's an example template that shows how one may reactively set or get the current choice in the `select` dropdown.  For simplicity, we'll use a Session var called `foobar` as our reactive data source!

*  The `select` template will automatically update the currently selected choice to whatever the `value` parameter is.
*  Likewise, the `value` parameter of the `select` can be used to grab the current choice at any time.

Template HTML:

```html
<template name="foo">
  {{> select id="fooSelect" options=selectOptions value=foobar}}
</template>
```

Template JS:

```coffeescript
# Initialize the current choice as "6 players"
Template.foo.created = ->
  Session.set "foobar", "6 players"

# Reactive Get
#   If the user updates the select, we can grab the new
#   value by using `this.value`.
Template.foo.events
  "change select#fooSelect": (event, template) ->
    Session.set "foobar", @value

# Reactive Set
Template.foo.helpers
  # selectOptions is just a static array of options for this example
  selectOptions: ({text: "#{i} players", value: i} for i in [0..18])

  # The foobar helper allows us to pass the reactive value
  # of the session var into the select's `value` parameter
  # in our HTML above.
  foobar: ->
    Session.get "foobar"
```

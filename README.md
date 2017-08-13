# RailsVueMelt

[![Gem Version](https://badge.fury.io/rb/rails_vue_melt.svg)](http://badge.fury.io/rb/rails_vue_melt)
[![CircleCI](https://circleci.com/gh/midnightSuyama/rails_vue_melt.svg?style=shield)](https://circleci.com/gh/midnightSuyama/rails_vue_melt)

Rails view with webpack=vue optimizer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_vue_melt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_vue_melt

## Usage

    $ rails new APP_PATH --webpack=vue
    ...
    $ rails generate vue_melt

### Generate

#### create `app/javascript/packs/vue_melt`

* application.js
* options/
    * users.js
* components/
    * Hello.vue
* store/
    * index.js
    * getters.js
    * actions.js
    * mutations.js
    * mutation-types.js

#### insert `app/views/layouts/application.html.erb`

```html
    <%= javascript_pack_tag 'vue_melt/application' %>
    <meta name="turbolinks-cache-control" content="no-cache">
```

#### gsub `config/webpack/loaders/vue.js`

```javascript
    extractCSS: false,
```

#### install packages

* [vuex](https://www.npmjs.com/package/vuex)
* [vue-assign-model](https://www.npmjs.com/package/vue-assign-model)
* [lodash.clonedeep](https://www.npmjs.com/package/lodash.clonedeep)

### Example

```erb
<!-- app/views/**/*.html.erb -->

<div data-vue="users">
  <input value="Example" v-model="user.name">
  <p>User Name: {{ user.name }}</p>

  <hello></hello>
</div>
```

Add `data-vue` attribute, the value is file name in `app/javascript/packs/vue_melt/options`. Vue instance is mounted at `turbolinks:load` event and unmounted at `turbolinks:visit` event.

Before Vue rendering, `value`, `checked` or `selected` attributes of elements with `v-model` is automatically assigned to Vue model. Therefore, `form_with` and so on using Active Model can use data binding easily.

#### accepts_nested_attributes_for

JSON of `data-vue-model` is assigned to Vue model. Also, `v-model` with prefix `_` is not assigned for `v-for` scope.

```erb
<!-- app/views/**/*.html.erb -->

<div data-vue="users">
  <%= content_tag :div, 'data-vue-model': "{ \"items\": #{user.items.to_json} }" do %>
    <div v-for="(_item, i) in items">
      <input type="text" :name="'user[items_attributes][' + i + '][name]'" v-model="_item.name">
      <input type="hidden" :name="'user[items_attributes][' + i + '][id]'" :value="_item.id" v-if="_item.id">
    </div>
  <% end %>
</div>
```

With Add and Remove function:

```erb
<!-- app/views/**/*.html.erb -->

<div data-vue="users">
  <%= content_tag :div, 'data-vue-model': "{ \"items\": #{user.items.to_json}, \"items_destroy_ids\": [] }" do %>
    <div v-for="(_item, i) in items">
      <input type="text" :name="'user[items_attributes][' + i + '][name]'" v-model="_item.name">
      <input type="hidden" :name="'user[items_attributes][' + i + '][id]'" :value="_item.id" v-if="_item.id">
      <button type="button" @click="_item.hasOwnProperty('id') ? items_destroy_ids.push(items.splice(i, 1)[0].id) : items.splice(i, 1)">Remove</button>
    </div>

    <template v-for="(id, i) in items_destroy_ids">
      <input type="hidden" :name="'user[items_attributes][' + (items.length+i) + '][id]'" :value="id">
      <input type="hidden" :name="'user[items_attributes][' + (items.length+i) + '][_destroy]'" value="1">
    </template>

    <button type="button" @click="items.push({ name: '' })">Add</button>
  <% end %>
</div>
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/midnightSuyama/rails_vue_melt.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

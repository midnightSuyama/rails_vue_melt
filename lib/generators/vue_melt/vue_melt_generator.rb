class VueMeltGenerator < Rails::Generators::Base
  source_root File.expand_path('../source', __FILE__)

  def create
    directory '.', 'app/javascript/packs/vue_melt'
  end

  def edit
    inject_into_file 'app/views/layouts/application.html.erb', before: /^\s*<\/head>/ do
<<-EOS
    <%= javascript_pack_tag 'vue_melt/application' %>
    <meta name="turbolinks-cache-control" content="no-cache">
EOS
    end

    inject_into_file 'config/webpack/environment.js', before: /^module\.exports = environment$/ do
<<-EOS
environment.loaders.get('vue').options.extractCSS = false
EOS
    end
  end

  def yarn
    run 'yarn add vuex vue-assign-model lodash.clonedeep'
  end
end

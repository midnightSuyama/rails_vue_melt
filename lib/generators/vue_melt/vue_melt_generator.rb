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
    gsub_file 'config/webpack/loaders/vue.js', 'extractCSS: true,', 'extractCSS: false,'
  end

  def yarn
    run 'yarn add vuex vue-assign-model lodash.clonedeep'
  end
end

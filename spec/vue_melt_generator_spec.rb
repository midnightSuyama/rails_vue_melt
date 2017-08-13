require 'generator_spec'
require File.expand_path('../../lib/generators/vue_melt/vue_melt_generator', __FILE__)

describe VueMeltGenerator, type: :generator do
  destination File.expand_path("../tmp", __FILE__)

  before :all do
    prepare_destination
    mkdir_p "#{destination_root}/app/views/layouts"
    cp File.expand_path('fixtures/application.html.erb', File.dirname(__FILE__)), "#{destination_root}/app/views/layouts"
    mkdir_p "#{destination_root}/config/webpack/loaders"
    cp File.expand_path('fixtures/vue.js', File.dirname(__FILE__)), "#{destination_root}/config/webpack/loaders"
    run_generator
  end

  after :all do
    rm_rf destination_root
    system 'yarn remove vuex vue-assign-model lodash.clonedeep > /dev/null'
  end

  it 'creates vue_melt' do
    assert_file 'app/javascript/packs/vue_melt/application.js'
    assert_file 'app/javascript/packs/vue_melt/options'
    assert_file 'app/javascript/packs/vue_melt/components'
    assert_file 'app/javascript/packs/vue_melt/store'
  end

  it 'inserts javascript_pack_tag and turbolinks-cache-control' do
    content = File.read("#{destination_root}/app/views/layouts/application.html.erb")
    expect(content).to match(/\s*<%= javascript_pack_tag 'vue_melt\/application' %>\n\s*<meta name="turbolinks-cache-control" content="no-cache">\n\s*<\/head>/)
  end

  it 'changes extractCSS' do
    content = File.read("#{destination_root}/config/webpack/loaders/vue.js")
    expect(content).to match(/extractCSS: false/)
  end

  it 'installs package' do
    assert_file '../../node_modules/vuex'
    assert_file '../../node_modules/vue-assign-model'
    assert_file '../../node_modules/lodash.clonedeep'
  end
end

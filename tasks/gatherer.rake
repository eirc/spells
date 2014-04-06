desc 'Ensure all fixtures of cards from gatherer are available'
task :gatherer => [ 'gatherer:ensure_fixtures' ]

namespace :gatherer do
  desc 'Ensure all fixtures of cards from gatherer are available'
  task :ensure_fixtures => [ :ensure_master_sets_fixtures, :ensure_sets_fixtures ]

  desc 'Ensure the set names fixtures are available'
  task :ensure_master_sets_fixtures do
    unless File.exists? sets_file
      Rake::Task['gatherer:dump_master_sets'].invoke
    end
  end

  desc 'Ensure the set card fixtures for all sets are available'
  task :ensure_sets_fixtures => [ :ensure_master_sets_fixtures ] do
    require 'yaml'
    YAML.load_file(sets_file).each do |set_name|
      unless File.exists? set_file(set_name)
        Rake::Task['gatherer:dump_set'].invoke set_name
      end
    end
  end

  desc 'Dump the set names fixtures file'
  task :dump_master_sets do
    dump_master_sets
  end

  desc 'Dump the set cards fixtures file for given set'
  task :dump_set, :set_name do |task, arguments|
    task.reenable
    dump_set arguments[:set_name]
  end

  def sets_file
    File.expand_path('../../spec/fixtures/gatherer/sets.yml', __FILE__)
  end

  def set_file(set_name)
    basename = set_name.gsub(/\W/, '_').squeeze('_').downcase
    File.expand_path("../../spec/fixtures/gatherer/set-#{basename}.yml", __FILE__)
  end

  def gatherer_sets
    require 'vcr'
    require 'nokogiri'
    require 'open-uri'
    require 'addressable/uri'

    VCR.configure do |c|
      c.cassette_library_dir = File.expand_path('../vcr_cassettes', __FILE__)
      c.hook_into :webmock
    end

    default_url = Addressable::URI.new scheme: 'http',
                                       host: 'gatherer.wizards.com',
                                       path: '/Pages/Default.aspx'

    default_page = VCR.use_cassette('default-page') { open(default_url) }

    Nokogiri::HTML(default_page).
        css('#ctl00_ctl00_MainContent_Content_SearchControls_setAddText option').
        map { |option| option.text }.
        select { |set| !set.empty? }
  end

  def gatherer_cards_from(set)
    require 'vcr'
    require 'nokogiri'
    require 'open-uri'
    require 'addressable/uri'
    require 'spells'

    VCR.configure do |c|
      c.cassette_library_dir = File.expand_path('../vcr_cassettes', __FILE__)
      c.hook_into :webmock
    end

    print "Scraping set: #{set}..."

    set_url = Addressable::URI.new scheme: 'http',
                                   host: 'gatherer.wizards.com',
                                   path: '/Pages/Search/Default.aspx',
                                   query_values: {
                                       output: 'spoiler',
                                       method: 'text',
                                       set: "[\"#{set}\"]"
                                   }

    set_page = VCR.use_cassette("set-page-#{set}") { open(set_url) }
    name_nodes = Nokogiri::HTML(set_page).xpath('//div[@class="textspoiler"]').xpath('//td[contains(text(),"Name")]')

    puts "#{name_nodes.count} cards"

    name_nodes.map do |name_node|
      card = Spells::Card.new
      card.name = name_node.xpath('../td/a').text.strip
      card.text = name_node.xpath('../following-sibling::tr[4]/td[2]').text.strip
      card
    end
  end

  def dump_master_sets
    require 'yaml'
    require 'fileutils'
    FileUtils.mkdir_p File.dirname(sets_file)
    File.open(sets_file, 'w') { |out| YAML.dump(gatherer_sets, out) }
  end

  def dump_set(set_name)
    require 'yaml'
    File.open(set_file(set_name), 'w') { |out| YAML.dump(gatherer_cards_from(set_name), out) }
  end
end

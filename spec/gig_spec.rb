require 'gig'

RSpec.describe Gig do
  before(:all) do
    @gig = Gig.new(['topic:ruby', 'topic:rails'])
    @gig.instance_variable_set('@images_directory', "spec/#{@gig.instance_variable_get('@images_directory')}")
  end

  describe '#initialize' do
    it 'creates a query string with values joined with a plus symbol' do
      expect(@gig.instance_variable_get('@query')).to eq('topic:ruby+topic:rails')
    end

    it 'creates a folder name with values joined with dash symbol' do
      expect(@gig.instance_variable_get('@images_directory')).to eq('spec/topic:ruby-topic:rails')
    end

    it 'creates a url that combines a the GitHub search repsoitory url with the user query' do
      expect(@gig.instance_variable_get('@url')).to eq('https://api.github.com/search/repositories?q=topic:ruby+topic:rails&per_page=100')
    end
  end

  describe '#query_api' do
    before do
      @gig.query_api
    end

    it 'returns a 200 success response from the url' do
      expect(@gig.instance_variable_get('@search_serialized').status).to eq(%w[200 OK])
    end

    it 'builds a hash of search results from the GitHub API which has keys for avatar url' do
      @gig.instance_variable_get('@search_results')['items'].each do |item|
        expect(item['owner']).to have_key('avatar_url')
      end
    end
  end

  describe '#save_images' do
    before do
      @gig.save_images
    end

    it 'creates a directory with the name of the search' do
      expect((File.directory? 'spec/topic:ruby-topic:rails')).to eq(true)
    end

    it 'creates files in the directory' do
      expect(Dir['spec/topic:ruby-topic:rails'].empty?).to eq(false)
    end

    it 'creates files that with the extension .png' do
      Dir.each_child('spec/topic:ruby-topic:rails') do |file|
        expect(file).to match(/.png/) unless file == '.DS_Store'
      end
    end
  end

  after(:all) do
    Dir.foreach('spec/topic:ruby-topic:rails') do |file|
      file_name = File.join('spec/topic:ruby-topic:rails/', file)
      File.delete(file_name) if file != '.' && file != '..'
    end
    Dir.delete('spec/topic:ruby-topic:rails')
  end
end

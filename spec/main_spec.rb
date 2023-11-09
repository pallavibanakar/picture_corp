require './lib/errors/invalid_path_error'
require './main'

RSpec.describe 'Main' do
  describe '#call' do
    subject(:download_images) { Main.new.call(urls, dest_path) }

    context 'with valid parameters' do
      let(:urls) {['https://images.freeimages.com/images/large-previews/56d/peacock-1169961.jpg', 'https://images.freeimages.com/images/large-previews/bc4/curious-bird-1-1374322.jpg']}
      let(:dest_path) {'/tmp'}

      it 'returns the successfully downloaded paths' do
        expect(download_images).to_not be_nil
        expect(download_images).to be_an_instance_of(Array)
        expect(download_images[0].sort).to eql(['/tmp/peacock-1169961.jpg', '/tmp/curious-bird-1-1374322.jpg'].sort)
      end

      it 'has no failed urls' do
        expect(download_images[1]).to eql([])
      end
    end

    context 'with empty urls parameters' do
      let(:urls) {[]}
      let(:dest_path) {'/tmp'}

      it 'returns empty downloaded paths and failed urls' do
        expect(download_images).to_not be_nil
        expect(download_images).to be_an_instance_of(Array)
        expect(download_images[0]).to be_nil
        expect(download_images[1]).to be_nil
      end
    end

    context 'with few invalid urls' do
      let(:urls) {['https://images.freeimages.com/images/large-previews/56d/peacock.jpg', 'https://images.freeimages.com/images/large-previews/bc4/curious-bird-1-1374322.jpg']}
      let(:dest_path) {'/tmp'}

      it 'returns the successfully downloaded paths' do
        expect(download_images).to_not be_nil
        expect(download_images).to be_an_instance_of(Array)
        expect(download_images[0]).to eql(['/tmp/curious-bird-1-1374322.jpg'])
      end

      it 'returns the failed urls' do
        expect(download_images[1]).to eql(['https://images.freeimages.com/images/large-previews/56d/peacock.jpg'])
      end
    end

    context 'with invalid dest path parameters' do
      let(:urls) {['https://images.freeimages.com/images/large-previews/56d/peacock-1169961.jpg', 'https://images.freeimages.com/images/large-previews/bc4/curious-bird-1-1374322.jpg']}
      let(:dest_path) {'downloads'}

      it 'raises invalid dest path error' do
        expect{download_images}.to raise_error(InvalidPathError)
      end
    end
  end
end

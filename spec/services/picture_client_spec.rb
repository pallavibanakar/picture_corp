# frozen_string_literal: true

require_relative '../../services/picture_client'
Dir[File.join('./lib', '**', '*.rb')].each { |file| require file }

RSpec.describe 'PictureClient' do
  describe '#download image' do
    subject(:download_image) { Services::PictureClient.new.download_image(url) }

    context 'with valid url' do
      let(:url) { 'https://images.freeimages.com/images/large-previews/56d/peacock-1169961.jpg' }

      it 'returns the file' do
        expect(download_image).to_not be_nil
        expect(download_image).to be_an_instance_of(File)
      end
    end

    context 'with invalid url' do
      let(:url) { 'https://www.freeimages.com/photo/peacock' }

      it 'raises invalid url error' do
        expect { download_image }.to raise_error(InvalidUrlError)
      end
    end
  end

  describe '#read image' do
    subject(:image_stream) { Services::PictureClient.new.send(:read_image, url) }

    context 'with valid url' do
      let(:url) { 'https://images.freeimages.com/images/large-previews/56d/peacock-1169961.jpg' }

      it 'returns the image stream' do
        expect(image_stream).to_not be_nil
        expect(image_stream).to be_an_instance_of(String)
      end
    end

    context 'with invalid url' do
      let(:url) { 'https://www.freeimages.com/photo/peacock.jpg' }

      it 'raises fetch error' do
        expect { subject }.to raise_error(FetchImageError)
      end
    end
  end
end

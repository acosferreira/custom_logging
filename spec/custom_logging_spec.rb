require 'spec_helper'
require 'custom_logging'
RSpec.describe CustomLogging do
  describe 'simple output' do
    let(:logger_output) { StringIO.new }
    before do
      Timecop.freeze(Time.local(2018, 9, 9, 10, 5, 0))
    end
    after do
      Timecop.return
    end

    context 'Flashing' do
      let(:Flashing) { double }
      before do
        @root = CustomLogging.logger(config:{ service_name: 'ROOT' })
        @flash = CustomLogging.logger(config:{ service_name: 'FLASH' })
      end

      context 'stdout flash and root' do
        it 'info root' do
          @root.info("I'm the root logger")
        end
        it 'error flash' do
          @flash.error("This was a serious error")
        end
        it 'debug flash' do
          @root.debug('Just doing debug messages for ROOT')
        end
      end

      context 'in flash file' do
        let(:flash_output) { StringIO.new }
        let(:Flashing) { double }
        before do
          @flash = CustomLogging.logger(config:{output: flash_output, service_name: 'FLASH' })
        end

        context 'flash file' do
          it 'info root' do
            @flash.info("This info is not visible for ROOT stdout")
            expect(flash_output.string).to include("\e[34m[2018-09-09 10:05:00]INFO [FLASH] : \"This info is not visible for ROOT stdout\"\n")
          end
          it 'error flash' do
            @flash.error("This was a serious error in flashing")
            expect(flash_output.string).to include("\e[31m[2018-09-09 10:05:00]ERROR [FLASH] : \"This was a serious error in flashing\"\n")
          end
          it 'debug flash' do
            @flash.debug('And ROOT knows nothing about the debug stuff')
            expect(flash_output.string).to include("\e[32m[2018-09-09 10:05:00]DEBUG [FLASH] : \"And ROOT knows nothing about the debug stuff\"\n")
          end
        end
      end

      context 'in root file' do
        let(:root_output) { StringIO.new }
        let(:Flashing) { double }
        before do
          @root = CustomLogging.logger(config: {output: 'BOTH', service_name: 'ROOT', filename: 'test' })
          @flash = CustomLogging.logger(config: {service_name: 'flash', has_parent: 'Root', filename: 'test'})
        end

        context 'root file' do
          it 'root' do
            @root.info("I am the root logger")
          end
          it 'flash info on root' do
            @flash.info("This info is not visible for ROOT stdout")
          end
          it 'error flash' do
            @flash.error("This was a serious error in flashing")
          end
          it 'debug flash' do
            @flash.debug('And ROOT knows nothing about the debug stuff')
          end
          it 'debug root' do
            @root.debug('Just doing debug messages for ROOT')
          end
        end

      end
    end

  end
end

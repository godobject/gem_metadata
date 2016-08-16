module GodObject::GemMetadata

  describe Service do
    shared_context 'only one gem was provided at construction' do
      let(:constructor_arguments) { [ gems: gems ] }
      let(:gems) { [gem_specification] }
      let(:gem_specification) { instance_spy(::Gem::Specification, :specification, name: gem_name).as_null_object }
      let(:gem_name) { 'some_gem' }
    end

    shared_context 'two gems were provided at construction' do
      let(:constructor_arguments) { [ gems: gems ] }
      let(:gems) { [first_gem_specification, second_gem_specification] }
      let(:first_gem_specification) { instance_spy(::Gem::Specification, :first_specification, name: first_gem_name).as_null_object }
      let(:first_gem_name) { 'some_gem' }

      let(:second_gem_specification) { instance_spy(::Gem::Specification, :second_specification, name: second_gem_name).as_null_object }
      let(:second_gem_name) { 'other_gem' }
    end

    let(:service) { described_class.new(*constructor_arguments) }

    describe '.new' do
      subject(:method_call) { described_class.new(*arguments) }

      context 'when called without any arguments' do
        let(:arguments) { [] }

        before(:example) { allow(::Gem).to receive(:loaded_specs).and_return({}) }

        it 'acquires the currently loaded gems from Rubygems' do
          expect(::Gem).to receive(:loaded_specs)

          method_call
        end

        it { is_expected.to be_an described_class }
      end

      context 'when called with gems' do
        include_context 'two gems were provided at construction'

        let(:arguments) { [ gems: gems ] }

        it { is_expected.to be_an described_class }
      end
    end

    describe '#find_gems_providing' do
      subject(:method_call) { service.find_gems_providing(*arguments) }

      context 'when called without any arguments' do
        include_context 'only one gem was provided at construction'

        let(:arguments) { [] }

        specify { expect { method_call }.to raise_error ArgumentError, /wrong number of arguments/ }
      end

      context 'when called with a metadata key' do
        let(:arguments) { [metadata_key] }
        let(:metadata_key) { 'some key' }

        context 'in case only one gem that does not contain metadata was provided at construction' do
          include_context 'only one gem was provided at construction'

          let(:metadata) { {} }

          before(:example) do
            allow(gem_specification).to receive(:metadata).and_return(metadata)
          end

          it 'requests the metadata from the gem specification' do
            method_call

            expect(gem_specification).to have_received(:metadata).with(no_args)
          end

          it { is_expected.to eq [] }
        end

        context 'in case only one gem that does contain non-matching metadata was provided at construction' do
          include_context 'only one gem was provided at construction'

          let(:metadata) do
            { 'other key' => '' }
          end

          before(:example) do
            allow(gem_specification).to receive(:metadata).and_return(metadata)
          end

          it 'requests the metadata from the gem specification' do
            method_call

            expect(gem_specification).to have_received(:metadata).with(no_args)
          end

          it { is_expected.to eq [] }
        end

        context 'in case only one gem that does contain matching metadata was provided at construction' do
          include_context 'only one gem was provided at construction'

          let(:metadata) do
            { metadata_key => '' }
          end

          before(:example) do
            allow(gem_specification).to receive(:metadata).and_return(metadata)
          end

          it 'requests the metadata from the gem specification' do
            method_call

            expect(gem_specification).to have_received(:metadata).with(no_args)
          end

          it { is_expected.to be_an Array }
          it { is_expected.to have(1).item }

          describe 'first item' do
            subject(:item) { method_call[0] }

            it 'is the gem specification' do
              expect(item).to be gem_specification
            end
          end
        end

        context 'in case one gem containg metadata and one without were provided at construction' do
          include_context 'two gems were provided at construction'

          let(:first_metadata) { {} }
          let(:second_metadata) do
            { metadata_key => '' }
          end

          before(:example) do
            allow(first_gem_specification).to receive(:metadata).and_return(first_metadata)
            allow(second_gem_specification).to receive(:metadata).and_return(second_metadata)
          end

          it 'requests the metadata from the first gem specification' do
            method_call

            expect(first_gem_specification).to have_received(:metadata).with(no_args)
          end

          it 'requests the metadata from the second gem specification' do
            method_call

            expect(second_gem_specification).to have_received(:metadata).with(no_args)
          end

          it { is_expected.to be_an Array }
          it { is_expected.to have(1).item }

          describe 'first item' do
            subject(:item) { method_call[0] }

            it 'is the second gem specification' do
              expect(item).to be second_gem_specification
            end
          end
        end

        context 'in case two gems containg matching metadata were provided at construction' do
          include_context 'two gems were provided at construction'

          let(:first_metadata) do
            { metadata_key => '' }
          end

          let(:second_metadata) do
            { metadata_key => '' }
          end

          before(:example) do
            allow(first_gem_specification).to receive(:metadata).and_return(first_metadata)
            allow(second_gem_specification).to receive(:metadata).and_return(second_metadata)
          end

          it 'requests the metadata from the first gem specification' do
            method_call

            expect(first_gem_specification).to have_received(:metadata).with(no_args)
          end

          it 'requests the metadata from the second gem specification' do
            method_call

            expect(second_gem_specification).to have_received(:metadata).with(no_args)
          end

          it { is_expected.to be_an Array }
          it { is_expected.to have(2).item }

          describe 'first item' do
            subject(:item) { method_call[0] }

            it 'is the first gem specification' do
              expect(item).to be first_gem_specification
            end
          end

          describe 'second item' do
            subject(:item) { method_call[1] }

            it 'is the second gem specification' do
              expect(item).to be second_gem_specification
            end
          end
        end
      end
    end
  end

end

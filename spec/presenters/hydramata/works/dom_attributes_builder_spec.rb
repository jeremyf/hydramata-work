require 'spec_fast_helper'
require 'hydramata/works/dom_attributes_builder'

module Hydramata
  module Works
    describe DomAttributesBuilder do
      let(:context) { double }

      it 'appends attributes' do
        response = described_class.call(context, { class: ['hello'] }, { class: ['world'] } )
        expect(response).to eq({ class: ['hello', 'world'] })
      end

      it 'handles mixed array and string' do
        response = described_class.call(context, { class: 'hello' }, { class: ['world'] } )
        expect(response).to eq({ class: ['hello', 'world'] })
      end

      it 'adds new keys to returned value' do
        response = described_class.call(context, { data_attribute: ['hello'] }, { class: ['world'] } )
        expect(response).to eq({ data_attribute: ['hello'], class: ['world'] })
      end

    end
  end
end
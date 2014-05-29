require 'fast_helper'
require 'hydramata/work/presentation_structure'

module Hydramata
  module Work
    describe PresentationStructure do
      subject { described_class.new }
      let(:fieldset) { [:required, [:title]] }
      it 'can be appended' do
        expect {
          subject.fieldsets << fieldset
        }.to change { subject.fieldsets.count }.by(1)
      end

    end
  end
end

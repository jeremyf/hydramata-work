require 'spec_fast_helper'
require 'hydramata/works/action_set'

module Hydramata
  module Works
    describe ActionSet do
      let(:action_builder) { ->(arg) { arg } }
      let(:context) { double('Context') }
      subject { described_class.new(context: context, action_builder: action_builder) }

      it 'overwrites an existing action by action name' do
        subject << { name: :create, type: :submit }
        subject << { name: :cancel, type: :link }
        subject << { name: :create, type: :link }

        submit_action = action_builder.call(name: :create, type: :link, context: context)
        cancel_action = action_builder.call(name: :cancel, type: :link, context: context)
        expect { |b| subject.each(&b) }.to yield_successive_args(submit_action, cancel_action)
      end
    end
  end
end

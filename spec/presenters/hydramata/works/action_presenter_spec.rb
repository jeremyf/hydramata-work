require 'spec_fast_helper'
require 'hydramata/works/action_presenter'

module Hydramata
  module Works
    describe ActionPresenter do
      let(:context) { double('Context', to_param: '1234') }
      let(:template) { double('Template', submit_tag: true) }
      subject { described_class.new(context: context, name: name) }

      context '#render' do
        let(:name) { :create }
        context 'for :submit type' do
          it 'renders a submit tag' do
            expect(context).to receive(:translate).
              with("actions.#{name}.label", default: 'Save changes').
              and_return('Translated')
            expect(context).to receive(:translate).
              with("actions.#{name}.type", default: 'link').
              and_return('submit')
            expect(context).to receive(:translate).
              with("actions.#{name}.dom_class", default: 'named-action action-create').
              and_return('named-action action-create')
            expect(template).to receive(:submit_tag).
              with('Translated', data: true, class: ['twonky', 'named-action action-create']).
              and_return('My Submit Tag')
            expect(subject.render(template, data: true, class: 'twonky')).to eq('My Submit Tag')
          end
        end

        context 'for :link type' do
          let(:name) { :edit }
          it 'renders an a-tag' do
            expect(context).to receive(:translate).
              with("actions.#{name}.label", default: 'Save changes').
              and_return('Edit this Work')
            expect(context).to receive(:translate).
              with("actions.#{name}.type", default: 'link').
              and_return('link')
            expect(context).to receive(:translate).
              with("actions.#{name}.dom_class", default: 'named-action action-edit').
              and_return('named-action action-edit')
            expect(context).to receive(:translate).
              with("actions.#{name}.url", raise: true, to_param: context.to_param).
              and_return('my_href')
            expect(template).to receive(:content_tag).
              with('a', 'Edit this Work', href: 'my_href', class: ['otter', 'named-action action-edit']).
              and_return('My Link Tag')
            expect(subject.render(template, class: 'otter')).to eq('My Link Tag')
          end
        end
      end
    end
  end
end

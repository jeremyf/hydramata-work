require 'hydramata/works/base_presenter'
require 'hydramata/works/conversions/translation_key_fragment'

module Hydramata
  module Works
    class WorkTypePresenter < SimpleDelegator
      include Conversions
      def initialize(object, collaborators = {})
        __setobj__(object)
        @translator = collaborators.fetch(:translator) { default_translator }
        @translation_scopes = collaborators.fetch(:translation_scopes) { default_translation_scopes }
      end

      def description(options = {})
        translator.translate('description', options.reverse_merge(scopes: translation_scopes))
      end

      def name(options = {})
        translator.translate('name', options.reverse_merge(scopes: translation_scopes, default: __getobj__.name))
      end

      private
      attr_reader :translator, :translation_scopes
      private :translator, :translation_scopes
      def default_translation_scopes
        [
          ['works', TranslationKeyFragment(self)]
        ]
      end

      def default_translator
        require 'hydramata/core/translator'
        Core::Translator.new(base_scope: ['hydramata', 'core'])
      end
    end
  end
end
require 'hydramata/work/conversions/exceptions'

module Hydramata
  module Work
    module Conversions
      private
      def TranslationKeyFragment(input)
        return input.to_translation_key_fragment.to_s.downcase.gsub(/\W+/, '_') if input.respond_to?(:to_translation_key_fragment)
        return input.name_for_application_usage.to_s.downcase.gsub(/\W+/, '_') if input.respond_to?(:name_for_application_usage)
        case input
        when String, Symbol then input.to_s.downcase.gsub(/\W+/, '_')
        when Hash then
          value = input[:to_translation_key_fragment] ||
            input['to_translation_key_fragment'] ||
            input[:name_for_application_usage] ||
            input['name_for_application_usage']
          TranslationKeyFragment(value)
        else
          raise ConversionError.new(:TranslationKeyFragment, input)
        end
      end
    end
  end
end
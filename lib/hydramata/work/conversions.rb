require 'hydramata/work/property'

module Hydramata
  module Work
    # Taking a que from Avdi Grimm's "Confident Ruby", the Conversion module
    # is responsible for coercing the inputs to another format.
    #
    # This is somewhat experimental, though analogous to the Array() method in
    # base ruby.
    module Conversions
      private

      def Property(input)
        if input.instance_of?(Property)
          input
        else
          Property.new(input)
        end
      end

      def PresentedFieldsets(collaborators)
        # @TODO - This could be packaged up into a tidier location.
        # The collaboration with an entity's PropertySet#subset is convoluted.
        # I also don't know if I need.
        entity = collaborators.fetch(:entity)
        presentation_structure = collaborators.fetch(:presentation_structure)
        presentation_structure.fieldsets.each_with_object([]) do |(fieldset_name, predicates), collector|
          fieldset = PropertySet.new(name: fieldset_name)
          property_builder = ->(pr) { PropertyPresenter.new(property: pr, fieldset: fieldset, entity: entity) }
          entity.properties.subset(predicates, fieldset, property_builder)
          presented_fieldset = FieldsetPresenter.new(entity: entity, fieldset: fieldset)
          collector << presented_fieldset
        end
      end
    end
  end
end

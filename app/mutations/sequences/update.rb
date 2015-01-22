module Sequences
  class Update < Mutations::Command
    using MongoidRefinements

    required do
      model :user, class: User
      model :sequence, class: Sequence
    end

    optional do
      string :name
      string :color, in: Sequence::COLORS
    end

    def validate
      raise Errors::Forbidden unless sequence.user == user
    end

    def execute
      update_attributes(sequence, inputs.except(:user, :sequence, :_id))
    end
  end
end

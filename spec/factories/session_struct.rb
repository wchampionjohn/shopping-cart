FactoryBot.define do
  factory :session_struct, class: Array do
    initialize_with {
      [
        OpenStruct.new({id: 2, quantity: 3, product: {}}),
        OpenStruct.new({id: 5, quantity: 4, product: {}})
      ]
    }
  end
end

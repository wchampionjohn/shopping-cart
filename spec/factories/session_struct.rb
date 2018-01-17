FactoryBot.define do
  factory :session_struct, class: Array do
    initialize_with {
      [
        OpenStruct.new({key: '2', id: '2', quantity: 3, product: {}}),
        OpenStruct.new({key: '5', id: '5', quantity: 4, product: {}})
      ]
    }
  end
end

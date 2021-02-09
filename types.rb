module Types
  class Address < GraphQL::Schema::Object
    field :street, String, null: false
    field :zip, String, null: false
  end

  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, "", null: false
    field :email, String, "", null: false
    field :address, Address, null: true
  end
end

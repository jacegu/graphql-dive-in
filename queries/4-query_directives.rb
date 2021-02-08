require 'graphql'

class User
  attr_reader :id, :name, :email, :address

  def initialize(id:, name:, email:, address:)
    @id = id
    @name = name
    @email = email
    @address = address
  end
end

class Address
  attr_reader :street, :zip

  def initialize(street:, zip:)
    @street = street
    @zip = zip
  end
end

USERS = {
  1 => User.new(id: 1, name: "john", email: "john@email.com", address: Address.new(street: "Main st. 1, 6C", zip: "12345")),
  2 => User.new(id: 2, name: "jane", email: "jane@email.com", address: nil),
  3 => User.new(id: 3, name: "chita", email: "chita@email.com", address: Address.new(street: "Mira el sol 26, 3B", zip: "28005")),
}

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

class QueryType < GraphQL::Schema::Object
  field :users, [Types::User], null: false do
    description "Users in the system"
    argument :id, ID, required: true
  end

  def users(id:)
    Array(USERS[id.to_i])
  end
end

class Schema < GraphQL::Schema
  query QueryType
end

query_string = <<~QUERY
query UserProfile($id: ID!, $includeAddress: Boolean = false) {
  users(id: $id) {
    id
    name
    email
    address @include(if: $includeAddress) {
      street
      zip
    }
  }
}
QUERY

puts JSON.pretty_generate(Schema.execute(query_string, variables: { id: 3, includeAddress: true }))

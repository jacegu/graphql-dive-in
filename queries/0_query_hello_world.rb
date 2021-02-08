require 'graphql'

class User
  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end
end

USERS = {
  1 => User.new(id: 1, name: "john", email: "foo@bar.com")
}

module Types
  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, "John Doe", null: false
    field :email, String, "John Doe", null: false
  end
end


class QueryType < GraphQL::Schema::Object

  field :user, Types::User, null: true do
    description "Find a user by ID"
    argument :id, ID, required: true
  end

  def user(id:)
    USERS[id.to_i]
  end
end

class Schema < GraphQL::Schema
  query QueryType
end

query_string = <<~QUERY
{
  user(id: 1) {
    name
    email
  }
}
QUERY

pp Schema.execute(query_string).to_json

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
  1 => User.new(id: 1, name: "john", email: "john@email.com"),
  2 => User.new(id: 2, name: "jane", email: "jane@email.com"),
  3 => User.new(id: 3, name: "chita", email: "chita@email.com"),
}

module Types
  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, "", null: false
    field :email, String, "", null: false
  end
end

class QueryType < GraphQL::Schema::Object
  field :users, [Types::User], null: false do
    description "Users in the system"
    argument :email, String, required: false
  end

  def users(email: nil)
    USERS.values.select { |u| u.email.include?(email) }
  end
end

class Schema < GraphQL::Schema
  query QueryType
end

query_string = <<~QUERY
query {
  john: users(email: "john") {
    ...userData
  }
  jane: users(email: "jane") {
    ...userData
  }
}

fragment userData on User {
  id
  name
  email
}
QUERY

pp Schema.execute(query_string).to_json

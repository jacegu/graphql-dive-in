require 'graphql'
require_relative 'data'
require_relative 'types'

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

puts JSON.pretty_generate(Schema.execute(query_string))

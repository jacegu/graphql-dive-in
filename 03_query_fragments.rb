require 'graphql'
require_relative 'data'
require_relative 'types'

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

puts JSON.pretty_generate(Schema.execute(query_string))

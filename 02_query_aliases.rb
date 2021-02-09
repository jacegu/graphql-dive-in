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
  usersWithAtEmailCom: users(email: "email.com") {
    id
    name
    email
  }
  john: users(email: "john") {
    id
  }
}
QUERY

puts JSON.pretty_generate(Schema.execute(query_string))

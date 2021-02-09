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

query_string_with_defaults = <<~QUERY
query EmailSearch($email: String = "@email.com") {
  users(email: $email) {
    id
    name
    email
  }
}
QUERY

query_string_with_mandatory_variable = <<~QUERY
query EmailSearch($email: String!) {
  users(email: $email) {
    id
    name
    email
  }
}
QUERY


puts "WITH DEFAULTS"
puts JSON.pretty_generate(Schema.execute(query_string_with_defaults))
puts
puts "WITH MANDATORY VARIABLE"
puts JSON.pretty_generate(Schema.execute(query_string_with_mandatory_variable, variables: { email: "jane" }))

require 'graphql'
require_relative 'data'
require_relative 'types'

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
query UserProfile($id: ID!, $skipId: Boolean = true, $includeAddress: Boolean = false) {
  users(id: $id) {
    id @skip(if: $skipId)
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

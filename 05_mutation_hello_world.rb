require 'graphql'
require_relative 'data'
require_relative 'types'

class AddUser < GraphQL::Schema::Mutation
  description "Adds a new user to the system"
  argument :name, String, required: true
  argument :email, String, required: true

  field :id, ID, null: false

  def resolve(name:, email:)
    new_id = USERS.keys.last.succ
    USERS[new_id] = User.new(id: new_id, name: name, email: email, address: nil)
  end
end

class Mutations < GraphQL::Schema::Object
  field :add_user, mutation: AddUser
end

class Schema < GraphQL::Schema
  mutation Mutations
end



mutation_string = <<~QUERY
mutation($name: String!, $email: String!) {
  addUser(name: $name, email: $email) {
    id
  }
}
QUERY

puts JSON.pretty_generate(Schema.execute(mutation_string, variables: { name: "Peter", email: "peter@email.com" }))

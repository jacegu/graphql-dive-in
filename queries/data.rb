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
  1 => User.new(
    id: 1,
    name: "john",
    email: "john@email.com",
    address: Address.new(
      street: "Main st. 1, 6C",
      zip: "12345"
    )
  ),
  2 => User.new(
    id: 2,
    name: "jane",
    email: "jane@email.com",
    address: nil
  ),
  3 => User.new(
    id: 3,
    name: "chita",
    email: "chita@email.com",
    address: Address.new(
      street: "Mira el sol 26, 3B",
      zip: "28005"
    )
  ),
}

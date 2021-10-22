require 'rails_helper'

RSpec.describe Types::UserType do
  set_graphql_type

  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    expect(subject).to have_field(:id).of_type(!types.ID)
  end

  it 'has a :name field of String type' do
    expect(subject).to have_field(:name).that_returns(types.String)
  end

  it 'has a :vehicle field of Boolean type' do
    expect(subject).to have_field(:vehicle).that_returns(types.String)
  end
end

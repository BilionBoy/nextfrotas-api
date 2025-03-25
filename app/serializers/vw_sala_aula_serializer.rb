# app/serializers/vw_sala_aula_serializer.rb
class VwSalaAulaSerializer < ActiveModel::Serializer
  attributes :escola, :cre, :capacidade, :id
end

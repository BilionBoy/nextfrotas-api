# app/serializers/vw_sala_aula_serializer.rb
class VwSalaAulaSerializer < ActiveModel::Serializer
  attributes :escola, :cre, :capacidade, :tipo_ambiente_predial, :id
end

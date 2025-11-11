# frozen_string_literal: true

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular "c_posto",                  "c_postos"
  inflect.irregular "c_combustivel",            "c_combustiveis"
  inflect.irregular "c_tipo_combustivel",       "c_tipos_combustiveis"
  inflect.irregular "c_requisicao_combustivel", "c_requisicoes_combustiveis"
  inflect.irregular "g_veiculo",                "g_veiculos"
  inflect.irregular "g_condutor",               "g_condutores"
  inflect.irregular "g_centro_custo",           "g_centros_custos"
  inflect.irregular "o_status",                 "o_status"

end

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular "vw_analise_nutricional", "vw_analises_nutricionais"
  inflect.irregular "vw_funcao",              "vw_funcoes"
  inflect.irregular "vw_escola_em_atividade", "vw_escolas_em_atividade"
  inflect.irregular "vw_sala_aula",           "vw_salas_aula"
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end

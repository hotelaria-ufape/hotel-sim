class ClienteSearchService
  def self.search(attribute, search)
    case attribute
    when "nome"
      Cliente.where('UPPER(nome) LIKE ?', "%#{search.upcase}%")
    when "cpf"
      formatted_search = search.gsub(/\D/, '')
      formatted_search_with_dash = "#{formatted_search[0..2]}.#{formatted_search[3..5]}.#{formatted_search[6..8]}-#{formatted_search[9..10]}"
      Cliente.where('cpf LIKE ? OR REPLACE(cpf, ".", "") LIKE ?', "%#{formatted_search_with_dash}%", "%#{formatted_search}%")
    when "email"
      Cliente.where('UPPER(email) LIKE ?', "%#{search.upcase}%")
    else
      Cliente.all
    end
  end
end

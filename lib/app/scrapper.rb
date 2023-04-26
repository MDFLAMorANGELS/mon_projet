
class Emails_Val_D_Oise
    def get_ville
    region_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
    return ville_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }
    end

    def get_email (ville_names)
        ville_email_array = []
        # Boucle sur chaque ville du tableau pour obtenir l'e-mail
        for n in 0...ville_names.length
            ville_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/#{ville_names[n]}.html"))
            ville_email_array << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s
        end
        return ville_email_array 
    end

    def save_as_json(email_ville_result)
        File.open("./db/emails.json","w") do |f|
        f.write(email_ville_result.to_json)
        end
    end


    def save_as_csv(email_ville_result)
        CSV.open("./db/emails.csv", "a+") do |csv|
        csv << email_ville_result.keys
        csv << email_ville_result.values
        end
    end

    def perform
        ville_names = get_ville
        email_ville_result = Hash[get_ville.zip(get_email(get_ville))]
        save_as_json(email_ville_result)
        save_as_csv(email_ville_result)
    end
end

# TRAVAILLE DE LILIAN

# require 'nokogiri'
# require 'open-uri'

# def get_ville

#   region_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

#   return ville_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }

# end

# def get_email (ville_names)

#   ville_email_array = []

#   # Boucle sur chaque ville du tableau pour obtenir l'e-mail
#   for n in 0...ville_names.length

#     ville_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/#{ville_names[n]}.html"))

#     ville_email_array << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s

#   end

#   return ville_email_array
# end

# puts email_ville_result = Hash[get_ville.zip(get_email(get_ville))]
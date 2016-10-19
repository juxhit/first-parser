require 'open-uri'
require 'nokogiri'
require 'json'
require 'unicode'

url = 'http://www.rbc.ru/rbc500/'
html = open(url)

# doc = File.open("rbc.html") { |f| Nokogiri::HTML(f) }
# doc.encoding = 'utf-8'

doc = Nokogiri::HTML(html)

companies = []
doc.css('.companies-rating__row').each do |company|
  company_id = company.search('.companies-rating__position').text
  # link = company['href'].to_s
  name = company.search('.companies-rating__name').xpath('text()')
  city = company.search('.companies-rating__city').text
  spec = company.search('.companies-rating__spec-name').text

  net_gain_el = company.search('.companies-rating__netgain')
  # net_chart_year = net_gain_el.search('.companies-rating__chart-year__item').to_a.join(" / ")
  net_gain = net_gain_el.search('.companies-rating__number').to_a.join(" ; ")
  # nat_rat_all = net_gain_el.css('.companies-rating__up, .companies-rating__down').to_a.join(" / ")

  rating_pro_el = company.search('.companies-rating__proff')
  # rating_chart_year = rating_pro_el.search('.companies-rating__chart-year__item').to_a.join(" / ")
  rating_gain = rating_pro_el.search('.companies-rating__number').to_a.join(" ; ")
  # rating_rat_all = rating_pro_el.css('.companies-rating__up, .companies-rating__down').to_a.join(" / ")

  # tags = company.css('.tags a').map { |tag| tag.text.strip }
  # title_el = company.at_css('h1 a')
  # title_el.children.each { |c| c.remove if c.name == 'span' }
  # title = title_el.text.strip
  # dates = company.at_css('.start_and_pricing').inner_html.strip
  # dates = dates.split('<br>').map(&:strip).map { |d| DateTime.parse(d) }
  # description = company.at_css('.copy').text.gsub('[more...]', '').strip
  companies.push(
    id: company_id,
    name: name,
    city: city,
    spec: spec,
    # net_chart_year: net_chart_year,
    net_gain: net_gain,
    # nat_rat_all: nat_rat_all,
    # rating_chart_year: rating_chart_year,
    rating_gain: rating_gain,
    # rating_rat_all: rating_rat_all,


    # title: title,
    # tags: tags,
    # dates: dates,
    # description: description,

    # link: link
  )
end

puts JSON.pretty_generate(companies)

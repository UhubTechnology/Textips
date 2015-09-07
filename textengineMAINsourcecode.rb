require 'rss'
require 'open-uri'
require 'uri'
require 'json'
require 'rest-client'
require 'net/http'

def fetch_movies(mquery)
murl = 'http://www.fandango.com/rss/moviesnearme_'
moviesurl = murl + "" + mquery.gsub("movies ","").gsub("Movies ","") + ".rss"
movurl = URI.encode(moviesurl)
mresponse = RestClient.get movurl
feed = RSS::Parser.parse(mresponse)
info = feed.channel.items[0..1]
theater_info = ""
info.each do |t|
theater_info = "#{theater_info} #{t.title} is playing: "
stuff = t.description.split('</a>')
movies = ""
stuff.each do |m|
if stuff.index(m) != (stuff.length - 1)
if stuff.index(m) == 0
movies ="#{m.split('>')[m.split('>').length - 1]}"
else
movies ="#{movies}, #{m.split('>')[m.split('>').length - 1]}"
end
end
end
movies = movies.gsub(", Search other theaters", "")
theater_info = "#{theater_info} #{movies}."
end
return theater_info
end

def fetch_stock(searchquery)
furl = 'http://www.nasdaq.com/aspxcontent/NasdaqRSS.aspx?data=quotes&symbol=' + searchquery.gsub("$Stock ","").gsub("$stock ","").gsub("$Stocks ","").gsub("$stocks ","")
rss = RSS::Parser.parse(furl, false)
rss.items.each do |item|
result = "#{item.description.gsub!("&nbsp;", "")}"
cleaned = ""
result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub(/<\/?[^>]+>/, '').gsub(/\s+/, "").gsub("Last"," Price (USD): ").gsub("Change"," Change: ").gsub("%Change"," %Chgange: ").gsub("Volume"," Volume: ").gsub("Asof:"," As of: ").gsub("View:StockQuote|","").gsub("News","").gsub("2014","2014 ").gsub("EST", " EST")
end
end

def fetch_google(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][0]["snippet"]}; #{searchq_data["items"][2]["snippet"]}; #{searchq_data["items"][4]["snippet"]}; #{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_wiki(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&googlehost=google.com&lr=lang_en&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][0]["snippet"]}; #{searchq_data["items"][2]["snippet"]}; #{searchq_data["items"][3]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end


def fetch_googlefr(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&googlehost=google.fr&lr=lang_fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_googlees(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&googlehost=google.es&lr=lang_es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_googlept(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&lr=lang_pt&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_definefr(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&googlehost=google.fr&lr=lang_fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_definees(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&l&cx=002811237597949708617:yc-grkpdxou&googlehost=google.es&lr=lang_es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

def fetch_define(searchquery)
define_url = 'http://readability.com/api/content/v1/parser?token=3350b34c61f1ecdcd3fcd5ea0a95f8e64e71b604&url=https://www.google.com/search?q='
  query = "" + searchquery
  url = URI.encode(define_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["excerpt"][15..180]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub(/\d\s?/, "").gsub("noun"," noun: ").gsub("verb"," verb: ").gsub("adjective"," adjective: ").gsub("adverb"," adverb: ").gsub("preposition"," preposition: ").gsub("s/","").gsub("259","").gsub("#x","").gsub("r#x","").gsub("l/","").gsub("(","").gsub(")","").gsub("Arrival"," Arrival ").gsub("Gate"," Gate").gsub("departs"," departs").gsub("On-time"," On-time").gsub(";"," ").gsub("Departure"," from ").gsub("&","").gsub("hellip","").gsub("#x2014","").gsub("#x200E","").gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_flight(searchquery)
flight_url = 'http://readability.com/api/content/v1/parser?token=3350b34c61f1ecdcd3fcd5ea0a95f8e64e71b604&url=https://www.google.com/search?q='
  query = "" + searchquery
  url = URI.encode(flight_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["excerpt"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("Dec"," Dec ").gsub("Nov"," Nov ").gsub("Oct"," Oct ").gsub("Sep"," Sep ").gsub("Aug"," Aug ").gsub("Jul"," Jul ").gsub("Jun"," Jun ").gsub("May"," May ").gsub("Apr"," Apr ").gsub("Mar"," Mar ").gsub("Feb"," Feb ").gsub("Jan"," Jan ").gsub("Flight status for","").gsub("Arrival"," Arrival ").gsub("Gate"," Gate").gsub("am","am ").gsub("pm","pm ").gsub("departs"," departs").gsub("On-time"," On-time").gsub(";"," ").gsub("Departure"," from ").gsub("&","").gsub("hellip","").gsub("#x2014","").gsub("#x200E","").gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_time(searchquery)
time_url = 'http://readability.com/api/content/v1/parser?token=3350b34c61f1ecdcd3fcd5ea0a95f8e64e71b604&url=https://www.google.com/search?q='
  query = "" + searchquery
  url = URI.encode(time_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["excerpt"][0..34]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("n=","").gsub("www.timeanddate.com/worldclock/city.html","").gsub("Time and Date","").gsub("Find out current local time in","").gsub("Current local time in","").gsub(";"," ").gsub("#x96","").gsub("#x2014","").gsub("hellip","").gsub("#x200E","").gsub("&","").gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_news(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["responseData"]["results"][0]["content"]}; #{searchq_data["responseData"]["results"][1]["content"]}; #{searchq_data["responseData"]["results"][2]["content"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("&nbsp;","")
end

def fetch_newsfr(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["responseData"]["results"][0]["content"]}; #{searchq_data["responseData"]["results"][1]["content"]}; #{searchq_data["responseData"]["results"][2]["content"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("&nbsp;","")
end

def fetch_newses(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["responseData"]["results"][0]["content"]}; #{searchq_data["responseData"]["results"][1]["content"]}; #{searchq_data["responseData"]["results"][2]["content"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("&nbsp;","")
end

def fetch_newspt(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=pt-BR&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["responseData"]["results"][0]["content"]}; #{searchq_data["responseData"]["results"][1]["content"]}; #{searchq_data["responseData"]["results"][2]["content"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("&nbsp;","")
end

def fetch_headlines(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
searchq_result = "(1) #{searchq_data["responseData"]["results"][0]["title"]} (2) #{searchq_data["responseData"]["results"][1]["title"]} (3) #{searchq_data["responseData"]["results"][2]["title"]} (4) #{searchq_data["responseData"]["results"][3]["title"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_headlinesfr(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
searchq_result = "(1) #{searchq_data["responseData"]["results"][0]["title"]} (2) #{searchq_data["responseData"]["results"][1]["title"]} (3) #{searchq_data["responseData"]["results"][2]["title"]} (4) #{searchq_data["responseData"]["results"][3]["title"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_headlineses(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
searchq_result = "(1) #{searchq_data["responseData"]["results"][0]["title"]} (2) #{searchq_data["responseData"]["results"][1]["title"]} (3) #{searchq_data["responseData"]["results"][2]["title"]} (4) #{searchq_data["responseData"]["results"][3]["title"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

def fetch_headlinespt(searchquery)
google_url = 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&hl=pt-BR&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
searchq_result = "(1) #{searchq_data["responseData"]["results"][0]["title"]} (2) #{searchq_data["responseData"]["results"][1]["title"]} (3) #{searchq_data["responseData"]["results"][2]["title"]} (4) #{searchq_data["responseData"]["results"][3]["title"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

if ($currentCall.initialText[/#Human/] || $currentCall.initialText[/#human/])
event = call "+19084943387", {
   :network => "SMS"}
event.value.say "#{$currentCall.callerID} needs a human response to the following query: #{$currentCall.initialText.gsub("#human","").gsub("#Human","")}. Use Google Voice to reply.";
say "Your query has been sent to a Text Engine operator. Click here to pay $0.25 for your answer: http://s.gnoss.us/te. (They'll respond shortly after payment)";
hangup()

elsif ($currentCall.initialText[/#ondemand/] || $currentCall.initialText[/#Ondemand/])
event = call "+19084943387", {
   :network => "SMS"}
event.value.say "#{$currentCall.callerID} placed an order for: #{$currentCall.initialText.gsub("#ondemand","").gsub("#Ondemand","")}. Use Google Voice to reply.";
say "Your order has been sent to a Text Engine personal assistant. S/he will respond shortly with details.";
hangup()

elsif ($currentCall.initialText[/define/] || $currentCall.initialText[/Define/])
say "#{fetch_define($currentCall.initialText.gsub(" ", "%2B"))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/définir/] || $currentCall.initialText[/Définir/] || $currentCall.initialText[/definir/] || $currentCall.initialText[/Definir/])
say "#{fetch_definefr($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/significar/] || $currentCall.initialText[/Significar/])
say "#{fetch_definees($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/definido/] || $currentCall.initialText[/Definido/])
say "#{fetch_definept($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/web-fr/] || $currentCall.initialText[/Web-fr/])
say "#{fetch_googlefr($currentCall.initialText.gsub(/(web-fr)/i,""))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/web-pt/] || $currentCall.initialText[/Web-pt/])
say "#{fetch_googlept($currentCall.initialText.gsub(/(web-pt)/i,""))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/web-es/] || $currentCall.initialText[/Web-es/])
say "#{fetch_googlept($currentCall.initialText.gsub(/(web-es)/i,""))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif (($currentCall.initialText[/web/] || $currentCall.initialText[/Web/]) && (!$currentCall.initialText[/(web@es)/i] || !$currentCall.initialText[/(web@fr)/i] || !$currentCall.initialText[/(web@pt)/i]))
say "#{fetch_google($currentCall.initialText.gsub(/(web)/i,""))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif (($currentCall.initialText[/\$stock/] || $currentCall.initialText[/\$Stock/]) && (!$currentCall.initialText[/news/] || !$currentCall.initialText[/web/] || !$currentCall.initialText[/wiki/] || !$currentCall.initialText[/News/] || !$currentCall.initialText[/Web/] || !$currentCall.initialText[/Wiki/] || !$currentCall.initialText[/origin&/] || !$currentCall.initialText[/destination&/]))
say "#{fetch_stock($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/airport delay/] || $currentCall.initialText[/Airport delay/] || $currentCall.initialText[/Airport Delay/])
furl = 'http://www.flightstats.com/go/rss/airportdelays.do'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text
say "If you didn't find your airport, visit http://www.airportfact.com/feeds/ for more details."
say "For status of a specific flight, text 'flight [AIRLINE+FLIGHTNUMBER]', e.g., 'flight UA450', or 'flight Delta3722'"
say "For airline phone number, text e.g., 'phone JetBlue'"

elsif (($currentCall.initialText[/what time/] || $currentCall.initialText[/What time/]) && $currentCall.initialText[/in/])
say "#{fetch_time($currentCall.initialText.gsub("in","").gsub("What","").gsub("what","").gsub(",","%2B").gsub(" ", "%2B"))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif (($currentCall.initialText[/flight/] || $currentCall.initialText[/Flight/])  && $currentCall.initialText[/\d{1}/])
say "#{fetch_flight($currentCall.initialText.gsub(" ","%2B"))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 
say "Didn't get the info you wanted? Try using, e.g., 'flight AA450' instead of ' American Airlines flight 450', or 'flight NWA88' instead of 'Northwest flight 88'" 
say "If you found the airline info but need the phone number, text something like 'phone United Airlines Newark NJ'"

elsif ($currentCall.initialText[/irections/] && ($currentCall.initialText[/to/] || $currentCall.initialText[/from/]))
say "For directions, enter  'origin=address1&destination=address2'. Don't insert spaces between the '=' or '&' signs. Don't use zipcode, use city,state"; say "The words 'origin' and 'destination' must be all lowercase."; say "NOTE: Long distances can return a lot of texts. Msg&Data rates may apply."

elsif ($currentCall.initialText[/\d{5}/] && (!$currentCall.initialText[/Origin/] && !$currentCall.initialText[/origin/] && !$currentCall.initialText[/weather/] && !$currentCall.initialText[/Weather/] && !$currentCall.initialText[/estination/]  && !$currentCall.initialText[/movies/]  && !$currentCall.initialText[/Movies/]))
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'"
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}";

elsif ($currentCall.initialText[/([a-zA-Z]\d[a-zA-z]( )?\d[a-zA-Z]\d)/] && (!$currentCall.initialText[/Origin/] && !$currentCall.initialText[/origin/] && !$currentCall.initialText[/weather/] && !$currentCall.initialText[/Weather/] && !$currentCall.initialText[/estination/]  && !$currentCall.initialText[/movies/]  && !$currentCall.initialText[/Movies/]))
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'"
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}";

elsif ($currentCall.initialText[/phone/] || $currentCall.initialText[/Phone/])
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'";
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say  "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say  "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}"; say "Not what you're looking for? Try: 'web #{$currentCall.initialText}'";

elsif ($currentCall.initialText[/address/] || $currentCall.initialText[/Address/])
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'";
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=AIzaSyCnoQMMus8nEs6hn6tAJJgIj01FDCrBw-A&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say  "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say  "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}";

elsif(($currentCall.initialText[/wiki/] || $currentCall.initialText[/Wiki/]) && (!$currentCall.initialText[/(wiki@es)i/] || !$currentCall.initialText[/(wiki@fr)/i] || !$currentCall.initialText[/(wiki@pt)/i]))
say "#{fetch_wiki($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText == "News" || $currentCall.initialText == "news" || $currentCall.initialText[/news headlines/] || $currentCall.initialText[/News headlines/])
say "Today's Headlines:"; say "#{fetch_headlines($currentCall.initialText)}"; say "For more detail on a story, text 'news + headline'"

elsif ($currentCall.initialText[/News.[^ ]/] || $currentCall.initialText[/news.[^ ]/])
say "Recent news about #{$currentCall.initialText.gsub("news ","").gsub("News ","")}:"; 
say "#{fetch_news($currentCall.initialText.gsub("news","").gsub("News",""))}";

elsif ($currentCall.initialText == "Nouvelles" || $currentCall.initialText == "nouvelles")
say "les titres d'aujourd'hui:"; say "#{fetch_headlinesfr($currentCall.initialText)}"; say "Pour plus de détails sur une histoire, texte 'nouvelles + TITRE'"

elsif ($currentCall.initialText[/Nouvelles.[^ ]/] || $currentCall.initialText[/nouvelles.[^ ]/])
say "Nouvelles récentes sur les #{$currentCall.initialText.gsub("nouvelles ","").gsub("Nouvelles ","")}:"; 
say "#{fetch_newsfr($currentCall.initialText.gsub("Nouvelles","").gsub("nouvelles",""))}";

elsif ($currentCall.initialText == "Noticias" || $currentCall.initialText == "noticias")
say "Los titulares de hoy:"; say "#{fetch_headlineses($currentCall.initialText)}"; say "Para más detalles sobre la historia, 'noticias + titular' texto"

elsif ($currentCall.initialText[/Noticias.[^ ]/] || $currentCall.initialText[/noticias.[^ ]/])
say "Noticias recientes sobre #{$currentCall.initialText.gsub("noticias ","").gsub("Noticias ","")}:"; 
say "#{fetch_newses($currentCall.initialText.gsub("Noticias","").gsub("noticias",""))}";

elsif ($currentCall.initialText == "Novidades" || $currentCall.initialText == "novidades")
say "Manchetes de hoje:"; say "#{fetch_headlinespt($currentCall.initialText)}"; say "Para mais detalhes sobre esta história, 'news + manchete' texto"

elsif ($currentCall.initialText[/Novidades.[^ ]/] || $currentCall.initialText[/novidades.[^ ]/])
say "Notícias recentes sobre #{$currentCall.initialText.gsub("novidades ","").gsub("Novidades ","")}:"; 
say "#{fetch_newspt($currentCall.initialText.gsub("Novidades","").gsub("novidades",""))}";

elsif (($currentCall.initialText[/movies/] || $currentCall.initialText[/Movies/]) && !$currentCall.initialText[/\d{5}/])
say "For what's playing near you, enter 'movies zipcode'. e.g., 'movies 07921'. For info on a particular movie, enter: 'wiki + movietitle'. e.g., 'wiki furious 6'. For phone of local theater, enter 'phone theatername city, state', e.g., 'phone cinemark Lodi nj'"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; say "For something else try: 'web #{$currentCall.initialText}'"; log "ttttttttttttt #{$currentCall.initialText}"

elsif (($currentCall.initialText[/movies/] || $currentCall.initialText[/Movies/]) && $currentCall.initialText[/\d{5}/])
say "#{fetch_movies($currentCall.initialText)}"
say "Reply 'phone #{$currentCall.initialText}' for movie theater phone & address"
say "For more info on a particular movie, use the Wiki command, e.g., 'Wiki [MOVIETITLE] (film)'"
log "ttttttttttttt #{$currentCall.initialText}"

elsif ($currentCall.initialText[/irections/] && ($currentCall.initialText[/to/] || $currentCall.initialText[/from/]))
say "For directions, enter  'origin=address1&destination=address2'. Don't insert spaces between the '=' or '&' signs. Use city, state instead of zip"; say "NOTE: Long distances can return a lot of texts. Msg&Data rates may apply.";

#elsif($currentCall.initialText[/Origin/] || $currentCall.initialText[/Destination/])
#say "The words 'Origin' and 'Destination' must be all lowercase. Please try again."

elsif($currentCall.initialText[/rigin=/] && $currentCall.initialText[/estination=/])
log "ttttttttttttt #{$currentCall.initialText}"
incr = 1
directions_url = 'http://maps.googleapis.com/maps/api/directions/json?sensor=false&'
durl = URI.encode(directions_url + "" + $currentCall.initialText.gsub("O","o").gsub("D","d"))
dinfo = JSON.parse(RestClient.get durl)
dinfo['routes'][0]['legs'][0]['steps'].each do |step|
  say "Step #{incr} - Distance #{step['distance']['text']}, Duration #{step['duration']['text']}, Description #{step['html_instructions'].gsub('<b>','').gsub('</b>','').gsub('</div>','').gsub('<div style="font-size:0.9em">','')}"
  incr += 1
end

elsif ($currentCall.initialText[/([a-zA-Z]\d[a-zA-z]( )?\d[a-zA-Z]\d)/] && ($currentCall.initialText[/weather/] || $currentCall.initialText[/Weather/]))
weather_url = "http://api.wunderground.com/api/50085c7dadfca6a0/forecast/q/"
urlq = URI.encode(weather_url + "" + $currentCall.initialText.gsub("Weather ","").gsub("weather ","") + ".json")
uri = URI(urlq)
info = Net::HTTP.get(uri)
forecast = JSON.parse(info)
say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/\d{5}/] && ($currentCall.initialText[/weather/] || $currentCall.initialText[/Weather/]))
weather_url = "http://api.wunderground.com/api/50085c7dadfca6a0/forecast/q/"
urlq = URI.encode(weather_url + "" + $currentCall.initialText.gsub("Weather ","").gsub("weather ","") + ".json")
uri = URI(urlq)
info = Net::HTTP.get(uri)
forecast = JSON.parse(info)
say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText == "Scores" || $currentCall.initialText == "scores")
say "To get scores, text e.g., 'scores MLB' for Major League Baseball"

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NHL/] || $currentCall.initialText[/Nhl/] || $currentCall.initialText[/nhl/]))
furl = 'http://www.gnosisarts.com/nhl.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items[0..2].each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/MLB/] || $currentCall.initialText[/Mlb/] || $currentCall.initialText[/mlb/]))
furl = 'http://www.gnosisarts.com/mlb.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NBA/] || $currentCall.initialText[/Nba/] || $currentCall.initialText[/nba/]))
furl = 'http://www.gnosisarts.com/nba.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NFL/] || $currentCall.initialText[/Nfl/] || $currentCall.initialText[/nfl/]))
furl = 'http://www.gnosisarts.com/nfl.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NCAA/] || $currentCall.initialText[/Ncaa/] || $currentCall.initialText[/ncaa/]))
furl = 'http://www.gnosisarts.com/ncaa.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif ($currentCall.initialText == "help" || $currentCall.initialText == "Help" || $currentCall.initialText == "HELP" || $currentCall.initialText == "HELP " || $currentCall.initialText == "Help " || $currentCall.initialText == "help ")
say "If you get no response to your query, the most common reason is mispelling a business name. For a list of search commands, enter MENU."; log "ttttttttttttt #{$currentCall.initialText}"

elsif ($currentCall.initialText == "menu" || $currentCall.initialText == "Menu" || $currentCall.initialText == "MENU" || $currentCall.initialText == "MENU " || $currentCall.initialText == "Menu " || $currentCall.initialText == "menu ")
say "1) Weather: e.g., 'weather 90210' 2) Driving directions, enter 'origin=address1&destination=address2'. No spaces between the '=' or '&' signs & no zip."; say "3) business: e.g., 'pizza 56389' or 'pizza hut 07921' 4) phone: e.g., 'phone CVS lafayette, pa'. 5) News (or Nouvelles, Noticias, Novidades): e.g., 'news civil war in syria' 6) Address: e.g., 'address starbucks, bedminster, nj' 7)  Movies: e.g., 'movies 07924' 8) Web (or Web-fr, Web-es, Web-pt): e.g., 'web denzel washington' 9) Wikipedia: e.g., 'wiki barack obama' 10) Define (or Definir, Significar, Definido): e.g., 'define gnosticism' 11) Sports scores: e.g., 'scores NBA' 12) Currency conversion, e.g., 'web 1 dollar is how many euros' 13) Math conversion, e.g., 'web 1 yard is how many meters' 14) airport delays, text 'airport delays' 15) flight status, text 'flight + official name and number' e.g., 'flight US357' or 'flight CA8621' 16) Int'l clock, e.g., 'what time in Rome' 17) Stock prices, e.g., '$Stock YHOO'"; log "ttttttttttttt #{$currentCall.initialText}"
else say "Sorry, I didn't understand your request. Text MENU for search options."

end

wait(10000)
myarray = ["Ad: Lisa Nielsen is an educator and innovator passionate about Ed Tech and the student voice. Read her blog at http://InnovativeEducator.com","Ad: For social media storytelling that enlarges your audience and reach, visit Melanie Gonzalez on the Web at http://quemeanswhat.com","Ad: For sophisticated SEO and content marketing that will boost your rankings, contact Viral Content Buzz, http://viralcontentbuzz.com","Ad: Contact LiveArtLove for commercials and documentary production, founded by Bro+Sis combo Armani and Tiffy Diamond: http://liveartlove.com","Ad: For integrated marketing strategy that grows your business, contact Strategic Marketing Solutions: http://strategicdriven.com","Ad: For social and mobile innovation that gets results, meet Karen Rogers Robinson. Learn more at https://t.co/XVq1SSz1ag","Ad: Discover great books with AvastaPress. Learn more at http://avastapress.com", "Ad: Spend more time writing and editing instead of surfing with Predictablely: http://predictable.ly","Ad: Karen Swim, PR and Marketing pro specializing in B2B healthcare technology. Call (586) 461-2103 or visit http://muckrack.com/karen-swim", "Ad: Contact the Wellfonder Group for help with your social media strategy. http://wellfondergroup.com", "Ad: World-renown author, Lisen Stromberg, is a contributor to Fortune and Huffington Post. Learn more: http://lisenstromberg.com","Ad: Brian Fanzo is a social media speaker and evangelist who talks fast and tweets faster. Learn more at http://isocialfanz.com/isocialtalks/","Ad: Kate Tilton's Author Services, LLC connects authors & readers. http://katetilton.com","Ad: Need a professional video for your business? Contact the Ladygeeks at http://ladygeeks.org", "Ad: Nana's House Lye Soap, As Natural As the Skin You Put It On. Visit http://s.gnoss.us/nanas or call 936.657.0157 to place your order today!"]
item = myarray[rand(myarray.length)]
if($currentCall.callerID[/9785006180/] || $currentCall.callerID[/6508688189/] || $currentCall.callerID[/3365438608/] || $currentCall.callerID[/9084953387/] || $currentCall.callerID[/9725677850/] || $currentCall.callerID[/6197153296/] || $currentCall.callerID[/5129930327/])
say "Text Engine didn't give you the answer? Resend your inquiry and add '#Human' to the end and it will be answered by a human operator!"
say "Need something on demand? Text your request & add #Ondemand at the end and our virtual assistant will take care of it for you!"
else say "#{item}"
say "Want to stop seeing these ads? Click here to purchase an ad-free monthly subscription: http://s.gnoss.us/adfree"
say "Text Engine didn't give you the answer? Resend your inquiry and add '#Human' to the end and it will be answered by a human operator!"
say "Need something on demand? Text your request & add #Ondemand at the end and our virtual assistant will take care of it for you!"

end
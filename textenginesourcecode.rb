require 'rss'
require 'open-uri'
require 'uri'
require 'json'
require 'rest-client'
require 'net/http'

####### MOVIES FUNCTION ###############

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

############## STOCK QUOTES FUNCTION ############

def fetch_stock(searchquery)
furl = 'http://www.nasdaq.com/aspxcontent/NasdaqRSS.aspx?data=quotes&symbol=' + searchquery.gsub("Stock ","").gsub("stock","")
rss = RSS::Parser.parse(furl, false)
rss.items.each do |item|
result = "#{item.description.gsub!("&nbsp;", "")}"
cleaned = ""
result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub(/<\/?[^>]+>/, '').gsub(/\s+/, "").gsub("Last"," Price (USD): ").gsub("Change"," Change: ").gsub("%Change"," %Chgange: ").gsub("Volume"," Volume: ").gsub("Asof:"," As of: ").gsub("View:StockQuote|","").gsub("News","").gsub("2014","2014 ").gsub("EST", " EST")
end
end

########## GOOGLE WEB SEARCH #############

def fetch_google(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxx&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

########## GOOGLE.FR WEB SEARCH #################

def fetch_googlefr(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxx&googlehost=google.fr&lr=lang_fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

########## GOOGLE.ES WEB SEARCH ####################

def fetch_googlees(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxx&googlehost=google.es&lr=lang_es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

########### GOOGLE.COM.BR (PORTUGUESE) WEB SEARCH ##############

def fetch_googlept(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxxxxxxxx&lr=lang_pt&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

############ DEFINE FUNCTION ##############

def fetch_define(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxxxxxx&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

############## DEFINE IN FRENCH ##############

def fetch_definefr(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxx&googlehost=google.fr&lr=lang_fr&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

############### DEFINE IN SPANISH #################

def fetch_definees(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxxx&googlehost=google.es&lr=lang_es&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

############ DEFINE IN PORTUGUESE ################

def fetch_definept(searchquery)
google_url = 'https://www.googleapis.com/customsearch/v1?key=xxxxxxxxxxxxxxxxxx&googlehost=google.com.br&lr=lang_pt&q='
  query = "" + searchquery
  url = URI.encode(google_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["items"][6]["snippet"]}; #{searchq_data["items"][7]["snippet"]}; #{searchq_data["items"][8]["snippet"]};"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",").gsub("Dictionary.com","").gsub("Thesaurus.com","").gsub("with free online thesaurus, antonyms, and definitions","").gsub("Dictionary","").gsub("Word of the Day","").gsub("Synonyms","").gsub("Antonyms","").gsub("Free Merriam-Webster Dictionary","")
end

############### FLIGHT STATUS ##############

def fetch_flight(searchquery)
flight_url = 'http://readability.com/api/content/v1/parser?token=xxxxxxxxxxxxxxxx&url=https://www.google.com/search?q='
  query = "" + searchquery
  url = URI.encode(flight_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["excerpt"]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("Dec"," Dec ").gsub("Nov"," Nov ").gsub("Oct"," Oct ").gsub("Sep"," Sep ").gsub("Aug"," Aug ").gsub("Jul"," Jul ").gsub("Jun"," Jun ").gsub("May"," May ").gsub("Apr"," Apr ").gsub("Mar"," Mar ").gsub("Feb"," Feb ").gsub("Jan"," Jan ").gsub("Flight status for","").gsub("Arrival"," Arrival ").gsub("Gate"," Gate").gsub("am","am ").gsub("pm","pm ").gsub("departs"," departs").gsub("On-time"," On-time").gsub(";"," ").gsub("Departure"," from ").gsub("&","").gsub("hellip","").gsub("#x2014","").gsub("#x200E","").gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

################ WORLD CLOCK ##################

def fetch_time(searchquery)
time_url = 'http://readability.com/api/content/v1/parser?token=xxxxxxxxxxx&url=http://www.google.com/search?q='
  query = "" + searchquery
  url = URI.encode(time_url + query)
  response = RestClient.get url
  searchq_data = JSON.parse(response.body)
 searchq_result = "#{searchq_data["excerpt"][0..21]}"
cleaned = ""
searchq_result.each_byte {|x|  cleaned << x unless x > 127}
return cleaned.gsub("n=","").gsub("www.timeanddate.com/worldclock/city.html","").gsub("Time and Date","").gsub("Find out current local time in","").gsub("Current local time in","").gsub(";"," ").gsub("#x96","").gsub("#x2014","").gsub("hellip","").gsub("#x200E","").gsub("&","").gsub("<b>","").gsub("</b>","").gsub("&quot;","\"").gsub("&amp;","\&").gsub("&#39;","\'").gsub("?","").gsub("oa=!","").gsub("&gt;","").gsub("&lt;","").gsub("<br>","").gsub("<br/>","").gsub("\/;",",")
end

############# GOOGLE NEWS SEARCH ################

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

############### GOOGLE NEWS FRENCH ###########

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

############ GOOGLE NEWS SPANISH ###############

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

############### GOOGLE NEWS PORTUGUESE ##############

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

############3 GOOGLE NEWS HEADLINES ##############

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

########## GOOGLE NEWS HEADLINES FRENCH ################

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

############### GOOGLE NEWS HEADLINES SPANISH ################

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

########### GOOGLE HEADLINES PORTUGUESE ###########

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

############## BEGIN IF STATEMENTS TO RUN QUERIES ##############

if ($currentCall.initialText[/define/] || $currentCall.initialText[/Define/])
say "#{fetch_define($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

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

elsif (($currentCall.initialText[/stock/] || $currentCall.initialText[/Stock/]) && (!$currentCall.initialText[/news/] || !$currentCall.initialText[/web/] || !$currentCall.initialText[/wiki/] || !$currentCall.initialText[/News/] || !$currentCall.initialText[/Web/] || !$currentCall.initialText[/Wiki/] || !$currentCall.initialText[/origin&/] || !$currentCall.initialText[/destination&/]))
say "#{fetch_stock($currentCall.initialText)}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

############## AIRPORT DELAY RSS ############

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
say "#{fetch_time($currentCall.initialText.gsub("in","").gsub("What","").gsub("what","").gsub(" ", "%2B"))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif (($currentCall.initialText[/flight/] || $currentCall.initialText[/Flight/])  && $currentCall.initialText[/\d{1}/])
say "#{fetch_flight($currentCall.initialText.gsub(" ","%2B"))}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 
say "Didn't get the info you wanted? Try using, e.g., 'flight AA450' instead of ' American Airlines flight 450', or 'flight NWA88' instead of 'Northwest flight 88'" 
say "If you found the airline info but need the phone number, text something like 'phone United Airlines Newark NJ'"

elsif ($currentCall.initialText[/irections/] && ($currentCall.initialText[/to/] || $currentCall.initialText[/from/]))
say "For directions, enter  'origin=address1&destination=address2'. Don't insert spaces between the '=' or '&' signs. Don't use zipcode, use city,state"; say "The words 'origin' and 'destination' must be all lowercase."; say "NOTE: Long distances can return a lot of texts. Msg&Data rates may apply."

########### DRIVING DIRECTIONS (USES GOOGLE MAPS API) ##############

elsif ($currentCall.initialText[/\d{5}/] && (!$currentCall.initialText[/Origin/] && !$currentCall.initialText[/origin/] && !$currentCall.initialText[/weather/] && !$currentCall.initialText[/Weather/] && !$currentCall.initialText[/estination/]  && !$currentCall.initialText[/movies/]  && !$currentCall.initialText[/Movies/]))
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'"
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=xxxxxxxxxxxx&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=xxxxxxxxxxxx&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}";

######## YELLOW PAGES/BUSINESS LISTINGS (USES GOOGLE MAPS API #############

elsif ($currentCall.initialText[/([a-zA-Z]\d[a-zA-z]( )?\d[a-zA-Z]\d)/] && (!$currentCall.initialText[/Origin/] && !$currentCall.initialText[/origin/] && !$currentCall.initialText[/weather/] && !$currentCall.initialText[/Weather/] && !$currentCall.initialText[/estination/]  && !$currentCall.initialText[/movies/]  && !$currentCall.initialText[/Movies/]))
say "Check spelling if no results follow. Or, try 'web #{$currentCall.initialText}'"
log "ttttttttttttt #{$currentCall.initialText}";
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=xxxxxxxxxxxxx&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=xxxxxxxxxx&reference='
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
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=xxxxxxxxxxxx&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=xxxxxxxxxxx&reference='
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
places_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?sensor=false&key=xxxxxxxxxxxxxx&query='
purl = URI.encode(places_url + "" + $currentCall.initialText.gsub("Phone","").gsub("phone","").gsub("address","").gsub("Address",""))
pinfo = JSON.parse(RestClient.get purl)
reference0 = "#{pinfo['results'][0]['reference']}"
reference1 = "#{pinfo['results'][1]['reference']}"
reference2 = "#{pinfo['results'][2]['reference']}"
phone_url = 'https://maps.googleapis.com/maps/api/place/details/json?sensor=false&key=xxxxxxxxxxxx&reference='
phurl0 = URI.encode(phone_url + "" + reference0)
phurl1 = URI.encode(phone_url + "" + reference1)
phurl2 = URI.encode(phone_url + "" + reference2)
phinfo0 = JSON.parse(RestClient.get phurl0)
phinfo1 = JSON.parse(RestClient.get phurl1)
phinfo2 = JSON.parse(RestClient.get phurl2)
say "1. #{pinfo['results'][0]['formatted_address']}, #{pinfo['results'][0]['name']}, #{phinfo0['result']['formatted_phone_number']}";
say  "2. #{pinfo['results'][1]['formatted_address']}, #{pinfo['results'][1]['name']}, #{phinfo1['result']['formatted_phone_number']}";
say  "3. #{pinfo['results'][2]['formatted_address']}, #{pinfo['results'][2]['name']}, #{phinfo2['result']['formatted_phone_number']}";

############## BEGIN WIKIPEDIA API ##################

elsif(($currentCall.initialText[/wiki/] || $currentCall.initialText[/Wiki/]) && (!$currentCall.initialText[/(wiki@es)i/] || !$currentCall.initialText[/(wiki@fr)/i] || !$currentCall.initialText[/(wiki@pt)/i]))
wikipedia_url = "http://en.wikipedia.org/w/api.php?action=query&list=search&format=json&srlimit=5&prop=revisions&rvprop=content&srsearch="
wurl = URI.encode(wikipedia_url + "" + $currentCall.initialText.gsub(/(wiki)/i,""))
wuri = URI(wurl.gsub(" ","%20"))
winfo = Net::HTTP.get(wuri).force_encoding("UTF-8")
wikipedia_result = JSON.parse(winfo.gsub("\u00e9","e").gsub("\u02c8","").gsub("\u0252","").gsub("e\u026a",""))
say "#{wikipedia_result['query']['search'][3]['title'].gsub("ogg","").gsub("oa=/","").gsub("=","").gsub("<","").gsub(">","").gsub("span class","").gsub("searchmatch","").gsub("/span","").gsub("|","").gsub("b...","").gsub("/b","")}, #{wikipedia_result['query']['search'][0]['snippet'].gsub("ogg","").gsub("=","").gsub("<","").gsub(">","").gsub("span class","").gsub("searchmatch","").gsub("/span","").gsub("|","").gsub("b...","").gsub("/b","")}";say "#{wikipedia_result['query']['search'][1]['title'].gsub("oa=!","").gsub("ogg","").gsub("=","").gsub("<","").gsub(">","").gsub("span class","").gsub("searchmatch","").gsub("/span","").gsub("|","").gsub("b...","").gsub("/b","")}, #{wikipedia_result['query']['search'][1]['snippet'].gsub("ogg","").gsub("=","").gsub("<","").gsub(">","").gsub("span class","").gsub("searchmatch","").gsub("/span","").gsub("|","").gsub("b...","").gsub("/b","")}"; log "ttttttttttttt #{$currentCall.initialText}";

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

elsif($currentCall.initialText[/Origin/] || $currentCall.initialText[/Destination/])
say "The words 'Origin' and 'Destination' must be all lowercase. Please try again."

########## DRIVING DIRECTIONS (GOOGLE MAPS API) #############

elsif($currentCall.initialText[/origin=/] && $currentCall.initialText[/destination=/])
log "ttttttttttttt #{$currentCall.initialText}"
incr = 1
directions_url = 'http://maps.googleapis.com/maps/api/directions/json?sensor=false&'
durl = URI.encode(directions_url + "" + $currentCall.initialText)
dinfo = JSON.parse(RestClient.get durl)
dinfo['routes'][0]['legs'][0]['steps'].each do |step|
  say "Step #{incr} - Distance #{step['distance']['text']}, Duration #{step['duration']['text']}, Description #{step['html_instructions'].gsub('<b>','').gsub('</b>','').gsub('</div>','').gsub('<div style="font-size:0.9em">','')}"
  incr += 1
end

########## BEGIN WEATHER FUNCTIONS ###############

elsif ($currentCall.initialText[/([a-zA-Z]\d[a-zA-z]( )?\d[a-zA-Z]\d)/] && ($currentCall.initialText[/weather/] || $currentCall.initialText[/Weather/]))
weather_url = "http://api.wunderground.com/api/YOURAPIKEY/forecast/q/"
urlq = URI.encode(weather_url + "" + $currentCall.initialText.gsub("Weather ","").gsub("weather ","") + ".json")
uri = URI(urlq)
info = Net::HTTP.get(uri)
forecast = JSON.parse(info)
say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["fcttext_metric"]}"; log "ttttttttttttt #{$currentCall.initialText}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

elsif ($currentCall.initialText[/\d{5}/] && ($currentCall.initialText[/weather/] || $currentCall.initialText[/Weather/]))
weather_url = "http://api.wunderground.com/api/YOURAPIKEY/forecast/q/"
urlq = URI.encode(weather_url + "" + $currentCall.initialText.gsub("Weather ","").gsub("weather ","") + ".json")
uri = URI(urlq)
info = Net::HTTP.get(uri)
forecast = JSON.parse(info)
say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][0]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][1]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; say "#{$currentCall.initialText}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["title"]}: #{forecast["forecast"]["txt_forecast"]["forecastday"][2]["fcttext"]}"; log "ttttttttttttt #{$currentCall.initialText}"; log "nnnnnnnnnnnnnnnnnnnnn #{$currentCall.callerID}"; 

########### BEGIN SPORTS SCORES FUNCTIONS ##############

elsif ($currentCall.initialText == "Scores" || $currentCall.initialText == "scores")
say "To get scores, text e.g., 'scores MLB' for Major League Baseball"

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NHL/] || $currentCall.initialText[/Nhl/] || $currentCall.initialText[/nhl/]))
furl = 'nhl.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items[0..2].each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/MLB/] || $currentCall.initialText[/Mlb/] || $currentCall.initialText[/mlb/]))
furl = 'mlb.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NBA/] || $currentCall.initialText[/Nba/] || $currentCall.initialText[/nba/]))
furl = 'nba.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NFL/] || $currentCall.initialText[/Nfl/] || $currentCall.initialText[/nfl/]))
furl = 'nfl.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

elsif (($currentCall.initialText[/Score/] || $currentCall.initialText[/score/]) && ($currentCall.initialText[/NCAA/] || $currentCall.initialText[/Ncaa/] || $currentCall.initialText[/ncaa/]))
furl = 'ncaa.php'
flurl = URI.encode(furl)
fliurl = RestClient.get flurl
feed = RSS::Parser.parse(fliurl)
text = ""
feed.items.each do |f|
text = "#{text} -- #{f.title}: #{f.description}"
end
say text

############### BEGIN HELP AND MENU COMMANDS ############

elsif ($currentCall.initialText == "help" || $currentCall.initialText == "Help" || $currentCall.initialText == "HELP" || $currentCall.initialText == "HELP " || $currentCall.initialText == "Help " || $currentCall.initialText == "help ")
say "If you get no response to your query, the most common reason is mispelling a business name. For a list of search commands, enter MENU."; log "ttttttttttttt #{$currentCall.initialText}"

elsif ($currentCall.initialText == "menu" || $currentCall.initialText == "Menu" || $currentCall.initialText == "MENU" || $currentCall.initialText == "MENU " || $currentCall.initialText == "Menu " || $currentCall.initialText == "menu ")
say "1) Weather: e.g., 'weather 90210' 2) Driving directions, enter 'origin=address1&destination=address2'. No spaces between the '=' or '&' signs & no zip."; say "3) business: e.g., 'pizza 56389' or 'pizza hut 07921' 4) phone: e.g., 'phone CVS lafayette, pa'. 5) News (or Nouvelles, Noticias, Novidades): e.g., 'news civil war in syria' 6) Address: e.g., 'address starbucks, bedminster, nj' 7)  Movies: e.g., 'movies 07924' 8) Web (or Web-fr, Web-es, Web-pt): e.g., 'web denzel washington' 9) Wikipedia: e.g., 'wiki barack obama' 9) Define (or Definir, Significar, Definido): e.g., 'define gnosticism' 10) Sports scores: e.g., 'scores NBA' 11) Currency conversion, e.g., 'web 1 dollar is how many euros' 12) Math conversion, e.g., 'web 1 yard is how many meters' 13) airport delays, text 'airport delays' 14) flight status, text 'flight + official name and number' e.g., 'flight US357' or 'flight CA8621' 15) Int'l clock, e.g., 'what time in Rome' 16) Stock prices, e.g., 'Stock YHOO'"; log "ttttttttttttt #{$currentCall.initialText}"
else say "Sorry, I didn't understand your request. Text MENU for search options."

end

######## IF YOU WANT TO RUN APPENDED ADS, USE THIS CODE ############

myarray = ["Ad: Help us bring the Web to poor communities around the world! Support our IndieGoGo campaign: http://igg.me/at/textengine", 
"",
"Ad: It's #SuperBowl ad time. This year, it's not beer or babes, it's domestic violence that's getting all the attention: http://s.gnoss.us/syfmj"]
item = myarray[rand(myarray.length)]
if($currentCall.callerID[/6508688189/] || $currentCall.callerID[/9084943387/] || $currentCall.callerID[/4087576334/] || $currentCall.callerID[/9725677850/] || $currentCall.callerID[/6197153296/])
say ""

else say "#{item}"
say "Want to stop seeing these ads? Click here to purchase an ad-free monthly subscription: http://s.gnoss.us/adfree"

end
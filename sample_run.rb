
require "./lib/nlp_api.rb"

f = File.open("./spec/samples/response.xml")
EpnApi::Paper.response(f)

#next step is to save the result hash to the paper object
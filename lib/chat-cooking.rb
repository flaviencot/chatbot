require 'http'
require 'json'
require 'dotenv'
Dotenv.load

api_key = ENV["OPENAI_API_KEY"]

def converse_with_ai(conversation_history, api_key)
url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

loop do
    puts "You:"
    input = gets.chomp
    break if input == 'exit'

data = {
  "prompt" => conversation_history + input,
  "max_tokens" => 300,
  "n" => 1,
  "temperature" => 0.5
  
}

response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip
 
puts "AI: #{response_string}"
end
end

converse_with_ai("",api_key)
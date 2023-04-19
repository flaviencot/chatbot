require 'http'
require 'json'
require 'dotenv'
Dotenv.load

def converse_with_ai(conversation_history, api_key)
 
  loop do
    puts "You: "
    input = gets.chomp
    break if input.downcase == 'exit'

 
  url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

    data = {
      "prompt" => conversation_history + input,
      "max_tokens" => 100,
      "n" => 1,
      "temperature" => 0.5,
      "stop" => ["\n", "You:"],
      "presence_penalty" => 0.6,
      "frequency_penalty" => 0.6,
      "model" => "text-babbage-001"
    }

    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_text = response_body['choices'][0]['text'].strip
    conversation_history += input + response_text

    puts "AI: #{response_text}"
  end
end

# Call the method with the API key and an empty conversation history string
api_key = ENV["OPENAI_API_KEY"]
converse_with_ai("", api_key)
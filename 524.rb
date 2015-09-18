require 'sinatra'
require 'digi_moji'

get '/' do
  erb :index
end

get '/:query' do
  raise unless /^[a-zA-Z0-9]+$/ === params['query']
  query = params['query']

  opt = Hash.new
  opt[:front] = params['front'] if params['front']
  opt[:back] = params['back'] if params['back']

  @digi_str = str2digi(query, opt)
  erb :emoji
end

def str2digi(s, opt = {} )
  default_opt = {front: ENV['DEFAULT_FRONT_EMOJI'], back: ENV['DEFAULT_BACK_EMOJI']}
  opt = default_opt.merge(opt)

  arr = s.each_char.reduce([]) do |acc, c|
    join_digi(acc, DigiMoji::Char.build_char_map(c))
  end

  str_build = ""
  arr.each do |line|
    str_build += line.map { |c| c ? opt[:front] : opt[:back] }.join
    str_build += "<br>"
  end
  str_build
end

def join_digi(left, right)
  if left.empty?
    right
  else
    left = left.dup
    left.each { |l| l << false }
    left.zip(right).map { |n| n.flatten }
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'sitar'

module Spec
  extend Sitar

  load 'spec/libsample.so'
end

puts Spec.add 5, 2
puts Spec.print("hoge")

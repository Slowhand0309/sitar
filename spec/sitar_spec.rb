# coding: utf-8
require 'spec_helper'


describe 'Sitar' do

  before(:all) do

    module Spec
      extend Sitar
      load 'spec/lib/build/libsample.so'

      SCORE = struct([
        "unsigned int play_time",
        "long value"
      ])
    end

  end

  it 'run' do
    begin
      Spec.run().run
    rescue => e
      expect(false)
    end
  end

  it 'add' do
    expect(Spec.add(5, 2).to_i).to eq 7
  end

  it 'division' do
    expect(Spec.division(4.0, 1.5).to_f).to be_within(0.1).of(2.6)
  end

  it 'get_version' do
    str = Spec.get_version.to_s
    expect(str).to eq 'version 1.0.0'
  end

  it 'get_wide_str' do
    wide_str = Spec.get_wide_str.to_ws
    expect(wide_str).to eq 'wide string'
  end

  it 'get_score' do
    score = Spec::SCORE.malloc
    Spec.get_score(score.to_ptr).run
    puts score.play_time
    puts score.value
  end
end

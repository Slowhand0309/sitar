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

  it 'no_method' do
    expect{ Spec.no_method().call }.to raise_error(NoMethodError)
  end

  it 'run' do
    begin
      Spec.run().call
    rescue => e
      expect(false)
    end
  end

  it 'add' do
    expect(Spec.add(5, 2).ret_i).to eq 7
  end

  it 'division' do
    expect(Spec.division(4.0, 1.5).ret_d).to be_within(0.1).of(2.6)
  end

  it 'get_version' do
    str = Spec.get_version.ret_s
    expect(str).to eq 'version 1.0.0'
  end

  it 'get_wide_str' do
    wide_str = Spec.get_wide_str.ret_ws
    expect(wide_str).to eq 'wide string'
  end

  it 'get_score' do
    score = Spec::SCORE.malloc
    Spec.get_score(score.to_ptr).call
    expect(score.play_time).to eq 10000
    expect(score.value).to eq 987654321
  end
end

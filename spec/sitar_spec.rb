# coding: utf-8
require 'spec_helper'


describe 'Sitar' do

  before do

    module Spec
      extend Sitar
      load 'spec/lib/build/libsample.so'
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
end

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
    expect(Spec.add(5, 2)).to eq 7
  end
end

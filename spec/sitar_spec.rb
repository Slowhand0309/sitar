# coding: utf-8
require 'spec_helper'


describe 'Sitar' do

  before(:all) do

    module Spec
      extend Sitar
      extend Sitar::Types::StructFactory

      load 'spec/lib/build/libsample.so'

      # struct Score {
      #   unsigned int play_time;
      #   long value;
      # };
      define 'Score', [
        "unsigned int play_time",
        "long value"
      ]

      # struct Person {
      #   int no;
      #   wchar_t name[20];
      # };
      define 'Person', [
        "int no",
        "wchar_t name[20]"
      ]

      # struct Members {
      #   struct Person persons[3];
      #   struct Members *nextPtr;
      # };
      define 'Members', [
        "Person persons[3]",
        "void *nextPtr"
      ]

      define_eval(self)
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

  it 'member' do
    double_ptr = Sitar::Types::Pointer.pptr
    Spec.initMember(double_ptr).call
    members = Spec::MEMBERS.new(double_ptr.ptr)
    expect(members.no_1).to eq 1
    expect(members.name_1.pack('U9')).to eq 'hogehoge1'
    expect(members.no_2).to eq 2
    expect(members.name_2.pack('U9')).to eq 'hogehoge2'
    expect(members.no_3).to eq 3
    expect(members.name_3.pack('U9')).to eq 'hogehoge3'

    members2 = Spec::MEMBERS.new(members.nextPtr)
    expect(members2.no_1).to eq 11
    expect(members2.name_1.pack('U9')).to eq 'fugafuga1'
    expect(members2.no_2).to eq 12
    expect(members2.name_2.pack('U9')).to eq 'fugafuga2'
    expect(members2.no_3).to eq 13
    expect(members2.name_3.pack('U9')).to eq 'fugafuga3'

    Spec.freeMember(double_ptr).call
  end
end

# Sitar

Sitar is easy to use the [fiddle](https://github.com/ruby/ruby/tree/trunk/ext/fiddle).

[![Build Status](https://travis-ci.org/Slowhand0309/sitar.svg?branch=master)](https://travis-ci.org/Slowhand0309/sitar)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sitar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sitar

## Usage

You can used C method only to extend sitar and load shared library like follow:

C function in `libsample.so`

```c
int add(int a, int b) {
  return a + b;
}
```

Use in ruby.

```ruby
module M
  extend Sitar

  load 'libsample.so'
end

M.add(1, 2).ret_i # => 3
```

* List of function return type mthod like ret_XXX.

|Method|Return Type in C|Return Type in Ruby|Description|
|:-----|:------|:----------|:----------|
|call|void|nil|Not returned value.|
|ret_i|int|Integer|Returned int value.|
|ret_s|char *|String|Return string pointer.|
|ret_ws|wchar_t *|String|Return wide char string pointer.|
|ret_f|float|Float|Return float value.|
|ret_d|double|Float|Return double value.|

## Struct

You can easy to use struct by `Sitar::Types::StructFactory`.

e.g.

```ruby
module M
  extend Sitar
  extend Sitar::Types::StructFactory

  # struct Car {
  #   int id;
  #   char name[20];
  # };
  define 'Car', ["int id", "char name[20]"]

  # struct Owner {
  #   int seq;
  #   struct Car cars[3];
  # };
  define 'Owner', ["int seq", "Car cars[3]"]

  define_eval(self)
end

M::CAR.malloc

owner = M::OWNER.malloc
# Car cars[3] is expanded like follow:
# struct Owner {
#   int seq;
#   int id_1;
#   char name_1[20];
#   int id_2;
#   char name_2[20];
#   int id_3;
#   char name_3[20];
# }
owner.id_1
owner.name_1
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author

[slowhand0309](https://github.com/Slowhand0309)

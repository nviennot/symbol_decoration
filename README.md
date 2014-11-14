Symbol Decoration
=================

The Symbol Decoration gem provides symbol method extensions to implement
DSL such as like `where(:field.in => [1,2,3])`.

The goal is to allow different ORMs such as Mongoid and NoBrainer to co-exist as
both ORMs need such functionality.

Usage
=====

In the following example: `where(:field.in => [1,2,3])`, the `in` keyword is a *decorator*, and *decorates* the `:field` symbol.

To register decorators, you may call `Symbol::Decoration.register(decorator, ...)`.  For example:

```ruby
Symbol::Decoration.register(:in)
Symbol::Decoration.register(*%w(in nin eq ne not gt ge gte lt le lte))
```

Once registered, a decorator can be used with `symbol.decorator`, which returns
a `Symbol::Decoration` instance.

To support the lowest common denominator, decorators may accept arguments and
blocks. For example, `:field.gt(5)` is valid.

You may retrieve the decoration properties with:

* `decorated_symbol.symbol` to get the symbol which is being decorated.
* `decorated_symbol.decorator` to get the decoration (for example `:gt`).
* `decorated_symbol.args` to get the decoration arguments.
* `decorated_symbol.blocks` to get the decoration block.

Full example:

```ruby
Symbol::Decoration.register(:gt)

:field.gt.class            == Symbol::Decoration
:field.gt.symbol           == :field
:field.gt.decorator        == :gt
:field.gt(5).args          == [5]
:field.gt { 5 }.block.call == 5
```

License
=======

Symbol Decoration is MIT Licensed.

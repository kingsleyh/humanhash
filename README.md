# HumanHash

[![Build Status](https://travis-ci.org/kingsleyh/humanhash.svg?branch=master)](https://travis-ci.org/kingsleyh/humanhash)

HumanHash provides human-readable representations of digests.

This is a port of [duggan's](https://github.com/duggan/humanhash-ruby) ruby HumanHash implementation. Which is in turn a port of [Jacon Carlson's](https://github.com/jacobwcarlson/humanhash-ruby) ruby project which was originally based on [Zachary Voase's Python implementation](https://github.com/zacharyvoase/humanhash). So I can hardly take credit for this library as the work all belongs to those other great people and this is simply a port to the Crystal language.

## Examples

    icr(0.27.0)> require "./humanhash"
    icr(0.27.0)> digest = "535061bddb0549f691c8b9c012a55ee2"
    icr(0.27.0)> HumanHash.humanize(digest)
    => "alpha-twenty-mockingbird-twelve"
    icr(0.27.0)>
    icr(0.27.0)> h = HumanHash.uuid
    icr(0.27.0)> h.human
    => "berlin-avocado-may-nebraska"
    icr(0.27.0)> h.uuid
    => "f9c25578-55b8-46a8-bed5-40994056d10e"
    icr(0.27.0)> h.digest
    => "6ffb57d425e64d3993b381104e7bdb99"

## Installation

Add this to your application's shard.yml:

    dependencies:
      humanhash:
        github: kingsley/humanhash



## Caveats

Don't store the humanhash output, as its statistical uniqueness is only
256^words. Its intended use is as a human-readable (and, most
importantly, **memorable**) representation of a longer digest, unique enough
for display in a user interface, where a user may need to remember or verbally
communicate the identity of a hash, without having to remember a 40-character
hexadecimal sequence. Nevertheless, you should keep original digests around,
then pass them through `humanize()` only as you're displaying them.


## How It Works

The procedure for generating a humanhash involves compressing the input to a
fixed length (default: 4 bytes), then mapping each of these bytes to a word in
a pre-defined wordlist (a default wordlist is supplied with the library). This
algorithm is consistent, so the same input, given the same wordlist, will
always give the same output. You can also use your own wordlist, and specify a
different number of words for output.

## Contributing

1. Fork it (<https://github.com/kingsleyh/humanhash/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Kingsley Hendrickse](https://github.com/kingsleyh) - creator and maintainer

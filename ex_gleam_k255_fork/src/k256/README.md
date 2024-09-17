# K256

Schnorr signature library

Wrapper around the [k256](https://crates.io/crates/k256) rust library

## Installation

```elixir
def deps do
  [
    {:k256, "~> 0.0.8"}
  ]
end
```

## How to publish

Before pushing a new version, make sure to add a git tag.

Here, an example of pushing the 0.0.8 version, which should match @version in mix.exs.

```bash
git tag -a 0.0.8 -m "a commit comment"
git push origin main --tags
```

Wait for the [action](https://github.com/RooSoft/k256/actions) to finish, and make sure it's successful.

Create a checksum file

```bash
mix rustler_precompiled.download K256.Native --all --print
```

Publish to hex

```bash
mix hex.publish
```

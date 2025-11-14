// FFI bindings for the Nosnos Elixir library
// This module provides Gleam bindings to the Nosnos library for Nostr event signing and verification

import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/erlang/atom

/// Represents a signed Nostr event returned from the sign_event FFI
pub type NostrEventResult {
  NostrEventResult(
    id: String,
    pubkey: String,
    created_at: Int,
    kind: Int,
    tags: String,
    content: String,
    sig: String,
  )
}

/// Sign a 32-byte message using BIP-340 Schnorr signature scheme
/// Returns a 64-byte signature
@external(erlang, "Elixir.Nosnos", "sign")
pub fn sign_raw(secret_key: BitArray, msg: BitArray) -> BitArray

/// Verify a BIP-340 Schnorr signature
/// Returns true if the signature is valid, false otherwise
@external(erlang, "Elixir.Nosnos", "verify")
pub fn verify_raw(
  public_key: BitArray,
  msg: BitArray,
  signature: BitArray,
) -> Bool

/// Sign a complete Nostr event and return all event fields
@external(erlang, "Elixir.Nosnos", "sign_event")
fn sign_event_ffi(
  secret_key: BitArray,
  created_at: Int,
  kind: Int,
  tags: String,
  content: String,
) -> Dynamic

/// Verify a Nostr event signature
@external(erlang, "Elixir.Nosnos", "verify_event")
pub fn verify_event_raw(
  id: String,
  pubkey: String,
  created_at: Int,
  kind: Int,
  tags: String,
  content: String,
  sig: String,
) -> Bool

/// Decoder for NostrEventResult from Elixir struct
/// Elixir structs use atom keys, which in Gleam dynamic can be accessed using the atom module
fn event_decoder() {
  use id <- decode.field(atom.to_dynamic(atom.create("id")), decode.string)
  use pubkey <- decode.field(atom.to_dynamic(atom.create("pubkey")), decode.string)
  use created_at <- decode.field(atom.to_dynamic(atom.create("created_at")), decode.int)
  use kind <- decode.field(atom.to_dynamic(atom.create("kind")), decode.int)
  use tags <- decode.field(atom.to_dynamic(atom.create("tags")), decode.string)
  use content <- decode.field(atom.to_dynamic(atom.create("content")), decode.string)
  use sig <- decode.field(atom.to_dynamic(atom.create("sig")), decode.string)
  decode.success(NostrEventResult(id, pubkey, created_at, kind, tags, content, sig))
}

/// Safe wrapper for sign_event that decodes the result
pub fn sign_event(
  secret_key: BitArray,
  created_at: Int,
  kind: Int,
  tags: String,
  content: String,
) -> Result(NostrEventResult, List(decode.DecodeError)) {
  sign_event_ffi(secret_key, created_at, kind, tags, content)
  |> decode.run(event_decoder())
}

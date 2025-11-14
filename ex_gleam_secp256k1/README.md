# ex_gleam_secp256k1

A sample implementation of Nostr event signing and verification using BIP-340 Schnorr signatures in Gleam.

## Overview

This sample demonstrates how to sign and verify Nostr events using [nosnos](https://github.com/comamoca/nosnos), an Elixir library that implements BIP-340 Schnorr signatures with Zigler (Zig NIFs).

### About nosnos

nosnos is an Elixir library that implements BIP-340 Schnorr signatures using Zig NIFs (Native Implemented Functions).

- High-performance cryptographic operations implemented in Zig
- BIP-340 Schnorr signature support
- Nostr protocol (NIP-01) event signing and verification functionality

This sample uses Gleam's FFI (Foreign Function Interface) to call the nosnos library, providing type-safe Nostr event signing and verification.

## How to Run

### Build

Currently (as of 2025/11/15), the Gleam build system cannot execute the `zig.get` mix task to fetch the Zig executable.
Therefore, you need to specify the Zig executable path before running `gleam build`:

```sh
export ZIGLER_ZIG_EXE=/path/to/zig
gleam build
```

### Run

```sh
gleam run
```

### Example Output

```
Nostr Event Signing and Verification Demo
==========================================

Secret Key: 829dab6210e50a8dd1ad22cd1320baf3b1ad6237d44e71e0092a3e08eadc4bdc

Creating and signing a Nostr event...
Content: Hello Nostr from Gleam! This is a test message.

✓ Event signed successfully!

=== Nostr Event ===
ID:         509894e18245cd617fedfc149c93fb84ea0819e37596d3ca2e89aecea2d7bd01
Public Key: 073a412f32ca55bd19269a1c78235e51dd10b0d6c8fb4565d9df0abdc442eadf
Created At: 1700000000
Kind:       1
Tags:       []
Content:    Hello Nostr from Gleam! This is a test message.
Signature:  8d43a10361818955a1f737876623aac6...
==================

Verifying the event signature...
✓ Signature is VALID!

The event has been successfully signed and verified.

--- Testing with modified content ---
Modified content: This content has been modified
✗ Modified event signature is INVALID (expected behavior)
```

---

[日本語版 README](./README.jp.md)

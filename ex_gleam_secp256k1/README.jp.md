# ex_gleam_secp256k1

GleamでBIP-340 Schnorr署名を使ったNostrイベントの署名・検証を行うサンプル実装

## 概要

ziglerを用いてBIP-340のSchnorr署名を実装しているElixirライブラリ[nosnos](https://github.com/comamoca/nosnos)をGleamから使用し、実際にNostrイベントの署名と検証を行うサンプルです。

### nosnosについて

nosnosは、ZigのNIF (Native Implemented Functions)を使ってBIP-340 Schnorr署名を実装したElixirライブラリです。

- Zigで実装された高速な暗号化処理
- BIP-340 Schnorr署名のサポート
- Nostrプロトコル (NIP-01) のイベント署名・検証機能

このサンプルでは、GleamのFFI（Foreign Function Interface）を使ってnosnosライブラリを呼び出し、型安全なNostrイベントの署名・検証を実現しています。

## 実行方法

### ビルド

現在(2025/11/15)gleamのビルドシステムにおいてzigの実行ファイルを取得するmixタスク`zig.get`が実行できません。
そのため、以下のようにzigの実行ファイルを指定した後`gleam build`を実行する必要があります。

```sh
export ZIGLER_ZIG_EXE=/path/to/zig
gleam build
```

### 実行

```sh
gleam run
```

### 実行結果の例

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

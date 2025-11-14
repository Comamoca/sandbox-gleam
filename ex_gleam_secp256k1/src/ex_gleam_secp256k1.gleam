import gleam/io
import gleam/int
import gleam/string
import gleam/bit_array
import gleam/result
import nosnos_ffi

/// Represents a Nostr event with all necessary fields
pub type NostrEvent {
  NostrEvent(
    id: String,
    pubkey: String,
    created_at: Int,
    kind: Int,
    tags: String,
    content: String,
    sig: String,
  )
}

/// Convert a hex string to a BitArray
fn hex_to_bitarray(hex: String) -> Result(BitArray, Nil) {
  bit_array.base16_decode(hex)
}

/// Sign a Nostr event and create a NostrEvent
///
/// # Arguments
/// * `secret_key_hex` - 64-character hex string representing the secret key
/// * `created_at` - Unix timestamp when the event was created
/// * `kind` - Event kind (1 for text note, etc.)
/// * `tags` - JSON string representing tags (e.g., "[]" for empty)
/// * `content` - The content of the event
///
/// # Returns
/// A Result containing either a NostrEvent or an error message
pub fn sign(
  secret_key_hex: String,
  created_at: Int,
  kind: Int,
  tags: String,
  content: String,
) -> Result(NostrEvent, String) {
  use secret_key <- result.try(
    hex_to_bitarray(secret_key_hex)
    |> result.replace_error("Invalid secret key hex string"),
  )

  use event_result <- result.try(
    nosnos_ffi.sign_event(secret_key, created_at, kind, tags, content)
    |> result.map_error(fn(err) { "Failed to sign event: " <> string.inspect(err) }),
  )

  Ok(NostrEvent(
    id: event_result.id,
    pubkey: event_result.pubkey,
    created_at: event_result.created_at,
    kind: event_result.kind,
    tags: event_result.tags,
    content: event_result.content,
    sig: event_result.sig,
  ))
}

/// Verify a Nostr event signature
///
/// # Arguments
/// * `event` - The NostrEvent to verify
///
/// # Returns
/// True if the signature is valid, False otherwise
pub fn verify(event: NostrEvent) -> Bool {
  nosnos_ffi.verify_event_raw(
    event.id,
    event.pubkey,
    event.created_at,
    event.kind,
    event.tags,
    event.content,
    event.sig,
  )
}

/// Print a NostrEvent in a human-readable format
fn print_event(event: NostrEvent) -> Nil {
  io.println("\n=== Nostr Event ===")
  io.println("ID:         " <> event.id)
  io.println("Public Key: " <> event.pubkey)
  io.println("Created At: " <> int.to_string(event.created_at))
  io.println("Kind:       " <> int.to_string(event.kind))
  io.println("Tags:       " <> event.tags)
  io.println("Content:    " <> event.content)
  io.println("Signature:  " <> string.slice(event.sig, 0, 32) <> "...")
  io.println("            " <> string.slice(event.sig, 32, 96))
  io.println("==================\n")
}

pub fn main() {
  // Secret key generated using: nak key generate
  let secret_key = "829dab6210e50a8dd1ad22cd1320baf3b1ad6237d44e71e0092a3e08eadc4bdc"

  io.println("Nostr Event Signing and Verification Demo")
  io.println("==========================================\n")

  io.println("Secret Key: " <> secret_key)

  // Create a Nostr event
  let created_at = 1_700_000_000
  let kind = 1 // Text note
  let tags = "[]"
  let content = "Hello Nostr from Gleam! This is a test message."

  io.println("\nCreating and signing a Nostr event...")
  io.println("Content: " <> content)

  // Sign the event
  let sign_result = sign(secret_key, created_at, kind, tags, content)

  case sign_result {
    Ok(event) -> {
      io.println("\n✓ Event signed successfully!")
      print_event(event)

      // Verify the signature
      io.println("Verifying the event signature...")
      let is_valid = verify(event)

      case is_valid {
        True -> {
          io.println("✓ Signature is VALID!")
          io.println("\nThe event has been successfully signed and verified.")
        }
        False -> {
          io.println("✗ Signature is INVALID!")
          io.println("\nWarning: Signature verification failed!")
        }
      }

      // Test with modified content (should fail verification)
      io.println("\n--- Testing with modified content ---")
      let modified_event =
        NostrEvent(
          ..event,
          content: "This content has been modified",
        )

      io.println("Modified content: " <> modified_event.content)
      let modified_valid = verify(modified_event)

      case modified_valid {
        True -> io.println("✓ Modified event signature is valid (unexpected!)")
        False ->
          io.println(
            "✗ Modified event signature is INVALID (expected behavior)",
          )
      }
    }
    Error(err) -> {
      io.println("✗ Error signing event: " <> string.inspect(err))
    }
  }
}

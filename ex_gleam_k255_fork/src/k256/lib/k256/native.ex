defmodule K256.Native do
  @moduledoc """
  Houses the configuration and initialization of `Rustler`'s required
  OTP Application.

  All implemented NIFs can be found here and are delegated to by their logical
  modules. `Rustler` expects its NIFs to be instantiated in a single place.
  """

  # use Rustler,
  #   otp_app: :k256,
  #   crate: "k256_rs"

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :k256,
    crate: "k256_rs",
    base_url: "https://github.com/comamoca/k256/releases/download/#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILATION_EXAMPLE_BUILD") in ["1", "true"],
    version: version

  # TODO: Add type info.
  def schnorr_generate_random_signing_key(), do: error()
  def schnorr_create_signature(_, _), do: error()
  def schnorr_verifying_key_from_signing_key(_), do: error()
  def schnorr_verify_message(_, _, _), do: error()
  def schnorr_verify_message_digest(_, _, _), do: error()

  defp error(), do: :erlang.nif_error(:nif_not_loaded)
end

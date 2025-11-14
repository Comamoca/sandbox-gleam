{
  lib,
  newScope,
  beamPackages,
  buildGleam,
  fetchgit,
}:

let
  inherit (beamPackages) buildMix buildRebar3 fetchHex;
in

lib.makeScope newScope (self: {
  gleam_stdlib = buildGleam {
    name = "gleam_stdlib";
    version = "0.65.0";
    otpApplication = "gleam_stdlib";

    src = fetchHex {
      pkg = "gleam_stdlib";
      version = "0.65.0";
      sha256 = "sha256-fGnHHYxJOuEaUYSCincRDrBad4br+LJbNqcvh5w+4Qc=";
    };
  };

  gleeunit = buildGleam {
    name = "gleeunit";
    version = "1.6.1";
    otpApplication = "gleeunit";

    src = fetchHex {
      pkg = "gleeunit";
      version = "1.6.1";
      sha256 = "sha256-/caKjEkrHptCkkkGLNm6ybVTjG+/WEgXIF0JmMQuHaw=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };
})

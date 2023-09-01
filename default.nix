{ stdenv, fetchFromGitHub, lib, debug ? true, calamares-nixos }:

if debug then
calamares-nixos.overrideAttrs (final: prev: {
  postInstall = ''
    mkdir -p $out/share/calamares
    cp -r ${./modules}/nixos  $out/lib/calamares/modules/nixos
    cp -r ${./config}/* $out/share/calamares/
    cp -r ${./branding/nixos} $out/share/calamares/branding/nixos
  '';
}) else
stdenv.mkDerivation rec {
  pname = "calamares-ghaf-extensions";
  version = "0.3.12";

  src = ./.;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{lib,share}/calamares
    cp -r modules $out/lib/calamares/
    cp -r config/* $out/share/calamares/
    cp -r branding $out/share/calamares/
    runHook postInstall
  '';
}

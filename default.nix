{ stdenv, fetchFromGitHub, lib }:

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

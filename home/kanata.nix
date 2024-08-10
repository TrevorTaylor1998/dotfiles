{ pkgs ? import <unstable> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "chords";
  # version = "1.7.0-prerelease";

  src = pkgs.fetchFromGitHub {
    owner = "jtroo";
    repo = "kanata";
    # rev = "v${version}";
    # sha256 = "sha256-Kuxy6lGzImYYujuJwZZdfuu3X7/PJNOJefeZ0hVJaAA=";
    rev = "bb925fb38e20466ccf2f2bcb259b29b1ecad990c";
    sha256 = "sha256-BZ2aMZzCiNQSovFF1JPX7/EekvIjy0MhTBUthyZ24Ro=";
    # rev = "1.6.1";
  };

  # cargoHash = "sha256-R2lHg+I8Sry3/n8vTfPpDysKCKMDUvxyMKRhEQKDqS0=";

  cargoHash = "sha256-/H0GvuORZCoWoWuAYKXYeufJw8NhGhhaHrmWMYVzxWY=";
}

with import <nixpkgs> {};

let inherit (vimUtils) buildVimPluginFrom2Nix; in {

  "zepl" = buildVimPluginFrom2Nix {
    name = "zepl";
    src = fetchgit {
      url = "https://github.com/axvr/zepl.vim";
      rev = "c0a580d6b4643fdf57fee54a50447903f4942cd7";
      sha256 = "0q0xn7izgazhcz8y7ifv9090ymdiwgsfi6ywbdz63y8w9c0qn008";
    };
  };
}

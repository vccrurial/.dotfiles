{
  description = "dotfiles that are NIXXEDMAXXED";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable-small";  
  };
  outputs = {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable,
      ...
    } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
    nixosConfigurations = {
      chminux = lib.nixosSystem {
        inherit system;
        modules = [ ./system.nix ];
      };
    };
  };
}

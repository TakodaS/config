{
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib;
with lib.plusultra; {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  virtualisation.digitalOcean = {
    rebuildFromUserData = false;
  };

  boot.loader.grub = enabled;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services = {
    castopod = {
      enable = true;
      localDomain = "cast.nixpkgs.news";
    };

    nginx = {
      enable = true;

      virtualHosts."cast.nixpkgs.news" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };

  systemd.services.castopod-scheduled.enable = false;

  plusultra = {
    nix = enabled;

    cli-apps = {
      tmux = enabled;
      neovim = enabled;
    };

    tools = {
      git = enabled;
    };

    security = {
      doas = enabled;
      acme = enabled;
    };

    services = {
      openssh = enabled;
      tailscale = enabled;
    };

    system = {
      fonts = enabled;
      locale = enabled;
      time = enabled;
      xkb = enabled;
    };
  };

  system.stateVersion = "21.11";
}

{
  project.name = "comfyui";
  host.uid = 1000;

  services."comfyui" = {
    image.enableRecommendedContents = true;

    service = {
      useHostStore = true;
      ports = [
        "127.0.0.1:8188:8188"
      ];

      devices = [
        "/dev/kfd:/dev/kfd"
        "/dev/dri:/dev/dri"
      ];
      volumes = [
        "../ComfyUI.Data:/var/lib/comfyui"
      ];
    };

    nixos = {
      useSystemd = true;
      configuration =
        { pkgs, lib, ... }:
        {
          boot.isContainer = true;
          boot.tmp.useTmpfs = true;

          system.stateVersion = "25.05";
          system.nssModules = lib.mkForce [ ];

          systemd.oomd.enable = false;
          services.nscd.enable = false;

          systemd.services."comfyui" = {
            enable = true;
            wantedBy = [ "multi-user.target" ];
            description = "ComfyUI Server";
            serviceConfig = {
              Type = "simple";
              ExecStart = "${pkgs.comfyui}/bin/main.py --listen=0.0.0.0 --port=8188 --base-directory=/var/lib/comfyui --disable-xformer --reserve-vram=1";
            };
          };
        };
    };
  };
}

_: pkgs:
let
  require = path: args: pkgs.callPackage (import path) args;
in
{
  config = pkgs.config // {
    cudaSupport = false;
    rocmSupport = true;
  };

  comfyui = require ./comfyui { };
}

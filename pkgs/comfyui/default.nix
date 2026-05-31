{
  fetchFromGitHub,
  fetchPypi,

  python3,

  additionalDependencies ? [ ],
}:
let
  python3Packages = python3.pkgs;

  comfy-aimdo = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfy_aimdo";
    version = "0.4.7";
    format = "wheel";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      dist = "py3";
      python = "py3";
      format = "wheel";
      hash = "sha256-smXo9AlDx0z1K6L3jC15KXZjwNg0sY6N8nji58/BTqE=";
    };
  });

  comfy-kitchen = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfy_kitchen";
    version = "0.2.10";
    format = "wheel";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      dist = "py3";
      python = "py3";
      format = "wheel";
      hash = "sha256-wkKv0Y0SDij8lJxCP6KMuyLLTXDWJ9jMfN9rrVTdJyw=";
    };
  });

  comfyui-embedded-docs = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_embedded_docs";
    version = "0.5.1";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-GfMgT7E6iRq5NL6/ZDqX3OhpBpQslecwA1Ij2+Dq+t8=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-frontend-package = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_frontend_package";
    version = "1.45.14";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-9g2Bk8XVgdnshRHmKQqzpw4ZRlvKfPKKzMFMmr5OEYA=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates-core = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates_core";
    version = "0.3.244";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-Ex5/s3srae2T4XDYE2bDOLSoaxtajGmXYU8FJdK/R3E=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates-media-api = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates_media_api";
    version = "0.3.79";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-Ky/WTsqGNm0s/WRFMy+Zxq9kxEOevxF+dXFyXotIeQE=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates-media-video = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates_media_video";
    version = "0.3.90";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-brKGg5SYcXkPzlGTKIB3VJB4HmVK4Lm6UiRZT9aqoCw=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates-media-image = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates_media_image";
    version = "0.3.145";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-bfW9cxsgiZKG1zJAUI6Y1BnUZtJ6i2WWYf6iPdVw1uQ=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates-media-other = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates_media_other";
    version = "0.3.210";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-wB1llMQizzM0K4rk0FHPJHmPokXiI0INlIrBW09/EZw=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
  });

  comfyui-workflow-templates = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "comfyui_workflow_templates";
    version = "0.9.91";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-Kg85NmxT2OaC8TuAboAuUfPFFSkn9UNygOxVKtb0G+o=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];

    dependencies = [
      comfyui-workflow-templates-core
      comfyui-workflow-templates-media-api
      comfyui-workflow-templates-media-image
      comfyui-workflow-templates-media-other
      comfyui-workflow-templates-media-video
    ];
  });

  spandrel = python3Packages.buildPythonPackage (finalAttrs: {
    pname = "spandrel";
    version = "0.4.2";
    src = fetchPypi {
      inherit (finalAttrs) pname version;
      hash = "sha256-/vpOqWbGpbdyHc8k8+IGKlqWo5XIvty1cPtVlx/cvMs=";
    };
    pyproject = true;
    build-system = with python3Packages; [ setuptools ];

    dependencies = with python3Packages; [
      einops
      numpy
      safetensors
      torch
      torchvision
      typing-extensions
    ];
  });
in
python3Packages.buildPythonApplication (finalAttrs: {
  pname = "ComfyUI";
  version = "v0.22.0";
  format = "other";
  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI";
    tag = finalAttrs.version;
    hash = "sha256-oiYOqYUKC5Qh1xGzvAfi8rEv7dp0iikjxyNwbIh8u5A=";
  };

  dependencies =
    (with python3Packages; [
      aiohttp
      alembic
      av
      blake3
      einops
      filelock
      glfw
      kornia
      numpy
      pillow
      psutil
      pydantic
      pydantic-settings
      pyopengl
      pyyaml
      requests
      safetensors
      scipy
      sentencepiece
      simpleeval
      sqlalchemy
      tokenizers
      torch
      torchaudio
      torchsde
      torchvision
      tqdm
      transformers
      yarl
    ])
    ++ [
      comfy-aimdo
      comfy-kitchen
      comfyui-embedded-docs
      comfyui-frontend-package
      comfyui-workflow-templates

      spandrel
    ]
    ++ additionalDependencies;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r . $out/bin

    mkdir -p $out/bin/user
    mkdir -p $out/bin/temp

    sed -i '1i #!/usr/bin/env python3' $out/bin/main.py
    chmod +x $out/bin/main.py

    runHook postInstall
  '';
})

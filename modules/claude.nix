{ config, pkgs, ... }:

{
  # Ensure Claude Code environment variable for native LSP tool usage is set globally
  home.sessionVariables = {
    ENABLE_LSP_TOOL = "1";
  };
}

let
  scriptsConfigPath = ../configs/scripts;
in
{
  home.file."scripts" = {
    source = scriptsConfigPath;
    recursive = true;
    executable = true;
  };
}

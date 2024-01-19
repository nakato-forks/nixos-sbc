{ config
, lib
, ...}:
let
  cfg = config.sbc.wireless.wifi;
in
{
  options.sbc.wireless.wifi = with lib; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = lib.mdDoc ''
        Enable generic WiFi configuration for the SBC.  This is independent of
        wifi hardware.  If WiFi hardware is disabled by default, you will need
        to enable it independently.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "rfkill" "cfg80211" ];

    hardware.wirelessRegulatoryDatabase = lib.mkForce true;
  };
}

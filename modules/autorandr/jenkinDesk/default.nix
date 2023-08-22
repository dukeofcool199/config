{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.autorandr.jenkinDesk;
  deskMonitorHdmi = "00ffffffffffff0006b32b2701000000091f0103803c2278ae9315ae4e46a1260e5054a5cb0081c081809500a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000fd0030901ed83c000a202020202020000000ff004d324c4d44573031363938360a000000fc005647323757510a20202020202001d5020349f35301023f0405901113141f60615d5e5f40061522230907078301000068030c002000382d0067d85dc401788003681a000001013090ede305e301e30f000ce60607016659289ee00078a0a032501040350055502100001a6fc200a0a0a055503020350055502100001a5aa000a0a0a046503020350055502100001ae9";
  jenkinWorkLaptopDisplay = "00ffffffffffff000daed51400000000281a0104a51f117802ee95a3544c99260f505400000001010101010101010101010101010101b43b804a71383440503c680035ad10000018000000fe004e3134304843452d454e320a20000000fe00434d4e0a202020202020202020000000fe004e3134304843452d454e320a200010";
  deskMonitorUsbC = "00ffffffffffff0006b32b2701000000091f0103803c2278ae9315ae4e46a1260e5054a5cb0081c081809500a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000fd0030901ed83c000a202020202020000000ff004d324c4d44573031363938360a000000fc005647323757510a20202020202001d5020349f35301023f0405901113141f5e5f5d5e5f40061522230907078301000068030c002000382d0067d85dc401788003681a000001013090ede305e301e30f000ce60607016659289ee00078a0a032501040350055502100001a6fc200a0a0a055503020350055502100001a5aa000a0a0a046503020350055502100001aed";

  smallDeskMonitorHdmi = "00ffffffffffff000469d124010101011417010380342078ea4ca5a7554da226105054230800818081409500a940b300d1c001010101283c80a070b023403020360006442100001a000000fd00323d1e5311000a202020202020000000fc0056533234410a20202020202020000000ff0044354c4d51533035313633300a01e302031ef14b900504030201111213141f230907078301000065030c0010001a3680a070381e403020350006442100001a662156aa51001e30468f330006442100001e011d007251d01e206e28550006442100001e8c0ad08a20e02d10103e9600064421000018011d8018711c1620582c250006442100009e00000000000000fe";
in
{
  options.jenkos.autorandr.jenkinDesk = with types; {
    enable =
      mkBoolOpt false "enable autorandr for jenkins desk?";
  };

  config = mkIf cfg.enable {
    services.autorandr = {
      profiles = {
        "dockedHdmi" = {

          fingerprint = {
            HDMI-1 = smallDeskMonitorHdmi;
            eDP-1 = jenkinWorkLaptopDisplay;
          };
          config = {
            HDMI-1 = {
              enable = true;
              crtc = 0;
              primary = true;
              position = "0x0";
              mode = "1920x1200";
              rate = "60.00";
            };
            eDP-1 = {
              enable = false;
            };
          };
        };
        "dockedUsbC" = {
          fingerprint = {
            DP-1 = deskMonitorUsbC;
            eDP-1 = jenkinWorkLaptopDisplay;
          };
          config = {
            DP-1 = {
              enable = true;
              crtc = 0;
              primary = true;
              position = "0x0";
              mode = "2560x1440";
              rate = "59.95";
            };
            eDP-1 = {
              enable = false;
            };
          };
        };
        "laptopOnly" = {
          fingerprint = {
            eDP-1 = jenkinWorkLaptopDisplay;
          };
          config = {
            eDP-1 = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
              rate = "60.01";
            };
          };
        };
      };
    };
  };
}

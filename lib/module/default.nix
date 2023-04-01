{ lib, ... }:

with lib; rec {
  mkOpt = type: default: description:
    mkOption { inherit type default description; };

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;

  mkBoolOpt' = mkOpt' types.bool;

  mkStrOpt = mkOpt types.str;

  enabled = { enable = true; };

  disabled = {
    enable = false;
  };

  optParams = pred: yes: no: if pred then yes else no;
  optList = pred: yes: if pred then yes else [ ];

  enable = true;
  yes = true;
  no = false;
}

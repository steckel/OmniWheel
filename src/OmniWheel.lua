local status, err = pcall(function()
  local OmniWheelAddon = require("OmniWheelAddon");
  omni_wheel_addon = OmniWheelAddon:New(UIParent);
end);
if status == false then print(err); end

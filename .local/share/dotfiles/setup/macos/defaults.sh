# Faster pointer tracking for mouse and trackpad (default ~0.6875)
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2

# Disable press-and-hold accent popup in favor of key repeat (useful in vim)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Secondary click via bottom-right trackpad corner instead of two-finger click
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false

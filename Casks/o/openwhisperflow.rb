cask "openwhisperflow" do
  version "0.1.1"
  sha256 "95688a1a64599a549eeacceb0b16708a88d78c2aa71f3172d0a61a44b41770b6"

  url "https://github.com/sumitjha4321/openwhisperflow/releases/download/v#{version}/OpenWhisperFlow-#{version}-arm64.zip"
  name "OpenWhisperFlow"
  desc "Menu bar app for push-to-talk dictation, transcribed on-device"
  homepage "https://github.com/sumitjha4321/openwhisperflow"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The shipped binary and the bundled ONNX Runtime dylib are both arm64.
  depends_on arch: :arm64
  # Homebrew reads a bare symbol as "this version or newer".
  depends_on macos: :sonoma

  app "OpenWhisperFlow.app"

  uninstall quit: "app.openwhisperflow"

  # Preferences, and any downloaded speech model, live in one directory.
  # The Microphone and Accessibility grants are held by macOS and cannot be
  # removed from here; "tccutil reset Accessibility app.openwhisperflow" does that.
  zap trash: [
    "~/Library/Application Support/OpenWhisperFlow",
    "~/Library/Saved Application State/app.openwhisperflow.savedState",
  ]
end

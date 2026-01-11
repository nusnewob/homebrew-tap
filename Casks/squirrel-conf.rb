cask "squirrel-conf" do
  version "1.0.2"
  sha256 "bb270c56f2e6debce43b41aa20cecd403fb42a78758ba85371fac473792a4b44"

  url "https://github.com/neolee/sct/releases/download/v#{version}/SCT.dmg"
  name "Squirrel Configuration Tool (SCT)"
  desc "Configuration tool for Rime input method engine"
  homepage "https://github.com/neolee/sct"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "SCT.app"
end

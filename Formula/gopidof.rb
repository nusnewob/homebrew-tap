class Gopidof < Formula
  desc "Lightweight pidof implementation written in Go"
  homepage "https://github.com/nusnewob/gopidof"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.0/pidof-darwin-arm64.tar.gz"
      sha256 "ff00785a95d88f9212b86ebe1c69d655a219284358dca106995c017960a742a6"
    else
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.0/pidof-darwin-amd64.tar.gz"
      sha256 "28440504652a2051fbb5e6358369059efd7da5e5ef0dc238b3a2250c6a8e9ee7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.0/pidof-linux-arm64.tar.gz"
      sha256 "a526f17cfdc0229bddb4ee6618a2424a994263b4286ebfbff3c2fabb264be19b"
    else
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.0/pidof-linux-amd64.tar.gz"
      sha256 "97ac135d06e2a8436157173af5687d5746da0ff1cafefd5c042601f057a7c854"
    end
  end

  # Fallback to build from source if binary not available
  resource "source" do
    url "https://github.com/nusnewob/gopidof/releases/download/v0.2.0/gopidof-v0.2.0-source.tar.gz"
    sha256 "2904f025b144528bedb767ed355fb2d74bae8506ed392e8f09715496cc0ee52e"
  end

  depends_on "go" => [:build, :optional]

  def install
    # Try to install precompiled binary
    if File.exist?("pidof-darwin-amd64") || File.exist?("pidof-darwin-arm64") ||
       File.exist?("pidof-linux-amd64") || File.exist?("pidof-linux-arm64")
      # Find the binary file
      binary = Dir["pidof-*"].first
      bin.install binary => "pidof"
    else
      # Build from source as fallback
      resource("source").stage do
        system "go", "build", "-ldflags", "-s -w", "-o", bin/"pidof"
      end
    end
  end

  test do
    system bin/"pidof", "--help"
  end
end

class Gopidof < Formula
  desc "Lightweight pidof implementation written in Go"
  homepage "https://github.com/nusnewob/gopidof"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.1/pidof-darwin-arm64.tar.gz"
      sha256 "32d0d030e6b6af0be96bd5d13f8e019edf75e644586eb5f0a126877e0eddfdee"
    else
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.1/pidof-darwin-amd64.tar.gz"
      sha256 "9e79c2ac24acaa931cd263d515fcd7e4c9f24063355233b1a49b54cd69d46095"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.1/pidof-linux-arm64.tar.gz"
      sha256 "a9996d2838e4c702e97f661a52c2615c1341e63b108aa6c794cd1b045faaf846"
    else
      url "https://github.com/nusnewob/gopidof/releases/download/v0.2.1/pidof-linux-amd64.tar.gz"
      sha256 "ffcafdb4f4e06b1eba8fb4542b1df2333d190c3a046366476713fa7f8eff6abb"
    end
  end

  # Fallback to build from source if binary not available
  resource "source" do
    url "https://github.com/nusnewob/gopidof/releases/download/v0.2.1/gopidof-v0.2.1-source.tar.gz"
    sha256 "d85f39e3022b21f40430209faba743e3a9732e11ebb726c9c9358ba63eb01ff8"
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

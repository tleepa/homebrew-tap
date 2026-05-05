class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.43.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.43.1/bicep-osx-x64"
      sha256 "a129c3b0b7e40627ef73921b5e2888c9661f0eb8511dc3023f39017ac069811d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.43.1/bicep-osx-arm64"
      sha256 "fff7f0a1ed674162d7f62fd14f83ae324a305ec4e63312af20be61247611c24c"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.43.1/bicep-linux-x64"
      sha256 "81e050975df82555e126ad7d5142bfb246a29c6e10fe8e8adb45ecfb953cd3c6"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.43.1/bicep-linux-arm64"
      sha256 "0f0bc94ddfc0730a7c59c57591258c4d12ed1843b2821fe4ea43920a0e20086d"
    end
  end

  def install
    bin.install "bicep-osx-#{Hardware::CPU.arch}".sub("x86_64", "x64") => "bicep" if OS.mac?
    bin.install "bicep-linux-#{Hardware::CPU.arch}".sub("x86_64", "x64") => "bicep" if OS.linux?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bicep --version")
  end
end

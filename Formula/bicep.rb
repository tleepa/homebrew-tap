class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.45.15"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.45.15/bicep-osx-x64"
      sha256 "4022cea927256923204f66e0dfb73dca33aaa113f24ab4df35fad5c88b1d8036"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.45.15/bicep-osx-arm64"
      sha256 "59072cc82da704ab45d6bb11133da15b169795e42ef585dedc73d98e19fcf1be"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.45.15/bicep-linux-x64"
      sha256 "ff5b194b042c220df4a50d6768ed1d6c39a32894bfdc4ff83d62b115d966a7ce"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.45.15/bicep-linux-arm64"
      sha256 "204684133b8e64027385e358d31aceda57b3ec00d028df769d9767a54d4dd154"
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

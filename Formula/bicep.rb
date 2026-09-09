class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # version "0.47.16"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.47.16/bicep-osx-x64"
      sha256 "8ba5771b5261413d88583829f2ea24509eb65b06d899620c17283ecb60d5ca73"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.47.16/bicep-osx-arm64"
      sha256 "68046a084c88503cf6bd11dacf2a1c4ffcb7e3ac9c6b310d295e024af21bbea4"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.47.16/bicep-linux-x64"
      sha256 "64c345a58e0c3e48b1bc98a4e62d6b3adb1d238281297de3400aeafb2697aa5a"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.47.16/bicep-linux-arm64"
      sha256 "4406214cc274cfac7c821552aec2178b80aec637d91ed8b244282964c1cf24e3"
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

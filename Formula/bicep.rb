class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.45.6"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.45.6/bicep-osx-x64"
      sha256 "7ec1b38372e0ec90b034c9d3e5b4aee6ff35bee09f4a546d8108a0171c613d61"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.45.6/bicep-osx-arm64"
      sha256 "5f6333335cab4c3eed50425eff1b4043c6fa89b010550550aaa88c10c5fa25a0"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.45.6/bicep-linux-x64"
      sha256 "3fae480c469677788f1552f55e70e31c8084f80769c7e8353118327e0ab361e4"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.45.6/bicep-linux-arm64"
      sha256 "fc76427cc6345a9a901f3309deafa813a5f69e13ee515337284319706f2930e7"
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

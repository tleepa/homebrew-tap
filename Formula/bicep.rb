class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # url "https://github.com/Azure/bicep/archive/refs/tags/v0.39.26.tar.gz"
  # sha256 "45f12c684b0e881069b0ab81af9558fc9a5b8c0d9c75bff99932c49269def04b"
  version "0.39.26"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.39.26/bicep-osx-x64"
      sha256 "be872575ace43946d07aee5fc8e7aa0810de6e283c0ca1599ea0b57eaba81324"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.39.26/bicep-osx-arm64"
      sha256 "d7aae5ad33741ef5ca11d8819e28f6e2c7ba187c18bedc05b3be77036a4d4716"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.39.26/bicep-linux-x64"
      sha256 "e919c8e160c030dbacde9d998ffab23fc8faf7943977c62b3d98b3b51f24f720"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.39.26/bicep-linux-arm64"
      sha256 "e4871dd4f18c48f0729ac30524d52192a98a8bf861a9a93a8e8af0b62b0d2ba7"
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

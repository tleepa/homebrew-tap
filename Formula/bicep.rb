class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # version "0.49.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/Azure/bicep/releases/download/v0.49.2/bicep-osx-arm64"
    sha256 "8ae74a6cf9cbba0cb220c40cf0e955f98d59df950afab07c21b7bcb78c9c5d68"
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.49.2/bicep-linux-x64"
      sha256 "0ab9de90c2493f206f8281bae74f9ee2d5ed3605548dab1adf41fef185e1f7c5"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.49.2/bicep-linux-arm64"
      sha256 "48d8f152bd78c8848a41a07ac2d12b573306d9329fc961a85354a98a95cc275e"
    end
  end

  def install
    bin.install "bicep-osx-#{Hardware::CPU.arch}" => "bicep" if OS.mac?
    bin.install "bicep-linux-#{Hardware::CPU.arch}".sub("x86_64", "x64") => "bicep" if OS.linux?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bicep --version")
  end
end

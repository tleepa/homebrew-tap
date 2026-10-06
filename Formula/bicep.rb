class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # version "0.48.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/Azure/bicep/releases/download/v0.48.1/bicep-osx-arm64"
    sha256 "62cd5958c62fa1b738e9b69f24799fabddb90ed83fdb7d6d2563dde376ce479d"
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.48.1/bicep-linux-x64"
      sha256 "b09ec25a9d376c1f8e33ede6ed22b587f915ad68488d5db77a6f9541748c7f6e"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.48.1/bicep-linux-arm64"
      sha256 "9cbf6a211137e894a863fbc842e355c2197fc2124a7bda902afe1bceffa35245"
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

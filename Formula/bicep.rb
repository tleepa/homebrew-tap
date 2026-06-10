class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.44.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.44.1/bicep-osx-x64"
      sha256 "9d3c8f412a82670b2d89126eda5210ce1290a5e3790f373094ea98c813cd90a9"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.44.1/bicep-osx-arm64"
      sha256 "d96a185cd7ce6a685a9d43130ff2298597603d7be9f782c7bef5171ed6884795"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.44.1/bicep-linux-x64"
      sha256 "e17dc9a9888184886bb0c0051a3230b83b19f342749999f707bc571c3dfd2f45"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.44.1/bicep-linux-arm64"
      sha256 "a9c73b96975a17e49b5dd66725c8dc2451501c77b194156d938719ee4990318b"
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

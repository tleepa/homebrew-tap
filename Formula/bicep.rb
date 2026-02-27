class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.41.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.41.2/bicep-osx-x64"
      sha256 "584063b38e0d42756cfd13490d8ea41fe91b25df091a7afd1cf4ca6305e95894"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.41.2/bicep-osx-arm64"
      sha256 "fcccfd95b92ae7aa9abc564c3813c1d4730891735d2e155089507f2d84927c2f"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.41.2/bicep-linux-x64"
      sha256 "cfe52532f77d9d183329f7e94a7fc9268a18d7d9dbaa9ec28d632734cdbfd58e"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.41.2/bicep-linux-arm64"
      sha256 "6fae3b9f31985031f9196553d2f122799dda173afb822770ae643589fef49d0a"
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

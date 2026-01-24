class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.40.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.40.2/bicep-osx-x64"
      sha256 "9f494896bd4350e04b1f4fb01709c65f8076e713b4b1e10edbf96d05af776392"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.40.2/bicep-osx-arm64"
      sha256 "4db247223bb4ea492a509a626b27fd96cf9b14ab2f118309b949ca8641659fb1"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.40.2/bicep-linux-x64"
      sha256 "69a5bd9730f72b7dcd6053f6b6900ede432bd1577e8e4e92b732accdac14900f"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.40.2/bicep-linux-arm64"
      sha256 "b5c794357d3593b8029ac2fb94c8d0a9e3a995eb568ff081ca01e91343fb8c52"
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

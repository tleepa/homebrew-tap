class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # url "https://github.com/Azure/bicep/archive/refs/tags/v${version}.tar.gz"
  # sha256 "45f12c684b0e881069b0ab81af9558fc9a5b8c0d9c75bff99932c49269def04b"
  version "${version}"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/Azure/bicep/releases/download/v${version}/bicep-osx-x64"
      sha256 "${sha256_osx_x64}"
    end

    on_arm do
      url "https://github.com/Azure/bicep/releases/download/v${version}/bicep-osx-arm64"
      sha256 "${sha256_osx_arm64}"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Azure/bicep/releases/download/v${version}/bicep-linux-x64"
        sha256 "${sha256_linux_x64}"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Azure/bicep/releases/download/v${version}/bicep-linux-arm64"
        sha256 "${sha256_linux_arm64}"
      end
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

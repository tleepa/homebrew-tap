class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  # url "https://github.com/Azure/bicep/archive/refs/tags/v0.38.33.tar.gz"
  # sha256 "45f12c684b0e881069b0ab81af9558fc9a5b8c0d9c75bff99932c49269def04b"
  version "0.38.33"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/Azure/bicep/releases/download/v0.38.33/bicep-osx-x64"
      sha256 "ccc9721f25597445346ca5c7c8898e533936e690d502f3dfb7db2e0a542f6aee"
    end

    on_arm do
      url "https://github.com/Azure/bicep/releases/download/v0.38.33/bicep-osx-arm64"
      sha256 "6ec9502fde079c8f7e2a4b63209be42dc278eea421f983807fedeaff27b4f2e8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Azure/bicep/releases/download/v0.38.33/bicep-linux-x64"
        sha256 "07e28411c2cb3a731660a32bb735268c2d1506c564bcea613eed1323e9926712"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Azure/bicep/releases/download/v0.38.33/bicep-linux-arm64"
        sha256 "83086d265071a40363ba59790636a8d538cf0f472394ee159adba589512e695e"
      end
    end
  end

  def install
    bin.install "bicep-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}".sub("x86_64", "x64") => "bicep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bicep --version")
  end
end

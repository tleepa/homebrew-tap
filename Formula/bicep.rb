class Bicep < Formula
  desc "Declarative language for describing and deploying Azure resources"
  homepage "https://github.com/Azure/bicep"
  version "0.43.8"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/bicep/releases/download/v0.43.8/bicep-osx-x64"
      sha256 "e009bd793763266878f39dd05212d2b4a7ed0714d911b7a1e89816e40d05a39d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/Azure/bicep/releases/download/v0.43.8/bicep-osx-arm64"
      sha256 "1bcbea8523b0437d85504c081d742877c2e9793305225bddf53c1aea537191f7"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.43.8/bicep-linux-x64"
      sha256 "03b902a8d4da2df36348d20f039a7e6268798781cdeceb38d8c1760f2843bec8"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Azure/bicep/releases/download/v0.43.8/bicep-linux-arm64"
      sha256 "1eb4e2b02e2aa5e18d711341b1228509d2319956aa051fa04919fa606e480ddb"
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

class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "7.5.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :ventura
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-x64.tar.gz"
      sha256 "cd16a04c1b99cdacbdc0337b0fd0da50dbf1a8b4e8437bcb4ca9118ef729211a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.tar.gz"
      sha256 "3aaadd7ca62f1e4dbe59145b6af24e926d61f8da8a4782bc535e500c184135f0"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-linux-x64.tar.gz"
      sha256 "1fd7983fe56ca9e6233f126925edb24bf6b6b33e356b69996d925c4db94e2fef"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-linux-arm64.tar.gz"
      sha256 "4b32d4cb86a43dfb83d5602d0294295bf22fafbf9e0785d1aaef81938cda92f8"
    end
  end

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pwsh -c '.psversion.tostring()'").strip
  end
end

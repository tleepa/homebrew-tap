class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  # version "7.6.7"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :ventura
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.7/powershell-7.6.7-osx-arm64.tar.gz"
    sha256 "50dde99bb066adacbb9a748182d09eb9beff25119dc3b12e85c84b6b6b1c5da9"
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.7/powershell-7.6.7-linux-x64.tar.gz"
      sha256 "6896f9e3a6b0a354bf470835a96da76d2f801cd50dcf047ad7c4563bf93bf431"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.7/powershell-7.6.7-linux-arm64.tar.gz"
      sha256 "ba465efdfb0984c1c5dc5ed9eb0b79a7e91a1b52c45f99377058c0659b84d3f1"
    end
  end

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh`. If not, the full path to the executable is:
        #{bin}/pwsh

      Other application files were installed at :
        #{libexec}

      If you also have the Cask installed, you need to run the following to make the formula your default install:
        brew link --overwrite powershell

      If you would like to make PowerShell your default shell, run
        sudo sh -c "echo '#{bin}/pwsh' >> /etc/shells"
        chsh -s #{bin}/pwsh
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pwsh -c '$PSVersionTable.PSVersion.ToString()'").strip
  end
end

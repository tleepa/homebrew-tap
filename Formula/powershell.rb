class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "7.6.1"
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
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-osx-x64.tar.gz"
      sha256 "b5f874a832bec2ba78cd3e44fdbcb04c1b6144d9eab42b9881cb8b9400bcc504"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-osx-arm64.tar.gz"
      sha256 "9e1078f70b11c40e10f4bad1354db1cdcaf38cd6775fcf40e0738e3f5ac6807e"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-linux-x64.tar.gz"
      sha256 "dfc94229767921603f7c3e1cb1ac5aa931448af7496ccf657723b6278057c415"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-linux-arm64.tar.gz"
      sha256 "73498813194ea0d849d5942332ee6e51657ea66da08216aa1050788d5c52b741"
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

class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "${version}"
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
      url "https://github.com/PowerShell/PowerShell/releases/download/v${version}/powershell-${version}-osx-x64.tar.gz"
      sha256 "${sha256_osx_x64}"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v${version}/powershell-${version}-osx-arm64.tar.gz"
      sha256 "${sha256_osx_arm64}"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v${version}/powershell-${version}-linux-x64.tar.gz"
      sha256 "${sha256_linux_x64}"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v${version}/powershell-${version}-linux-arm64.tar.gz"
      sha256 "${sha256_linux_arm64}"
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

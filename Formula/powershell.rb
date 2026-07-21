class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "7.6.4"
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
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.4/powershell-7.6.4-osx-x64.tar.gz"
      sha256 "b58e4b96dbdca20c058d4462f33509d386c0d768751344611bc04aaf32e4187c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.4/powershell-7.6.4-osx-arm64.tar.gz"
      sha256 "fff37135307d3a57038adb44eded6c3b4dcd2e254382f4913bc253499ef3469d"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.4/powershell-7.6.4-linux-x64.tar.gz"
      sha256 "4471b5a36bfe86ec7af8525d36bb1cacba0128e7aac22d05cc064bc00e604721"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.4/powershell-7.6.4-linux-arm64.tar.gz"
      sha256 "d4ef2382fa452f2ccbdb48a01adbbce9ed64954872123970c16be6d086d1224b"
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

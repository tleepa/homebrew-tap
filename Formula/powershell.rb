class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "7.6.2"
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
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.2/powershell-7.6.2-osx-x64.tar.gz"
      sha256 "3ce51ba39fd3c816212866ea461d582d69c5c9c3d35a1fd6cd789d23803758a2"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.2/powershell-7.6.2-osx-arm64.tar.gz"
      sha256 "4b10e8a8e3dba067cf68c09bd92ee137ccac00b7c05ed31a0ae136309ef107b6"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.2/powershell-7.6.2-linux-x64.tar.gz"
      sha256 "6cbcfbf20e376aa62ffd91c973493c41a7a52ddfd5a5db3ff9bc12f0d0fe9292"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.2/powershell-7.6.2-linux-arm64.tar.gz"
      sha256 "a8d4e386dfafda385d0604045eed03ce6f3a843d45fc8f0b9588b836ca17cdb8"
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

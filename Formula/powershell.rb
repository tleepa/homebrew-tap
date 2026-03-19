class Powershell < Formula
  desc "Cross-platform shell"
  homepage "https://github.com/PowerShell/PowerShell"
  version "7.6.0"
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
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-x64.tar.gz"
      sha256 "7c6279cfead06324451a10ff741883086c9a00f024baea924bb9d3c106fe0c82"
    end

    if Hardware::CPU.arm?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-arm64.tar.gz"
      sha256 "bb52db90e964ee0b91e93f559b350878c6b27c12fd51830d8eca1793712b9639"
    end
  end

  if OS.linux?
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-linux-x64.tar.gz"
      sha256 "04517472cf57d7f9cbd93897da9bed467c73ca6063c29d7655ebc20aa1d6023f"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-linux-arm64.tar.gz"
      sha256 "dddf7564fb3b52dc26be5580fc5b4e08eb3fa65b094488aae6d4b3cad5fea460"
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

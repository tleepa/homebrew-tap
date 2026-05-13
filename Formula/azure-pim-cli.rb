class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.17.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.17.0/az-pim-macos-0.17.0"
    sha256 "33334c7e310b300433e15886f1d9e20ecdad2bc5d43cc2596d5604bdd92e261e"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.17.0/az-pim-linux-musl-0.17.0"
    sha256 "dc62a225f445b330d56f56a96369f341029eb1cb35e0c76854b964f5ea294b03"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.17.0" : "az-pim-linux-musl-0.17.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

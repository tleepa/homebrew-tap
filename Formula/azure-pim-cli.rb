class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.14.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.14.0/az-pim-macos-0.14.0"
    sha256 "76a8baa292a1486e04c5cff448aa1f02fa2ccf2b68b96802d3e13e07bfe763d2"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.14.0/az-pim-linux-musl-0.14.0"
    sha256 "14f9f0a8da48641e3f1590823023c00a5e9f7baad278dc9f106b4a2c7bd2c9eb"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.14.0" : "az-pim-linux-musl-0.14.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

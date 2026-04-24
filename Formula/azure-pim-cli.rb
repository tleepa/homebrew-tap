class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.15.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.15.0/az-pim-macos-0.15.0"
    sha256 "f9c96327b1093642c1b18ee92c02cf0947780ea320a959f17eb8c440462b5eb6"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.15.0/az-pim-linux-musl-0.15.0"
    sha256 "079b576f3924f36dde0617c50143c95140c78dd52788afab3b4d02ade4ff823b"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.15.0" : "az-pim-linux-musl-0.15.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

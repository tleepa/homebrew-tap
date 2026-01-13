class AzPimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management (PIM) roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  version "${version}"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/demoray/azure-pim-cli/releases/download/${version}/az-pim-macos-${version}"
    sha256 "${sha256_macos}"
  end

  on_linux do
    url "https://github.com/demoray/azure-pim-cli/releases/download/${version}/az-pim-linux-musl-${version}"
    sha256 "${sha256_linux}"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.11.0" : "az-pim-linux-musl-0.11.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "${version}"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/${version}/az-pim-macos-${version}"
    sha256 "${sha256_macos}"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/${version}/az-pim-linux-musl-${version}"
    sha256 "${sha256_linux}"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-${version}" : "az-pim-linux-musl-${version}"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.16.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.16.0/az-pim-macos-0.16.0"
    sha256 "63f12d0b627f5c7fc5e7d91f596f4342c0fcd09fbddc9ef980d9041d3f6530a8"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.16.0/az-pim-linux-musl-0.16.0"
    sha256 "28e52937c2e8bd547e1c2be4a3a234702c191611f177aeca0a0332d0886ac750"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.16.0" : "az-pim-linux-musl-0.16.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

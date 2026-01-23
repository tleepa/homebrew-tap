class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.12.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.12.0/az-pim-macos-0.12.0"
    sha256 "3ba0c57e8ce82f49eb6885c9f10ffec71ea3d8a8827bcdd1afc3e11a4a498071"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.12.0/az-pim-linux-musl-0.12.0"
    sha256 "4117b24ca56cc1830f355611964221f8e366b2e47677017a0ac3bf13b1218e46"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.12.0" : "az-pim-linux-musl-0.12.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

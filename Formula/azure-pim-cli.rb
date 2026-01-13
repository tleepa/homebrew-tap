class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.11.0/az-pim-macos-0.11.0"
    sha256 "4aadd2bc09a5a213b1c090a77824c24467b5b4cb73e8c16553d8eb01bd7f4be7"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.11.0/az-pim-linux-musl-0.11.0"
    sha256 "7e2e6224e2e02f32d79a5f8828f76719b09b5766127d1674b7fef1647f2b7e47"
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

class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  # version "0.18.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.18.0/az-pim-macos-0.18.0"
    sha256 "956cc7c1bcbbb37d24f1579b4e544e5e860544f629f93239ac3bf6c3a8c0076a"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.18.0/az-pim-linux-musl-0.18.0"
    sha256 "0f3b6c82303f1dd3c31c3aeff56672ed070c086fb014e5900307f2598445ed2e"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.18.0" : "az-pim-linux-musl-0.18.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

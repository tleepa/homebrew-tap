class AzurePimCli < Formula
  desc "Unofficial CLI to list and enable Azure Privileged Identity Management roles"
  homepage "https://github.com/demoray/azure-pim-cli"
  license "MIT"
  # version "0.13.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64
  end

  if OS.mac?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.13.0/az-pim-macos-0.13.0"
    sha256 "e817ae4da294f29efef12ecceebe3be9f68a26558074e9ca4b92c8195bf3f90b"
  end

  if OS.linux?
    url "https://github.com/demoray/azure-pim-cli/releases/download/0.13.0/az-pim-linux-musl-0.13.0"
    sha256 "e4234dcbb79dab617882b8a35acbbcad070b179992704983bbead8fed48e26b0"
  end

  def install
    binary_name = OS.mac? ? "az-pim-macos-0.13.0" : "az-pim-linux-musl-0.13.0"
    binary_path = Pathname.pwd/binary_name
    chmod 0755, binary_name
    generate_completions_from_executable(binary_path, "init", shells: [:bash, :zsh, :fish, :pwsh])
    bin.install binary_name => "az-pim"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/az-pim --version")
  end
end

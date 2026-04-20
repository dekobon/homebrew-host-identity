# typed: false
# frozen_string_literal: true

# Rendered by .github/workflows/release.yml on each v* tag.
# Tokens substituted: 1.0.0, 6498c1e47f96f8a454266edb35ecd6577865cf997c9ff05da4faaa9b17b26129.
class HostIdentity < Formula
  desc "Stable host UUID across platforms, clouds, and Kubernetes"
  homepage "https://github.com/dekobon/host-identity"
  version "1.0.0"
  license any_of: ["Apache-2.0", "MIT"]

  # Apple-silicon-only. Intel Macs install via `cargo install
  # host-identity-cli` or run the aarch64 build under Rosetta 2.
  # GitHub's macos-13 runner pool was too oversubscribed to justify
  # keeping Intel in the release matrix.
  on_macos do
    on_arm do
      url "https://github.com/dekobon/host-identity/releases/download/v#{version}/host-identity-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "6498c1e47f96f8a454266edb35ecd6577865cf997c9ff05da4faaa9b17b26129"
    end
  end

  def install
    bin.install "host-identity"
    man1.install Dir["man/*.1"]
    doc.install "README.md", "LICENSE-APACHE", "LICENSE-MIT", "THIRD-PARTY-LICENSES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/host-identity --version")
  end
end

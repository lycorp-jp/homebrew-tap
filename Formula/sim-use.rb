class SimUse < Formula
  desc "Give AI agents eyes and hands on iOS Simulator and Android devices"
  homepage "https://github.com/lycorp-jp/sim-use"
  license "Apache-2.0"
  version "0.9.0"
  depends_on macos: :sonoma

  url "https://github.com/lycorp-jp/sim-use/releases/download/v0.9.0/sim-use-v0.9.0.tar.gz"
  sha256 "0b599c8ea8289eead8964c0605c29b3a09d8f91ec191ea8df7eac952572b26c2"

  def install
    libexec.install "sim-use", "Frameworks", "SimUse_SimUse.bundle", "SimUse_AndroidBackend.bundle"
    bin.write_exec_script libexec/"sim-use"
  end

  def post_install
    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      system "codesign", "--force", "--sign", "-", "--timestamp=none", framework
    end

    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"sim-use"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sim-use --version")
  end
end

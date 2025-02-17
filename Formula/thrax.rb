class Thrax < Formula
  include Language::Python::Shebang

  desc "Tools for compiling grammars into finite state transducers"
  homepage "http://www.openfst.org/twiki/bin/view/GRM/Thrax"
  url "http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.3.6.tar.gz"
  sha256 "5f00a2047674753cba6783b010ab273366dd3dffc160bdb356f7236059a793ba"
  license "Apache-2.0"

  livecheck do
    url "http://www.openfst.org/twiki/bin/view/GRM/ThraxDownload"
    regex(/href=.*?thrax[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "033c1195f0d64bf2844268850d006e79e410d5796f53b38606fdf6a24ba97d93"
    sha256 cellar: :any,                 big_sur:       "7120f61434e7851ae51ffba6ca11e7a20a5df0c90e59ed1f12bd831fab0d7bbc"
    sha256 cellar: :any,                 catalina:      "fa9e11b34775d0e1e7f12e7b9d15f4c22577033e6eabff8cefdbc3f197c64504"
    sha256 cellar: :any,                 mojave:        "3ab4c18556c41bec206362d9f564f82f6bc11388848fa7cd00242ce3c66118d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e05985642a3ae9cc5922a2f8ced5f8dd15169a95a4de45980bb2cb19bfef1152"
  end

  depends_on "openfst"

  on_linux do
    depends_on "gcc"
    depends_on "python@3.9"
  end

  fails_with gcc: "5"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
    on_linux { rewrite_shebang detected_python_shebang, bin/"thraxmakedep" }
  end

  test do
    # see http://www.openfst.org/twiki/bin/view/GRM/ThraxQuickTour
    cp_r pkgshare/"grammars", testpath
    cd "grammars" do
      system "#{bin}/thraxmakedep", "example.grm"
      system "make"
      system "#{bin}/thraxrandom-generator", "--far=example.far", "--rule=TOKENIZER"
    end
  end
end

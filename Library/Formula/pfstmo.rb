require "formula"

class Pfstmo < Formula
  homepage "http://pfstools.sourceforge.net/pfstmo.html"
  url "http://downloads.sourceforge.net/project/pfstools/pfstmo/1.5/pfstmo-1.5.tar.gz"
  sha1 "f48bc477c28074e74cdc9e5e9f050d726286d23f"

  depends_on :automake
  depends_on :autoconf
  depends_on 'libtool' => :build

  depends_on "pkg-config" => :build
  depends_on "pfstools"
  depends_on "fftw"
  depends_on "gsl"

  def install
    system "aclocal"
    system "glibtoolize"
    system "autoheader"
    system "automake --add-missing"
    system "autoreconf"
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make"
    system "make install" # if this fails, try separate make/make install steps
  end

  fails_with :clang do
    build 600
    cause <<-EOS.undent
    - Clang does not support OpenMP
    - The tonemappers use gcc specific tolerances, such as variable-length arrays of non-POD types
    EOS
  end

  def test
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test pfstmo`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/pfstmo_mantiuk08 --help"
  end
end

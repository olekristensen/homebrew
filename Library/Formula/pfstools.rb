require "formula"

class Pfstools < Formula
  homepage "http://pfstools.sourceforge.net"
  url "https://downloads.sourceforge.net/project/pfstools/pfstools/1.9.0/pfstools-1.9.0.tar.gz"
  sha1 "3fb9d56d0cb71b00f4d01a6e7f1252742f6420ae"

  depends_on :automake
  depends_on :autoconf
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on "cmake" => :build
  depends_on :x11
  depends_on "openexr"
  depends_on "imagemagick"
  depends_on "netpbm"
  depends_on "libtiff"
  depends_on "qt"
  depends_on "libpng"
  depends_on "little-cms"

  def install
    system "cmake", ".", "-DWITH_pfsglview=OFF", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/pfsin"
  end
end

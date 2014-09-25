require "formula"

class Pfstools < Formula
  homepage "http://pfstools.sourceforge.net"
  url "https://downloads.sourceforge.net/project/pfstools/pfstools/1.9.0/pfstools-1.9.0.tar.gz"
  sha1 "3fb9d56d0cb71b00f4d01a6e7f1252742f6420ae"

  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on "cmake" => :build
  depends_on :x11
  depends_on "openexr"
  depends_on "imagemagick" => %w{with-quantum-depth-32 enable-hdri}
  depends_on "netpbm"
  depends_on "libtiff"
  depends_on "qt"
  depends_on "libpng"
  depends_on "little-cms"

	def patches
		# This patch removes errorneous entries from the cmake system
    DATA
	end

  def install
    system "cmake", ".", "-DWITH_pfsglview=OFF", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/pfsin"
  end
end

__END__
diff --git a/src/fileformat/CMakeLists.txt b/src/fileformat/CMakeLists.txt
index b77a558..ff686f5 100644
--- a/src/fileformat/CMakeLists.txt
+++ b/src/fileformat/CMakeLists.txt
@@ -38,7 +38,8 @@ install (FILES pfsinrgbe.1 DESTINATION ${MAN_DIR})
 add_executable(pfsoutrgbe pfsoutrgbe.cpp rgbeio.cpp rgbeio.h "${GETOPT_OBJECT}") 
 target_link_libraries(pfsoutrgbe pfs)
 install (TARGETS pfsoutrgbe DESTINATION bin)
-install (FILES pfsoutrgbe.1 DESTINATION ${MAN_DIR})
+# This file is not in the distribution, so leave it out
+# install (FILES pfsoutrgbe.1 DESTINATION ${MAN_DIR})
 
 add_executable(pfsinpfm pfsinpfm.cpp "${GETOPT_OBJECT}")
 target_link_libraries(pfsinpfm pfs)


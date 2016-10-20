class Treefrog < Formula
  desc "High-speed C++ MVC Framework for Web Application"
  homepage "http://www.treefrogframework.org/"
  url "https://github.com/treefrogframework/treefrog-framework.git", :tag => "v1.13.0", :revision => "dad8d4bbb4ae0bfb480352fde3ba5dd1321ccff8"
  head "https://github.com/treefrogframework/treefrog-framework.git", :branch => "master"

  depends_on MinimumMacOSRequirement => :el_capitan
  depends_on XcodeRequirement => [:build, :version => ">= 8.0"]
  depends_on "qt5" => ["with-mysql", "with-oci", "with-postgresql"]

  def install
    system "./configure", "--prefix=#{prefix}"

    cd "src" do
      system "make"
      system "make", "install"
    end

    cd "tools" do
      system "make"
      system "make", "install"
    end
  end

  test do
    cd "src/test" do
      system "qmake"
      system "make", "test"
    end
  end
end

require 'formula'

class Less < Formula
  homepage 'http://www.greenwoodsoftware.com/less/index.html'
  url 'http://www.greenwoodsoftware.com/less/less-458.tar.gz'
  sha1 'd5b07180d3dad327ccc8bc66818a31577e8710a2'

  devel do
    url "http://greenwoodsoftware.com/less/less-471.tar.gz"
    sha1 "0d030b56f3f9c3ed68c6498876a27e0cac430538"
  end

  depends_on 'pcre' => :optional

  def install
    args = ["--prefix=#{prefix}"]
    args << '--with-regex=pcre' if build.with? 'pcre'
    system "./configure", *args
    system "make install"
  end

  test do
    system "#{bin}/lesskey", "-V"
  end
end

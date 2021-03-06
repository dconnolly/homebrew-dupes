class Openldap < Formula
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.40.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.40.tgz"
  sha256 "d12611a5c25b6499293c2bb7b435dc2b174db73e83f5a8cb7e34f2ce5fa6dadb"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    sha256 "de52a960935389bd7f4e4c17f782b58fd858eff58df846318cb7807995b4b584" => :yosemite
    sha256 "b5bc20d247fcfeba62dffa1a9519891a2cf68b93932338cdf75a63b2609494f1" => :mavericks
    sha256 "2fca33328cf2f9ef1abb70414265bb00cb31f3f81d742c6d5606720b487da5f7" => :mountain_lion
  end

  depends_on "berkeley-db" => :optional
  depends_on "openssl"

  option "with-memberof", "Include memberof overlay"
  option "with-unique", "Include unique overlay"
  option "with-sssvlv", "Enable server side sorting and virtual list view"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    args << "--enable-bdb=no" << "--enable-hdb=no" if build.without? "berkeley-db"
    args << "--enable-memberof" if build.with? "memberof"
    args << "--enable-unique" if build.with? "unique"
    args << "--enable-sssvlv=yes" if build.with? "sssvlv"

    system "./configure", *args
    system "make", "install"
    (var+"run").mkpath

    # https://github.com/Homebrew/homebrew-dupes/pull/452
    chmod 0755, Dir[etc/"openldap/*"]
    chmod 0755, Dir[etc/"openldap/schema/*"]
  end
end

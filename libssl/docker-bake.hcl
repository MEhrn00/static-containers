variable "openssl-version" {
  default = "3.2.1"
}

variable "openssl-sha256sum" {
  default = "83c7329fe52c850677d75e5d0b0ca245309b97e8ecbcfdc1dfdc4ab9fac35b39"
}

variable "registry-url" {
  default = "docker.io/mehrn00/libssl-static"
}

group "all" {
  targets = [
    "linux-x86_64",
    "linux-x86",
    "mingw64",
    "mingw",
  ]
}

group "linux-group" {
  targets = [
    "linux-x86_64",
    "linux-x86",
  ]
}

group "mingw-group" {
  targets = [
    "mingw64",
    "mingw",
  ]
}

target "base" {
  dockerfile = "base.dockerfile"
  args = {
    OPENSSL_VERSION = "${openssl-version}"
    OPENSSL_HASH    = "${openssl-sha256sum}"
  }

  tags = [
    "${registry-url}:${target.base.name}-${openssl-version}"
  ]
}

target "linux-x86_64" {
  dockerfile = "build.dockerfile"
  contexts = {
    base = "target:base"
  }

  args = {
    TARGET = "${target.linux-x86_64.name}"
  }

  tags = [
    "${registry-url}:${target.linux-x86_64.name}-${openssl-version}"
  ]

  output = ["."]
}

target "linux-x86" {
  dockerfile = "build.dockerfile"
  contexts = {
    base = "target:base"
  }

  args = {
    TARGET = "${target.linux-x86.name}"
  }

  tags = [
    "${registry-url}:${target.linux-x86.name}-${openssl-version}"
  ]

  output = ["."]
}

target "mingw64" {
  dockerfile = "build.dockerfile"
  contexts = {
    base = "target:base"
  }

  args = {
    TARGET = "${target.mingw64.name}"
    CC     = "x86_64-w64-mingw32-gcc"
    CXX    = "x86_64-w64-mingw32-g++"
    AR     = "x86_64-w64-mingw32-ar"
    RANLIB = "x86_64-w64-mingw32-ranlib"
    RC     = "x86_64-w64-mingw32-windres"
  }

  tags = [
    "${registry-url}:${target.mingw64.name}-${openssl-version}"
  ]

  output = ["."]
}

target "mingw" {
  dockerfile = "build.dockerfile"
  contexts = {
    base = "target:base"
  }

  args = {
    TARGET = "${target.mingw.name}"
    CC     = "i686-w64-mingw32-gcc"
    CXX    = "i686-w64-mingw32-g++"
    AR     = "i686-w64-mingw32-ar"
    RANLIB = "i686-w64-mingw32-ranlib"
    RC     = "i686-w64-mingw32-windres"
  }

  tags = [
    "${registry-url}:${target.mingw.name}-${openssl-version}"
  ]

  output = ["."]
}

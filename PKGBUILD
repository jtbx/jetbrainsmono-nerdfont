# Maintainer: Jeremy Baxter <jeremytbaxter@protonmail.com>
pkgname=ttf-jetbrains-mono-nerdfont
pkgrel=1
pkgdesc="Typeface for developers, by JetBrains (Patched Nerd Font)"
arch=(any)
url="https://github.com/jtbx/jetbrainsmono-nerdfont"
license=('custom')
makedepends=('git')
source=('jetbrainsmono-ttf::git://github.com/jtbx/jetbrainsmono-nerdfont')
md5sums=('SKIP')

pkgver() {
	cd "jetbrainsmono-ttf"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
	cd "jetbrainsmono-ttf"
	sudo cp ttf/* /usr/share/fonts/TTF/
	sudo fc-cache -fv
}

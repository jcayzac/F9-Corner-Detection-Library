#!/usr/bin/env bash
set -e

SRC="$1"
echo -n "$SRC"
[ -f "$SRC" ]
DIMENSIONS=($(identify -format "%w %h" "$SRC"))
(( ${#DIMENSIONS[@]} == 2 ))
WIDTH=${DIMENSIONS[0]}
HEIGHT=${DIMENSIONS[1]}

cat > "${SRC}.cpp" <<EOT
#include <iostream>
#include <algorithm>

void save_8bpp_image_as_PGM(
    std::ostream& out,
    const unsigned char* image_data,
    size_t width,
    size_t height,
    size_t bytes_per_row
) {
    out << "P2\n" << width << " " << height << "\n255\n";

    for(size_t y(0); y < height; ++y, out << "\n")
        for(size_t x(0); x < width; ++x, out << " ")
            out << (int) image_data[y * bytes_per_row + x] << " ";
}

#include "f9.h"
#include "strings.h"

#define W $WIDTH
#define H $HEIGHT
#define S $WIDTH

static const unsigned char data[] = {
$(convert "$SRC" -depth 8 gray:- | xxd -i)
};

int main() {
    F9 f9;
    const std::vector<F9_CORNER>& corners = f9.detectCorners(
        data,
        W,
        H,
        S,
        20,
        true
    );
    unsigned char* out = new unsigned char[S*H];
    memset(out, 255, S*H);
    for (int i=0; i<(int)corners.size(); ++i)
        out[corners[i].y * S + corners[i].x] = 0;
    save_8bpp_image_as_PGM(std::cout, out, W, H, S);
    delete[] out;
    return 0;
}
EOT

: ${CXX:=g++}
$CXX -I. -m64 -minline-all-stringops -O3 -fvisibility-inlines-hidden -fvisibility=hidden -Wall -o "${SRC}.exe" "${SRC}.cpp" f9.cpp
RESULT=$("${SRC}.exe" | shasum -b | cut -d\  -f1)
RC=0
if [ -f "${SRC}.expected" ]
then
	EXPECTED=$(cat "${SRC}.expected")
	if [ "$RESULT" == "$EXPECTED" ]
	then
		RESULT="OK"
	else
		RESULT="FAILED"
		RC=1
	fi
fi



echo " $RESULT"
exit $RC
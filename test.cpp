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
#include "testpic.h"
#include "strings.h"

#define W 331
#define H 331
#define S 336

int main() {
	F9 f9;
	const std::vector<F9_CORNER>& corners = f9.detectCorners(
	    testpic_331x331_gray,
	    W,
	    H,
	    S,
	    80,
	    true
	);
	std::cerr << "Found " << corners.size() << " corners.\n";
	unsigned char* out = new unsigned char[S*H];
	memset(out, 255, S*H);
	for (int i=0; i<corners.size(); ++i)
		out[corners[i].y * S + corners[i].x] = 0;
	save_8bpp_image_as_PGM(std::cout, out, W, H, S);
	delete[] out;
	return 0;
}

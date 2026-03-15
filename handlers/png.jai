#import "Jay_Render";
#import "Basic";
#import "stb_image";

import :: (in: string) -> Image_Data {
    result: Image_Data;

    result.pixels.data = xx stbi_load(in.data, *result.width, *result.height, *result.channels, 4);
    result.pixels.count = xx (result.width * result.height);

    return result;
}

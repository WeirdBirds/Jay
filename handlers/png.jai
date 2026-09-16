#import "Jay_Math";
#import "Basic";
#import "stb_image";
#import "Jay_Render";

import :: (in: string) -> Image_Data {
    result: Image_Data;

    result.pixels.data  = xx stbi_load(in.data, *result.width, *result.height, *result.channels, 4);
    result.pixels.count = xx (result.width * result.height);

    for * result.pixels
        it.rgb *= U8_MAX/it.a;

    return result;
}

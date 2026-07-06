#import "File";
#import "Basic";
#import "Jay_Render";

import :: (in: string) -> Shader_Text {
    return .{ read_entire_file(in) };
}

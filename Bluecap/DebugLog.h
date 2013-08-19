//
//  DebugLog.h
//  BlueCap
//
//  Created by Troy Stribling on 8/18/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#ifndef BlueCap_DebugLog_h
#define BlueCap_DebugLog_h

void DebugLog(NSString *format, ...);
#define DLog(__FORMAT__, ...) DebugLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif

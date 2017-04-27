//
//  NSObject+Extent.h
//  XF
//
//  Created by zyb-frank  on 17/4/6.
//  Copyright © 2017年 free. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extent)
- (id)valueForUndefinedKey:(NSString *)key;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

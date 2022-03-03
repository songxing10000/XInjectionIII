//
//  InjectionIIIHelper.h
//  qwzw
//
//  Created by dfpo on 2020/12/14.
//

#import <Foundation/Foundation.h>

#ifdef TARGET_IPHONE_SIMULATOR

@interface InjectionIIIHelper : NSObject

@end

@interface NSObject (OKRuntime)
/**
 *  @brief 交换实例方法实现
 *
 *  @param originalMethod 原始方法实现
 *  @param newMethod      新方法实现
 */
+ (BOOL)ok_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;
@end
#endif

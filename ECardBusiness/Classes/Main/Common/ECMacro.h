//
//  ECMacro.h
//  Ecard
//
//  Created by yongsheng.jiang on 2018/1/10.
//  Copyright © 2018年 bige. All rights reserved.
//

#pragma mark UIColor
#define force_inline __inline__ __attribute__((always_inline))
// example usage: UIColorFromHex(0x9daa76)
static force_inline UIColor *UIColorFromHexWithAlpha(int hexValue, CGFloat a) {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a];
}

static force_inline UIColor *UIColorFromHex(int hexValue) {
    return UIColorFromHexWithAlpha(hexValue, 1.0);
}

static force_inline UIColor *UIColorFromRGBA(int r, int g, int b, CGFloat a) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

static force_inline UIColor *UIColorFromRGB(int r, int g, int b) {
    return UIColorFromRGBA(r, g, b, 1.0);
}

// 通用字体颜色
#define UIColorMain_Highlighted UIColorFromHex(0x35519f)
#define UIColorMain_Normal UIColorFromHex(0x666666)
#define UIColorMain_Gray UIColorFromHex(0x333333)
#define UIColorMain_Bg UIColorFromRGB(242,246,250)
#define UIColorMain_line UIColorFromHex(0xEAEAEA)
#define RLMargin 15


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS11_OR_LATER_SPACE(par) \
({\
float space = 0.0;\
if (@available(iOS 11.0, *))\
space = par;\
(space);\
})


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// safeArea 底部空白高度
#define SAFEAREA_BOTTOM_SPACE IOS11_OR_LATER_SPACE([[UIApplication sharedApplication].windows.firstObject safeAreaInsets].bottom)
// safeArea 状态栏高度
#define SAFEAREA_TOP_SPACE IOS11_OR_LATER_SPACE([[UIApplication sharedApplication].windows.firstObject safeAreaInsets].top)
// safeArea 状态栏增加的高度
#define SAFEAREA_TOP_ACTIVE_SPACE IOS11_OR_LATER_SPACE(MAX(0, SAFEAREA_TOP_SPACE - 20))
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (64.f + SAFEAREA_TOP_ACTIVE_SPACE)

/**
 Returns a dispatch_time delay from now.
 */
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time delay from now.
 */
static inline dispatch_time_t dispatch_walltime_delay(NSTimeInterval second) {
    return dispatch_walltime(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}


/**
 Whether in main queue/thread.
 */
static inline bool dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}



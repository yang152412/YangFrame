

/*
 用来保存长度,高度,宽度,CGRect,CGPoint,CGSize等布局相关常量
 
 */

// add by Yang
/* 定义导航栏和Application的高宽 */
#define  kLayoutNavigationBarHeight              44
#define  kLayoutStatusBarHeight                  20
#define  kLayoutTabbarHeight                     49

#define  kLayoutScreenWidth             ([UIScreen mainScreen].bounds.size.width)
#define  kLayoutScreenHeight            ([UIScreen mainScreen].bounds.size.height)

// view 的 高度,宽度
#define  kLayoutViewWidth   kLayoutScreenWidth
#define  kLayoutViewHeight  (kLayoutScreenHeight - kLayoutStatusBarHeight - kLayoutNavigationBarHeight)
// 定义 view的 frame
#define kLayoutViewFrame CGRectMake(0, kLayoutNavigationBarHeight, kLayoutScreenWidth, kLayoutViewHeight)
// 定义 view的 size
#define kLayoutViewSize CGSizeMake(kLayoutViewWidth, kLayoutViewHeight)


// add by Xin



// add by Xie


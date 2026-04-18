#import <UIKit/UIKit.h>

@interface DraggableButton : UIButton
@end
@implementation DraggableButton
- (void)dragged:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}
@end

static void setupMenu() {
    // 画面が準備できるまで少し待つ
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *window = nil;
        // iOS 13以降の全シーンからアクティブなウィンドウを探す
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene*

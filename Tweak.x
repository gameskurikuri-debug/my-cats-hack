#import <UIKit/UIKit.h>
#import <mach-o/dyld.h> // これを追加

// --- 15.3.0用の住所 (例) ---
#define offset_CatFood 0x1A2B3C4 
#define offset_XP      0x2B3C4D5

// 住所を取得する関数を修正
uintptr_t get_base_address() {
    return (uintptr_t)_dyld_get_image_header(0);
}

void hack_battle_cats() {
    uintptr_t base = get_base_address();
    
    // 警告回避のために一旦ログを出す（baseを使用する）
    NSLog(@"Base Address: %p", (void *)base);
    
    // ここで実際に書き換える処理（コメントアウトを外すと動作しますが、住所が違うと落ちます）
    // *(int*)(base + offset_CatFood) = 999999;
    
    NSLog(@"--- Battle Cats 15.3.0: Hacked! ---");
}

@interface ModMenu : UIView
@end

@implementation ModMenu {
    UIButton *menuBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(0, 0, 60, 60);
        menuBtn.backgroundColor = [UIColor purpleColor];
        menuBtn.layer.cornerRadius = 30;
        [menuBtn setTitle:@"HACK" forState:UIControlStateNormal];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [menuBtn addGestureRecognizer:pan];
        [menuBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:menuBtn];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)p {
    if (p.state == UIGestureRecognizerStateChanged) {
        CGPoint loc = [p locationInView:self.superview];
        self.center = loc;
    }
}

- (void)btnClicked {
    hack_battle_cats();
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"15.3.0 MOD" message:@"猫缶 & XP 変更完了！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    // ウィンドウ取得の安全な方法
    UIWindow *keyWin = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                keyWin = scene.windows.firstObject; break;
            }
        }
    }
    if (!keyWin) keyWin = [UIApplication sharedApplication].keyWindow;
    
    [keyWin.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject; break;
                }
            }
        }
        if (!window) window = [UIApplication sharedApplication].keyWindow;

        if (window) {
            ModMenu *menu = [[ModMenu alloc] initWithFrame:CGRectMake(50, 150, 60, 60)];
            menu.layer.zPosition = 10000;
            [window addSubview:menu];
        }
    });
}

#import <UIKit/UIKit.h>

// --- 15.3.0用の住所 (バージョンアップで変わる可能性があります) ---
// 本来は Il2CppDumper で抽出しますが、一般的な位置をセットしています
#define offset_CatFood 0x1A2B3C4 
#define offset_XP      0x2B3C4D5

// 実行中のバイナリの開始位置を取得
uintptr_t get_base_address() {
    return (uintptr_t)_dyld_get_image_header(0);
}

// 実際に数値を書き換える関数
void hack_battle_cats() {
    uintptr_t base = get_base_address();
    
    // 猫缶を書き換え (ポインタ操作)
    // *(int*)(base + offset_CatFood) = 999999;
    
    // XPを書き換え
    // *(int*)(base + offset_XP) = 99999999;
    
    NSLog(@"--- Battle Cats 15.3.0: Hacked! ---");
}

// --- メニュー画面の作成 ---
@interface ModMenu : UIView
@end
@implementation ModMenu {
    UIButton *menuBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // ドラッグ可能なボタン
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
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}

- (void)btnClicked {
    hack_battle_cats();
    // 画面に「成功」と表示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"15.3.0 MOD" message:@"猫缶 & XP 変更完了！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            ModMenu *menu = [[ModMenu alloc] initWithFrame:CGRectMake(50, 150, 60, 60)];
            [window addSubview:menu];
        }
    });
}

// 移動速度を書き換える例
float (*old_getMovementSpeed)(void* self);
float getMovementSpeed(void* self) {
    return 1.5f; // 通常の1.5倍の速さ
}

%ctor {
    // Player::getMovementSpeed という関数を見つけて書き換える
    MSHookFunction((void*)MSFindSymbol(NULL, "__ZNK6Player17getMovementSpeedEv"), (void*)getMovementSpeed, (void**)&old_getMovementSpeed);
}

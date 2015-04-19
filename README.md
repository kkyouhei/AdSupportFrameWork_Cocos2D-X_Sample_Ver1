## 注意点

### Cocos2D-X ver 3.3

#### CCEAGLView.hが存在しない
proj.ios_mac/ios/AppController.mm内でimportしているCCEAGLView.hが存在しないためビルドエラーになる。  
そのため下記のようにimportするヘッダファイルを変更する

``` AppController.mm
#import "CCEAGLView-ios.h"
```

#### GLViewの生成方法が変更
Cocos2D-x ver3.3からGLViewのインスタンスの生成方法が変わったらしい。
そのためproj.ios_mac/ios/AppController.mmの77行目でインスタンスを生成している箇所を下記のように変更する必要がある

``` AppController.mm
cocos2d::GLView *glview = cocos2d::GLViewImpl::createWithEAGLView(eaglView);
```

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button("start service")
          .onClick(()=>{
            // router.pushUrl({ url: 'pages/Second' })
            let that = this
            this.message = "start click"
            let want = {
              "deviceId": "",
              "bundleName": "com.acts.uiextensionservice",
              "abilityName": "TestServiceExtAbility"
            };

            try {
              globalThis.context2.startServiceExtensionAbility(want)
                .then(() => {
                  // 执行正常业务
                  console.info('startServiceExtensionAbility succeed');
                  that.message = "startServiceExtensionAbility succeed"
                })
                .catch((err) => {
                  // 处理业务逻辑错误
                  console.info(`startServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`);
                  that.message = "startServiceExtensionAbility failed, code is" + err.code + "message = " + err.message
                });
            } catch (err) {
              // 处理入参错误异常
              console.error(`startServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`);
              that.message = "startServiceExtensionAbility failed, code is" + err.code + "message = " + err.message
            }
          })
          .margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
}
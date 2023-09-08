import router from '@ohos.router'

@Entry
@Component
struct Start {
  @State message: string = 'Start Page'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Button("back")
          .onClick(()=>{
            router.back();
          })
          .margin(10)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Red)
  }
}
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        UIExtensionComponent({
          bundleName: "com.example.myapplication",
          abilityName: "UIExtAbility"
        }).width('100%').height('50%')
      }
      .width('100%')
    }
    .height('100%')
  }
}
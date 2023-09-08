// Index.ets
// 导入页面路由模块
import router from '@ohos.router';
import UIExtensionContentSession from '@ohos.app.ability.UIExtensionContentSession'
import IdlServiceExtProxy from '../IdlServiceExt/idl_service_ext_proxy';
import SubServiceExtProxy from '../IdlServiceExt/SubService/sub_service_ext_proxy';
import MultipServiceExtProxy from '../IdlServiceExt/MultipService/multip_service_ext_proxy';
let storage = LocalStorage.GetShared();
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  private context: any = getContext(this)
  private session: UIExtensionContentSession = storage.get<UIExtensionContentSession>('session');
  private nums1:number = 101;
  private nums2:number = 202;
  private connectid = -1;
  private serviceExtProxy = null;
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Button("terminate self")
          .onClick(async ()=>{

            this.session.terminateSelf().then((data)=>{
              console.log("terminateSelfPromise : " + JSON.stringify(data));
            }).catch((err)=>{
              console.log("terminateSelfPromise : " + JSON.stringify(err));
            })
            // console.log("---start")
            // await globalThis.context2.startAbility(
            //   {
            //     bundleName: 'com.example.uiextensionprovider',
            //     abilityName: 'EntryAbility'
            //   })
            // console.log("---end")
            // return;
            // let that = this
            // // router.pushUrl({url:"pages/p2"});
            // this.message = "dis connect click,disConn id = " + this.connectid;
            // // globalThis.context2.disconnectServiceExtensionAbility(this.connectid);
            // // try {
            // //   globalThis.context2.disconnectServiceExtensionAbility(5).then(() => {
            // //     console.info('3 disconnect success..');
            // //     that.message = 'disconnect success..'
            // //   }).catch((err) => {
            // //     console.error(`3 disconnectServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`);
            // //     that.message = 'disconnect fail..' + err.code + ' msg = '+ err.message
            // //   });
            // // } catch (err) {
            // //   that.message ='catch2 err = ' + err.code + 'msg = ' + err.message;
            // // }
            //
            // try {
            //   this.context.disconnectServiceExtensionAbility(this.connectid,(err) => {
            //     if (err.code) {
            //       // 处理业务逻辑错误
            //       that.message = `failed, code is ${err.code}, message is ${err.message}`
            //       return;
            //     }
            //     // 执行正常业务
            //     that.message = 'disconnectServiceExtensionAbility succeed';
            //   },123);
            // } catch (err) {
            //   // 处理入参错误异常
            //   that.message = `disconnectServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`
            // }
            // globalThis.context2.disconnectServiceExtensionAbility(null).then(() => {
            //   console.info('3 disconnect success..');
            //   that.message = 'disconnect success..'
            // }).catch((err) => {
            //   console.error(`3 disconnectServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`);
            //   that.message = 'disconnect fail..' + err.code + ' msg = '+ err.message
            // });
            // that.message = " over "
          })
          .margin(10)
        Button("dis connect")
          .onClick(()=>{
            let that = this
            try {
              this.context.disconnectServiceExtensionAbility(this.connectid,(err) => {
                if (err.code) {
                  // 处理业务逻辑错误
                  that.message = `failed, code is ${err.code}, message is ${err.message}`
                  return;
                }
                // 执行正常业务
                that.message = 'disconnectServiceExtensionAbility succeed';
                console.info('disconnectServiceExtensionAbility succeed___')
              },123);
            } catch (err) {
              // 处理入参错误异常
              that.message = `disconnectServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`
            }

          })
          .margin(10)
        Button("call service")
          .onClick(()=>{
            let that = this

            if (this.serviceExtProxy === null){
              this.message = "press connect button first"
              // this.message = this.serviceExtProxy
            }else {

              this.serviceExtProxy.add(that.nums1, that.nums2, (errorCode, retVal) => {
                console.info(`ret: ${errorCode}, retVal: ${retVal}`);
                that.message = that.nums1 + " + " + that.nums2 + ' = ' + retVal + ''
                // that.message = typeof retVal;
              });
            }
          })
          .margin(10)
        Button("connect service")
          .onClick(async ()=>{
            // router.pushUrl({ url: 'pages/Second' })
            let that = this
            this.message = "conn click"
            let want = {
              "bundleName": "com.example.uiextensionprovider",
              "abilityName": "TestServiceExtAbility"
            };
            // let want2 = {
            //   "bundleName": "com.acts.uiextensionservice",
            //   "abilityName": "SubServiceExtAbility"
            // };
            let options = {
              onConnect(elementName, remote) {
                console.info('connect callback___');
                that.serviceExtProxy = new IdlServiceExtProxy(remote);
                that.message = "connect success id = " + that.connectid;
              },
              onDisconnect(elementName) {
                console.info('onDisconnect callback___')
                that.message = 'onDisconnect'
              },
              onFailed(code) {
                console.info('onFailed callback___')
                that.message = 'onfailed'
              }
            }
            // await globalThis.context2.startAbility(
            //   {
            //     bundleName: 'com.example.uiextensionprovider',
            //     abilityName: 'EntryAbility'
            //   })
            // // await this.sleep(2000)
            this.connectid = globalThis.context2.connectServiceExtensionAbility(want, options);
            // // this.connectid = globalThis.context2.connectServiceExtensionAbility(want2, options);
            // await this.sleep(2000); // 等待 2000 毫秒（2秒）
            // globalThis.context2.disconnectServiceExtensionAbility(this.connectid, (err) => {
            //   if (err.code) {
            //     console.info('disconnectServiceExtensionAbility fail___');
            //     return;
            //   }
            //   console.info('disconnectServiceExtensionAbility succeed___');
            // });

            // let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
            // that.message = "shut down start";
            // await abilityDelegator.executeShellCommand("uinput -K -d 18 -u 18").then((data)=>{
            //   that.message = "shut down";
            // }).catch((error)=>{
            //   that.message = "shut down error";
            // })

            // await this.sleep(150); // 等待 2000 毫秒（2秒）
            // this.session.terminateSelf().then((data)=>{
            //   console.log("terminateSelfPromise : " + JSON.stringify(data));
            // }).catch((err)=>{
            //   console.log("terminateSelfPromise : " + JSON.stringify(err));
            // })
          })
          .margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
  sleep(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}

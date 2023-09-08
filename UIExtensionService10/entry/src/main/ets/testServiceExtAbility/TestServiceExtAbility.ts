import ServiceExtension from '@ohos.app.ability.ServiceExtensionAbility'
import IdlServiceExtStub from '../IdlServiceExt/idl_service_ext_stub';
import { addCallback } from '../IdlServiceExt/i_idl_service_ext';
import Logger from '../util/Logger';

class ServiceExtStub extends IdlServiceExtStub{

  add(num1: number, num2: number, callback: addCallback): void{
      let res = num1 + num2
      callback(0,res)
      Logger.info(`add result: ${res}`)
  }
}

let connectid = -1;
export default class TestServiceExtAbility extends ServiceExtension {

  onCreate(want) {
    Logger.info(`onCreate, want1___: ${want.abilityName}`)
  }

  onRequest(want, startId) {
    Logger.info(`onRequest, want1___: ${want.abilityName}`)
  }

  onConnect(want) {
    // let want3 = {
    //   "bundleName": "com.acts.uiextensionservice",
    //   "abilityName": "SubServiceExtAbility"
    // };
    // let options = {
    //   onConnect(elementName, remote) {
    //     /* 此处的入参remote为ServiceExtensionAbility在onConnect生命周期回调中返回的对象,
    //      * 开发者通过这个对象便可以与ServiceExtensionAbility进行通信，具体通信方式见下文
    //      */
    //     console.info('service inner onConnect callback......');
    //   },
    //   onDisconnect(elementName) {
    //     console.info('service inner onDisconnect callback___')
    //   },
    //   onFailed(code) {
    //     console.info('service inner onFailed callback___')
    //   }
    // }
    // 建立连接后返回的Id需要保存下来，在解绑服务时需要作为参数传入
    // connectid = this.context.connectServiceExtensionAbility(want3, options);
    Logger.info(`onConnect , want1___: ${want.abilityName}`)
    // setTimeout(async () => {
    //   this.context.terminateSelf();
    //   console.info('terminateSelf___');
    // }, 500);
    return new ServiceExtStub("add service stub")
  }

  async onDisconnect(want) {
    // this.context.disconnectServiceExtensionAbility(connectid)
    Logger.info(`onDisconnect, want1___: ${want.abilityName}`)
    // try {
    //   this.context.disconnectServiceExtensionAbility(connectid)
    // } catch (err) {
    //   // 处理入参错误异常
    //   Logger.info( `___disconnectServiceExtensionAbility failed, code is ${err.code}, message is ${err.message}`)
    // }
    await this.sleep(150); // 等待 2000 毫秒（2秒）
    Logger.info(`onDisconnect, want1___: ${want.abilityName}`)

  }

  sleep(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  onDestroy() {
    Logger.info(`onDestroy service1___`)
  }
}
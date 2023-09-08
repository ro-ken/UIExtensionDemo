import UIExtensionAbility from '@ohos.app.ability.UIExtensionAbility'
import Logger from '../model/Logger'

const TAG: string = '[UIExtAbility2]'

export default class UIExtAbility extends UIExtensionAbility {
  onCreate() {
    Logger.log(TAG, `UIExtAbility onCreate`)
    globalThis.context2 = this.context;
  }

  onForeground() {
    Logger.log(TAG, `UIExtAbility onForeground`)
  }

  
  onBackground() {
    Logger.log(TAG, `UIExtAbility onBackground`)
  }

  onDestroy() {
    Logger.log(TAG, `UIExtAbility onDestroy`)
  }

  onSessionCreate(want, session) {
    Logger.log(TAG, `UIExtAbility onSessionCreate, want: ${JSON.stringify(want)}`)
    let storage: LocalStorage = new LocalStorage({
      'session': session
    });
    session.loadContent('pages/Index', storage);
    let color = '#00ff33';
    try {
      session.setWindowBackgroundColor(color);
    } catch (exception) {
      console.error('Failed to set the background color. Cause: ' + JSON.stringify(exception));
    }
    let isPrivacyMode = true;
    try {
      session.setWindowPrivacyMode(isPrivacyMode, (err) => {
        if (err) {
          console.error('Failed to set the window to privacy mode. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in setting the window to privacy mode.');
      });
    } catch (exception) {
      console.error('Failed to set the window to privacy mode. Cause:' + JSON.stringify(exception));
    }
  }

  onSessionDestroy(session) {
    Logger.log(TAG, `UIExtAbility onSessionDestroy`)
  }
};

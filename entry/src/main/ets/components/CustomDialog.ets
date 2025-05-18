// PromptActionClass.ets
import { BusinessError } from '@kit.BasicServicesKit';
import { ComponentContent, promptAction } from '@kit.ArkUI';
import { UIContext } from '@ohos.arkui.UIContext';


export class CustomDialog {
  static ctx: UIContext;
  static contentNode: ComponentContent<Object>;
  static options: promptAction.BaseDialogOptions;


  static setContext(context: UIContext) {
    CustomDialog.ctx = context;
  }


  static setContentNode(node: ComponentContent<Object>) {
    CustomDialog.contentNode = node;
  }


  static setOptions(options: promptAction.BaseDialogOptions) {
    CustomDialog.options = options;
  }


  static openDialog() {
    if (CustomDialog.contentNode !== null) {
      CustomDialog.ctx.getPromptAction().openCustomDialog(CustomDialog.contentNode, CustomDialog.options)
        .then(() => {
          console.info('OpenCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`OpenCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }


  static closeDialog() {
    if (CustomDialog.contentNode !== null) {
      CustomDialog.ctx.getPromptAction().closeCustomDialog(CustomDialog.contentNode)
        .then(() => {
          console.info('CloseCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`CloseCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }


  static updateDialog(options: promptAction.BaseDialogOptions) {
    if (CustomDialog.contentNode !== null) {
      CustomDialog.ctx.getPromptAction().updateCustomDialog(CustomDialog.contentNode, options)
        .then(() => {
          console.info('UpdateCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`UpdateCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }
}
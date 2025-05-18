import { ComponentContent } from '@kit.ArkUI';
import { CustomDialog } from "../components/CustomDialog";

class Params {
  title: string = ''
  content: string = ''

  constructor(title: string, content: string) {
    this.title = title;
    this.content = content;
  }
}

@Builder
function buildText(params: Params) {
  Column() {
    Text(params.title)
      .fontSize(25)
      .fontWeight(FontWeight.Bold)
      .margin({ bottom: 10, top: 10 })
    Text(params.content)
      .fontSize(20)
      .margin({ bottom:10 })
    Button('Close')
      .onClick(() => {
        CustomDialog.closeDialog()
      })
      .margin({ bottom: 10 })
  }
  .backgroundColor(Color.Grey)
  .width('60%')
}

@Component
export struct customDialogPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @LocalStorageLink('prop1') prop1: string = '';
  message: string = "hello"
  content: string = 'this is a custon dialog test'
  private ctx: UIContext = this.getUIContext();
  private contentNode: ComponentContent<Object> = new ComponentContent(this.ctx, wrapBuilder(buildText), new Params(this.message, this.content));

  aboutToAppear(): void {
    CustomDialog.setContext(this.ctx);
    CustomDialog.setContentNode(this.contentNode);
    CustomDialog.setOptions({ alignment: DialogAlignment.Top, offset: { dx: 0, dy: 50 } });
  }

  build() {
    NavDestination() {
      Column() {
        Text(this.prop1)
        Button('change prop1')
          .onClick(() => {
            this.prop1 = 'hello Ivan'
          })
          .backgroundColor(Color.Yellow)
          .fontColor(Color.Black)

        Button("open dialog and update options")
          .margin({ top: 50 })
          .onClick(() => {
            this.contentNode.update(new Params(this.message, this.content))
            CustomDialog.openDialog()

            setTimeout(() => {
              CustomDialog.updateDialog({
                alignment: DialogAlignment.Bottom,
                offset: { dx: 0, dy: -50 }
              })
            }, 1500)
          })
        Button("open dialog and update content")
          .margin({ top: 50 })
          .onClick(() => {
            this.contentNode.update(new Params(this.message, this.content))
            CustomDialog.openDialog()

            setTimeout(() => {
              this.contentNode.update(new Params('update', 'test finish'))
            }, 1500)
          })
      }.width('100%').height('100%')
    }.title("自定义弹窗")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
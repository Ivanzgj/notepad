import { hilog } from "@kit.PerformanceAnalysisKit";

const TAG = 'MenuPage'
const Domain = 1

@Component
export struct MenuPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State select: boolean = true

  @Builder
  SubMenu() {
    Menu() {
      MenuItem({ content: "复制", labelInfo: "Ctrl+C" })
        .onClick(() => {
          this.getUIContext().showAlertDialog(
            {
              title: '复制',
              message: '你要复制个啥？',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              buttons: [
                {
                  enabled: true,
                  defaultFocus: true,
                  style: DialogButtonStyle.HIGHLIGHT,
                  value: '不知道',
                  action: () => {
                    console.info('oops')
                  }
                }],
            }
          )
        })
      MenuItem({ content: "粘贴", labelInfo: "Ctrl+V" })
        .onClick(() => {
          this.getUIContext().showAlertDialog(
            {
              title: '粘贴',
              message: '你要粘贴啥？',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              buttons: [
                {
                  enabled: true,
                  defaultFocus: true,
                  style: DialogButtonStyle.HIGHLIGHT,
                  value: '不知道',
                  action: () => {
                    console.info('oooooops')
                  }
                }],
            }
          )
        })
    }
  }

  @Builder
  MyMenu() {
    Menu() {
      MenuItem({ startIcon: $r("app.media.little_menu_setting"), content: "菜单选项1" })
      MenuItem({ startIcon: $r("app.media.little_menu_setting"), content: "菜单选项2" }).enabled(false)
      MenuItem({
        startIcon: $r("app.media.little_menu_setting"),
        content: "菜单选项3",
        endIcon: $r("app.media.little_right_arrow"),
        // 当builder参数进行配置时，表示与menuItem项绑定了子菜单。鼠标hover在该菜单项时，会显示子菜单。
        builder: this.SubMenu
      })
      MenuItemGroup({ header: '菜单组' }) {
        MenuItem({ content: "菜单选项4" })
          .selectIcon(true)
          .selected(this.select)
          .onChange((selected) => {
            console.info("menuItem select" + selected);
          })
        MenuItem({
          startIcon: $r("app.media.little_menu_setting"),
          content: "菜单选项5",
          endIcon: $r("app.media.little_right_arrow"),
          builder: this.SubMenu
        })
      }

      MenuItem({
        startIcon: $r("app.media.little_menu_setting"),
        content: "菜单选项6",
        endIcon: $r("app.media.little_right_arrow")
      })
    }
  }

  build() {
    NavDestination() {
      RelativeContainer() {
        Button('default style menu')
          .bindMenu([
            {
              value: 'option1',
              action: () => {
                hilog.info(Domain, TAG, 'option1 in default style menu')
              }
            },
            {
              value: 'option2',
              action: () => {
                hilog.info(Domain, TAG, 'option2 in default style menu')
              }
            }
          ])
          .backgroundColor(Color.Green)
          .id('button1')
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .margin({ top: 10})
        Divider()
          .margin({ top: 10, bottom: 10, left: 5, right: 5})
          .color(Color.Grey)
          .id('divider1')
          .alignRules({
            top: { anchor: 'button1', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
        Button('custom style menu')
          .bindMenu(this.MyMenu())
          .id('button2')
          .alignRules({
            top: { anchor: 'divider1', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
        Button('long press menu')
          .bindContextMenu(this.MyMenu(), ResponseType.LongPress)
          .alignRules({
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .offset({ y: -20 })
      }
      .id('menuParentColumn')
      .height('100%')
      .width('100%')
      .backgroundColor(Color.Grey)
    }
    .title('弹出菜单')
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
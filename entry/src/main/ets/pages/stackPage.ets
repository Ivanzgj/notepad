@Component
export struct StackPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  private arr: string[] = ['APP1', 'APP2', 'APP3', 'APP4', 'APP5', 'APP6', 'APP7', 'APP8', 'APP9'];
  private scroller : Scroller = new Scroller();

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll(this.scroller) {
          Column() {
            ForEach(this.arr, (item: string) => {
              Text(item)
                .width(200)
                .height(200)
                .fontSize(16)
                .margin(10)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }, (item: string): string => item)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%').height('100%')
        .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
        .scrollBar(BarState.Auto) // 滚动条自动显示
        .scrollBarColor(0xeeeeee) // 滚动条颜色
        .scrollBarWidth(3) // 滚动条宽度
        .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹

        Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
          Text('联系人').fontSize(16)
          Text('设置').fontSize(16)
          Text('短信').fontSize(16)
        }
        .width('50%')
        .height(50)
        .backgroundColor('#16302e2e')
        .margin({ bottom: 15 })
        .borderRadius(15)
      }.width('100%').height('100%').backgroundColor('#CFD0CF')
    }
    .title('层叠布局')
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
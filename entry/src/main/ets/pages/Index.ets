import { hilog } from '@kit.PerformanceAnalysisKit';
import { customDialogPage } from './customDialogPage';
import { MenuPage } from './menuPage';
import { PenPage } from './penPage';
import { StackPage } from './stackPage';

const indexDomain = 0x12345;
const indexTag = 'Index';

@Entry({ storage: LocalStorage.getShared() })
@Component
struct Index {
  title : string = 'UI示例';
  row1: string = '自定义弹窗';
  row2 : string = '弹出菜单';
  row3 : string = '层叠布局';
  row4 : string = '手写笔';
  row5 : string = '媒体查询';
  row6 : string = '创建列表';
  row7 : string = '创建网格';
  row8 : string = '创建轮播';
  row9 : string = '选项卡';
  listSpace : number = 20;
  listHeight : number = 50;
  titleFontSize : number = 20;
  listFontSize : number = 20;
  private texts : string[] = [this.row1, this.row2, this.row3, this.row4, this.row5, this.row6, this.row7, this.row8, this.row9];
  private scroller : Scroller = new Scroller();
  @State clickMsg : string = 'init';
  @State clickIdx : number = -1;
  // 创建一个页面栈对象并传入Navigation
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  @LocalStorageLink('prop1') prop1: string = '';

  @StorageProp('topRectHeight') topRectHeight: number = 0;

  @Builder
  PageMap(name: string) {
    if (name === this.row1) {
      customDialogPage()
    } else if (name === this.row2) {
      MenuPage()
    } else if (name === this.row3) {
      StackPage()
    } else if (name === this.row4) {
      PenPage()

    }
  }
  build() {
    Column({ space: 0 }) {
      Navigation(this.pageInfos) {
        Scroll(this.scroller) {
          Column({ space: this.listSpace }) {
            Text(this.prop1 + this.title)
              .fontSize(this.titleFontSize)
              .fontColor(Color.Black)//.backgroundColor(Color.White)
              .width('90%')
              .textAlign(TextAlign.Center)
              .height(this.listHeight)

            ForEach(this.texts, (item: string, index: number) => {
              /* 自定义组件测试 */
              radiusButton({ text: item })
                .onClick((event: ClickEvent) => {
                  hilog.info(indexDomain, indexTag, `click on ${item}`);
                  this.clickMsg = `click on ${item} index ${index}`
                  this.clickIdx = index;
                  this.pageInfos.pushPath({ name: item })
                })
            }, (item: string) => item)

            /* 自定义public build方法测试 */
            buildDynamicText({ text_str: this.clickMsg, fontSize: this.titleFontSize, height: this.listHeight })
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
        }
        .backgroundColor(0xDCDCDC)
        .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
        .scrollBar(BarState.Auto) // 滚动条自动显示
        .scrollBarColor(0xeeeeee) // 滚动条颜色
        .scrollBarWidth(3) // 滚动条宽度
        .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
        .height('100%')
        .width('100%')
        .align(Alignment.End)
        .margin({ top: 12 })
      }
      .title('Main')
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .navDestination(this.PageMap)
      //.backgroundColor(Color.Blue)
    }
    .height('100%')
    .width('100%')
    // 全屏模式避让状态栏
    .padding({ top: px2vp(this.topRectHeight) })
    //.alignItems(HorizontalAlign.Center)
  }
}

@Component
struct radiusButton {
  private fontSize : number = 20;
  private btnHeight : number = 50;

  @Prop text: string = '';

  build() {
    Button(this.text)
      .fontSize(this.fontSize)
      .fontColor(Color.White)
      .backgroundColor(Color.Green)
      .width('90%')
      .height(this.btnHeight)
      .borderRadius(15)
  }
}

class dynamicText {
  text_str: string = 'init';
  fontSize: number = 10;
  height: number = 20;
}

@Builder
function buildDynamicText(text: dynamicText) {
  Text(text.text_str)
    .fontSize(text.fontSize)
    .fontColor(Color.Black)
    .width('90%')
    .textAlign(TextAlign.Center)
    .height(text.height)
}
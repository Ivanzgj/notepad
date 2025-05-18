import { hilog } from "@kit.PerformanceAnalysisKit";

const DOMAIN = 0;
const TAG = 'PenPage';

@Component
export struct PenPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private beginX: number = 0;
  private beginY: number = 0;

  canvasOnTouch = (event:TouchEvent) => {
    hilog.debug(DOMAIN, TAG, 'touch [%d, %d]', event.touches[0].x, event.touches[0].y)

    if (event.type === TouchType.Down) {
      this.beginX = event.touches[0].x;
      this.beginY = event.touches[0].y;
      this.context.beginPath();
      this.context.moveTo(this.beginX, this.beginY)
      this.context.lineCap = 'round';
      return;
    }

    if (event.type === TouchType.Up) {
      this.context.closePath();
      return;
    }

    if (event.type == TouchType.Move) {
      let x = event.touches[0].x;
      let y = event.touches[0].y;
      this.context.lineWidth = 1;
      this.context.strokeStyle = Color.White;
      this.context.lineTo(x, y);
      this.context.stroke()
    }
  };

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        Canvas(this.context) {

        }
        .onTouch(this.canvasOnTouch)
        .width('100%')
        .height('100%')
        .backgroundColor(0x454545)

        Row({ space: 20 }) {
          Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
            Image($r("app.media.qq")).height('70%')
            Image($r("app.media.alipay")).height('70%')
            Image($r("app.media.wechat")).height('70%')
          }
          .height('100%')
          .width(90)
          .backgroundColor(Color.White)
          .margin({ bottom: 10 })
          .borderRadius(15)

          Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
            Image($r("app.media.edit_sunshine")).height('70%')
            Image($r("app.media.edit_size")).height('70%')
            Image($r("app.media.edit_record")).height('70%')
            Image($r("app.media.edit_measure")).height('70%')
            Image($r("app.media.edit_map")).height('70%')
            Image($r("app.media.edit_pictures")).height('70%')
          }
          .height('100%')
          .width(180)
          .backgroundColor(Color.White)
          .margin({ bottom: 10 })
          .borderRadius(15)
        }
        .width('300')
        .height('30')
        // 全屏模式下避让底部导航条
        //.margin({ bottom: px2vp(this.bottomRectHeight) })
        .margin({ bottom: 20 })
      }
      .width('100%')
      .height('100%')
    }
    .title('手写笔')
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
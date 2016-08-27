package
{
  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.ui.Mouse;
  import flash.utils.getTimer;
  
  public class Main extends Sprite
  {
    private var m_data:Data = new Data();
    
    public function Main()
    {
      Mouse.hide();
      
      m_data.x = m_data.xt = m_obj.y = m_btn2.y;
      
      m_btn0.addEventListener(MouseEvent.CLICK, onClick);
      m_btn1.addEventListener(MouseEvent.CLICK, onClick);
      m_btn2.addEventListener(MouseEvent.CLICK, onClick);
      stage.addEventListener(Event.ENTER_FRAME, update);
    }
    
    private var m_prevTime:int = 0;
    private function update(e:Event):void
    {
      const curTime:int = getTimer();
      const dt:Number = (curTime - m_prevTime) / 1000.0;
      m_prevTime = curTime;
      
      spring(m_data, 0.23, 8.0 * Math.PI, dt);
      m_obj.y = m_data.x;
    }
    
    private function onClick(e:Event):void
    {
      m_btn0.gotoAndStop(1);
      m_btn1.gotoAndStop(1);
      m_btn2.gotoAndStop(1);
      MovieClip(e.target).gotoAndStop(2);
      
      m_data.xt = DisplayObject(e.target).y;
    }
  }
}

class Data
{
  public var x:Number;
  public var v:Number;
  public var xt:Number;
  public function Data(x:Number = 0.0, v:Number = 0.0, xt:Number = 0.0)
  {
    this.x = x;
    this.v = v;
    this.xt = xt;
  }
}

function spring(data:Data, zeta:Number, omega:Number, h:Number):void
{
  const f:Number = 1.0 + 2.0 * h * zeta * omega;
  const hh:Number = h * h;
  const oo:Number = omega * omega;
  const hoo:Number = h * oo;
  const hhoo:Number = h * hoo;
  const detInv:Number = 1.0 / (f + hhoo);
  const detX:Number = f * data.x + h * data.v + hhoo * data.xt;
  const detV:Number = data.v + hoo * (data.xt - data.x);
  data.x = detX * detInv;
  data.v = detV * detInv;
}
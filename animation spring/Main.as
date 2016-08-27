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
      stage.addEventListener(Event.ENTER_FRAME, update);
    }
    
    private var m_prevTime:int = 0;
    private function update(e:Event):void
    {
      const curTime:int = getTimer();
      const dt:Number = (curTime - m_prevTime) / 1000.0;
      m_prevTime = curTime;
      
      m_data.xt = Math.min(1.0, Math.max(0.0, (stage.mouseX - m_obj.x) / (stage.stageWidth - m_obj.x - 50.0)));
      
      spring(m_data, 0.15, 8.0 * Math.PI, dt);
      m_obj.gotoAndStop(int(m_data.x * (m_obj.totalFrames - 30)) + 15);
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
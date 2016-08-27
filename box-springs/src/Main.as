package 
{
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.utils.getTimer;

  [SWF(width=160, height=160, frameRate=60)]
  public class Main extends Sprite 
  {
    private var m_shape0:Shape;
    private var m_shape1:Shape;
    private var m_shape2:Shape;
    
    public function Main()
    {
      var container0:Sprite = new Sprite();
      container0.x = 0.3 * stage.stageWidth;
      container0.y = 0.3 * stage.stageHeight;
      addChild(container0);
      
      var container1:Sprite = new Sprite();
      container1.x = 0.7 * stage.stageWidth;
      container1.y = 0.3 * stage.stageHeight;
      addChild(container1);
      
      var container2:Sprite = new Sprite();
      container2.x = 0.3 * stage.stageWidth;
      container2.y = 0.7 * stage.stageHeight;
      addChild(container2);
      
      m_shape0 = new Shape();
      m_shape0.graphics.beginFill(0x8080C0);
      m_shape0.graphics.drawRoundRect(-20.0, -20.0, 40.0, 40.0, 10.0, 10.0);
      container0.addChild(m_shape0);
      
      m_shape1 = new Shape();
      m_shape1.graphics.beginFill(0x8080C0);
      m_shape1.graphics.drawRoundRect(-20.0, -20.0, 40.0, 40.0, 10.0, 10.0);
      container1.addChild(m_shape1);
      
      m_shape2 = new Shape();
      m_shape2.graphics.beginFill(0x8080C0);
      m_shape2.graphics.drawRoundRect(-20.0, -20.0, 40.0, 40.0, 10.0, 10.0);
      container2.addChild(m_shape2);
      
      stage.addEventListener(Event.ENTER_FRAME, update);
    }
    
    private var m_data:Data = new Data();
    private var m_timer:Number = 0.0;
    private var m_oldTime:int = 0;
    private var m_i:int = 0;
    private function update(e:Event):void
    {
      const curTime:int = getTimer();
      const dt:Number = (curTime - m_oldTime) / 1000.0;
      
      m_timer += dt;
      if (m_timer > 1.0)
      {
        m_timer = 0.0;
        
        m_data.x = -1.0;
        m_data.v = 0.0;
        
        m_i ^= 1;
      }
      
      spring(m_data, 0.23, 8.0 * Math.PI, 0.016);
      
      m_shape0.scaleX = 1.0 - m_data.x;
      m_shape0.scaleY = m_data.x + 1.0;
      m_shape1.rotation = 90.0 * m_data.x;
      
      if (m_i)
      {
        m_shape2.x = 0.4 * stage.stageWidth * (1.0 + m_data.x);
      }
      else
      {
        m_shape2.x = 0.4 * stage.stageWidth * -m_data.x;
      }
      
      m_oldTime = curTime;
    }
  }
}

class Data
{
  public var x:Number;
  public var v:Number;
  public function Data(x:Number = -1.0, v:Number = 0.0)
  {
    this.x = x;
    this.v = v;
  }
}

function spring(data:Data, zeta:Number, omega:Number, dt:Number):void
{
  data.v = (1.0 - 2.0 * dt * zeta * omega) * data.v - dt * omega * omega * data.x;
  data.x = data.x + data.v * dt;
}
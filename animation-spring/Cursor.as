package 
{
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import flash.ui.Mouse;
  
  public class Cursor extends MovieClip
  {
    public function Cursor() 
    {
      Mouse.hide();
      stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
    }
    
    private function mouseMove(e:MouseEvent):void 
    {
      x = parent.mouseX;
      y = parent.mouseY;
      
      const d0:Number = Math.abs(stage.mouseX);
      const d1:Number = Math.abs(stage.stageWidth - stage.mouseX);
      const d2:Number = Math.abs(stage.mouseY);
      const d3:Number = Math.abs(stage.stageHeight - stage.mouseY);
      const dd:Number = Math.min(Math.min(d0, d1), Math.min(d2, d3));
      
      if (dd < 30.0)
      {
        alpha = Math.max(0.0, (dd - 10.0) / 20.0);
      }
      else
      {
        alpha = 1.0;
      }
    }
    
    private function mouseDown(e:MouseEvent):void 
    {
      gotoAndStop(2);
    }
    
    private function mouseUp(e:MouseEvent):void 
    {
      gotoAndStop(1);
    }
  }
}
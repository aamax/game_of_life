### display.rb ###

require 'opengl'
#require 'glut'
require 'gol'

$dot_size = 5.0
$board_size = 200
$gol = World.new( $board_size )



display = Proc.new {

  GL.Clear( GL::COLOR_BUFFER_BIT );
  GL.PushMatrix();
  GL.Begin( GL::POINTS );

    $gol.cells.each do |cell|
      GL.Vertex2f( cell.location.x.to_f * $dot_size, cell.location.y.to_f * $dot_size )
    end
    
  GL.End();
  GL.PopMatrix();
  GLUT.SwapBuffers();

}

idle = Proc.new {
  $gol.tick
  $gol.update_board
  display.call

}


init = Proc.new {

  GL.ClearColor( 0.0, 0.0, 0.0, 0.0 )
  GL.MatrixMode( GL::PROJECTION )
  GL.LoadIdentity()
  GLU.Ortho2D( 0.0, $dot_size * $board_size.to_f, 0.0, $dot_size *
$board_size.to_f )
  GL.PointSize( $dot_size )
  GL.Enable( GL::POINT_SMOOTH )
  GL.Enable( GL::BLEND )
  GL.BlendFunc( GL::SRC_ALPHA, GL::ONE_MINUS_SRC_ALPHA )

}

GLUT.Init()
GLUT.InitDisplayMode( GLUT_DOUBLE | GLUT_RGB )
GLUT.InitWindowSize( $dot_size.to_i * $board_size, $dot_size.to_i *
$board_size )
GLUT.InitWindowPosition( 0, 0 )
GLUT.CreateWindow( "game of life" )
init.call
GLUT.DisplayFunc( display )
GLUT.IdleFunc( idle )
GLUT.MainLoop()

### end display.rb ###
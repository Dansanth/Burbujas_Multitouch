// Juego de reventar lasa burbujas el toque funcional con leap motion 
// importamos el vialab que es lo que vuelve funcional al leap motion
import vialab.SMT.*; 


int zone_count = 0;
boolean draw_fps = true;

class BubbleZone extends Zone {
	public boolean dead = false;
	public double ani_step = 0;
	public int red;
	public int green;
	public int blue;
	public BubbleZone(){
		super( "BubbleZone", 0, 0, 100, 100);//tamaño de las burbujas
		this.red = (int)( 5 + random( 245));// tonalidad de color random entre 5 + cualquiera dentro de 245
		this.green = (int)( 5 + random( 100));
		this.blue = (int)( 5 + random( 50));
		this.translate(
			random( displayWidth - 100),
			random( displayHeight - 100));
	}
}

void setup(){
	size( displayWidth, displayHeight, SMT.RENDERER); 
((javax.swing.JFrame) frame).setResizable( true);
	SMT.init( this, TouchSource.AUTOMATIC);
	registerMethod( "pre", this);
}// añadimos el tamaño de la ventana para que en cualquier caso sea del tamaño de la pantalla en la que se ejecute
  //añadiendo el SMT renderer hacemos funcional el multi touch en la ventana 

void pre(){ 
	while( zone_count < 50){
		SMT.add( new BubbleZone());
		zone_count++;
	}
} //con esto hacemos que con cada burbuja que explotemos aparezca otra mas
// dibujamos el fondo de la ventana en este caso sera un fondo de color negro
void draw(){
	background(0);
	if( draw_fps) drawFrameRate();
}

//variables de las burbujas 
void drawBubbleZone( BubbleZone zone){
	noStroke();
	
	fill( zone.red, zone.green, zone.blue,
		(int)( 200 * ( 1 - zone.ani_step)));
	
	ellipse(
		zone.width/2 , zone.height/2,
		(float)( zone.width * ( 1 + zone.ani_step)), //con esto controlamos el tamaño de las burbujas 
		(float)( zone.height * ( 1 + zone.ani_step)));
	if( zone.dead){
		zone.ani_step += 0.10;
		if( zone.ani_step > 1){
			SMT.remove( zone);  //con esto añadimos la funcionalidad de que si tocamos una burbuja se desaparezca 
			zone_count--;
		}
	}
}
void pickDrawBubbleZone( BubbleZone zone){
	if( ! zone.dead)
		ellipse(
			zone.width / 2, zone.height / 2,
			zone.width, zone.height);
}
void touchBubbleZone( BubbleZone zone){
	zone.dead = true;
	zone.unassignAll();
}

public void drawFrameRate(){
	float fps = this.frameRate;
	String fps_text = String.format( "fps: %.0f", fps);
	pushStyle();
	fill( 240, 240, 240, 180);
	textAlign( RIGHT, TOP);
	textSize( 24);
	text( fps_text, displayWidth - 5, 5);
	popStyle();
}

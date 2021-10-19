package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;


/* ======================== Custom Import ========================= */
#if flash
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
#end
import nme.display.Loader;
import nme.display.MovieClip;
import nme.display.DisplayObjectContainer;
import nme.display.LoaderInfo;
import nme.events.MouseEvent;

#if flash
import flash.Lib;
#end
import nme.net.URLRequest;

@:file("C:/Users/Justin/Desktop/CA Intro properr font.swf")
class LoadingAnimation extends flash.utils.ByteArray{}
/* ================================================================ */



class Design_5_5_Preloader extends SceneScript
{
	
	/* ========================= Custom Code ========================== */
	var context:LoaderContext = null;
var loader:Loader = null;
	
	/* ========================= Custom Code ========================== */
	function loadSite(e:MouseEvent):Void
{
	var myLink:URLRequest = new URLRequest("http://www.cosmoarcade.com/");
	flash.Lib.getURL(myLink, "_blank");
}
	
	/* ========================= Custom Code ========================== */
	function onSwfLoaded(event:Event):Void
{
	Engine.engine.master.addChild(loader);
	Engine.engine.master.addEventListener(MouseEvent.CLICK, loadSite);

	var doc:DisplayObjectContainer = cast(cast(event.target, LoaderInfo).content, DisplayObjectContainer);
	//doc.addEventListener(Event.ENTER_FRAME, onENTER_FRAME);
	startLater(doc);
}
	
	/* ========================= Custom Code ========================== */
	function onENTER_FRAME(evt:Event):Void
{
	var playermc:MovieClip = cast(evt.target, MovieClip);
	if(playermc.currentFrame == playermc.totalFrames)
	{
		onSwfCompleted();
	}
}
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_onSwfCompleted():Void
	{
		Engine.engine.master.removeChild(loader);
		Engine.engine.master.removeEventListener(MouseEvent.CLICK, loadSite);
		loader.unloadAndStop();
		runLater(1000 * .5, function(timeTask:TimedTask):Void
		{
			switchScene(GameModel.get().scenes.get(1).getID(), null, createCrossfadeTransition(1.5));
		}, null);
	}
	
	/* ========================= Custom Code ========================== */
	function startLater(doc:DisplayObjectContainer):Void{
	if(Std.is(doc, MovieClip))
{
	cast(doc, MovieClip).stop();
}
	runLater(1000 * .5, function(timeTask:TimedTask):Void
	{
		if(Std.is(doc, MovieClip))
{
	var mc:MovieClip = cast(doc, MovieClip);
	mc.play();
	mc.addFrameScript(mc.totalFrames-1, onSwfCompleted);
}
	}, null);
	}
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		context = new LoaderContext(false, ApplicationDomain.currentDomain);
loader = new Loader ();
loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSwfLoaded);
loader.loadBytes(new LoadingAnimation(), context);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
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
import nme.events.KeyboardEvent;
import nme.Lib;

/* ================================================================ */



class Design_10_10_TextInput extends ActorScript
{
	public var _text:String;
	public var _textX:Float;
	public var _textY:Float;
	public var _isFocus:Bool;
	public var _maxCharacteres:Float;
	public var _CFont:Font;
	
	/* ========================= Custom Code ========================== */
		public function keyDownHandler(event:KeyboardEvent):Void
	{
		if(_isFocus && event.charCode == 27 || event.charCode == 13) {
			_isFocus = false;	
		}
		else if(_isFocus && event.charCode == 8) {
			_text = _text.substr(0, -1);
		}
		else if(_isFocus && _text.length < _maxCharacteres){
			_text = _text + String.fromCharCode(event.charCode);		
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("text", "_text");
		_text = "";
		nameMap.set("text X", "_textX");
		_textX = 0.0;
		nameMap.set("text Y", "_textY");
		_textY = 0.0;
		nameMap.set("isFocus", "_isFocus");
		_isFocus = false;
		nameMap.set("maxCharacteres", "_maxCharacteres");
		_maxCharacteres = 0.0;
		nameMap.set("CFont", "_CFont");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

		_isFocus = false;
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(_CFont);
				if(_isFocus)
				{
					g.drawString("" + ((_text) + ("|")), _textX, _textY);
				}
				else
				{
					g.drawString("" + _text, _textX, _textY);
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				_isFocus = true;
			}
		});
		
		/* ============================ Click ============================= */
		addMousePressedListener(function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_isFocus = false;
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
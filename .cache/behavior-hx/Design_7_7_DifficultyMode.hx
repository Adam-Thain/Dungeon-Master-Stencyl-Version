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



class Design_7_7_DifficultyMode extends ActorScript
{
	public var _Difficulty:String;
	public var _UseGameAttribute:Bool;
	public var _DifficultyGameAttribute:String;
	public var _OldMode:String;
	public var _DifficultySettings:Array<Dynamic>;
	public var _Index:Float;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_UpdateDifficulty():Void
	{
		/* Set Index */
		for(index0 in 0..._DifficultySettings.length)
		{
			if((_Difficulty == ("" + _DifficultySettings[index0]).split("/")[0]))
			{
				_Index = index0;
			}
		}
		/* Set attributes */
		for(item in cast(("" + _DifficultySettings[Std.int(_Index)]).split("/"), Array<Dynamic>))
		{
			if(actor.hasBehavior("" + ("" + item).split(",")[0]))
			{
				actor.setValue("" + ("" + item).split(",")[0], "" + ("" + item).split(",")[1], ("" + item).split(",")[2]);
			}
		}
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_ChangeDifficulty(__DifficultyLevel:String):Void
	{
		var __Self:Actor = actor;
		_Difficulty = __DifficultyLevel;
		_customEvent_UpdateDifficulty();
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Difficulty", "_Difficulty");
		_Difficulty = "";
		nameMap.set("Use Game Attribute?", "_UseGameAttribute");
		_UseGameAttribute = false;
		nameMap.set("Difficulty Game Attribute", "_DifficultyGameAttribute");
		nameMap.set("Old Mode", "_OldMode");
		_OldMode = "";
		nameMap.set("Difficulty Settings", "_DifficultySettings");
		nameMap.set("Index", "_Index");
		_Index = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				/* Set game attribute */
				if(_UseGameAttribute)
				{
					_Difficulty = ("" + getGameAttribute(_DifficultyGameAttribute));
				}
				/* Check if difficulty has changed */
				if(!((_Difficulty == _OldMode)))
				{
					_customEvent_UpdateDifficulty();
				}
				_OldMode = _Difficulty;
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
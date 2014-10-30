package howler;

@:native("window.Howl")
extern class Howl {
	function new(options:HowlOptions):Void;

	function load():Howl;

	@:overload(function(urls:Array<String>):Howl {})
	function urls(urls:Array<String>):Array<String>;

	function play(?sprite:String, ?callBack:String -> Void):Howl;

	function pause(?id:String):Howl;

	function stop(?id:String):Howl;

	function mute(?id:String):Howl;

	function unmute(?id:String):Howl;

	@:overload(function(vol:Float, ?id:String):Howl {})
	function volume(vol:Float, ?id:String):Float;

	@:overload(function(loop:Bool):Howl {})
	function loop(loop:Bool):Bool;

	@:overload(function(sprite:SpriteParams):Howl {})
	function sprite(sprite:SpriteParams):Dynamic;

	@:overload(function(pos:Float, ?id:String):Howl {})
	function pos(pos:Float, ?id:String):Float;

	@:overload(function(x:Float, y:Float, z:Float, ?id:String):Howl {})
	function pos3d(x:Float, y:Float, z:Float, ?id:String):Array<Float>;

	function fade(f:Float, t:Float, len:Float, ?callBack:Void -> Void, ?id:String):Howl;

	function fadeIn(t:Float, len:Float, callBack:Void -> Void):Howl; // deprecated

	function fadeOut(t:Float, len:Float, callBack:Void -> Void, ?id:String):Howl; // deprecated

	function on(event:String, ?fn:Void -> Void):Howl;

	function off(event:String, ?fn:Void -> Void):Howl;

	function unload():Void;

	// Web Audio only
	function decodeAudioData(arraybuffer:js.html.ArrayBuffer, obj:Howl, url:String):String;

	function loadBuffer(obj:Howl, url:String):String;

	function loadSound(obj:Howl, buffer:js.html.audio.AudioBuffer):String;

	function refreshBuffer(obj:Howl, loop:Array<RefreshBufferLoopParams>, ?id:String):Void;
}

typedef RefreshBufferLoopParams = { loop:Bool, pos:Float, duration:Float };

typedef SpriteParams = { offset:Int, duration:Int, ?loop:Bool }

class HowlOptions {
	public var autoplay:Bool = false;
	public var buffer:Bool = false;
	public var duration:Float;
	public var format:String = null;
	public var loop:Bool = false;
	public var sprite:Dynamic = {};
	public var src:String;
	public var pos3d:Array<Float>;
	public var volume:Float = 1;
	public var urls:Array<String> = [];
	public var rate:Float = 1;
	public var model:String = "equalpower";
	public var onload:Void -> Void;
	public var onloaderror:Void -> Void;
	public var onend:Void -> Void;
	public var onpause:Void -> Void;
	public var onplay:Void -> Void;

	public function new(?urls:Array<String>) {
		if (urls != null && urls.length > 0) this.urls = urls;
	}
}
package howler;

/**
 * Changelog.
 * 04/17/15: -updated to work with Howler.js 2.0 beta by jonnym1p
 * 			 -added doc comments
 */
@:native("window.Howler")
extern class Howler {
	
	/** Exposes the AudioContext with Web Audio API. Web Audio Only! **/
	static var ctx:js.html.audio.AudioContext;
	
	/** true if the Web Audio API is available. */
	static var usingWebAudio:Bool;
	
	/** true if any audio is available. */
	static var noAudio:Bool;
	
	/** Automatically attempts to enable audio on iOS devices. */
	static var iOSAutoEnable:Bool;

	/** Check supported audio codecs. Returns true if the codec is supported in the current browser. */
	static function codecs(ext:String):Bool;

	/** Get/set the global volume for all sounds, relative to their own volume. */
	static function volume(vol:Float):Float;

	/** Mute or unmute all sounds. */
	static function mute( muted:Bool ):Void;
}
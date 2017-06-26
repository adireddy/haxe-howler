package howler;

import haxe.extern.EitherType;
@:native("Howler")
extern class Howler {

	/**
	 * Initialize the global Howler object.
	 * @return {Howler}
	 */
	static function init():Howler;

	/**
	 * Set to false to disable the auto iOS enabler.
	 */
	static var iOSAutoEnable:Bool;

	/**
	 * No audio is available on this system if this is set to true.
	 */
	static var noAudio:Bool;

	/**
	 * This will be true if the Web Audio API is available.
	 */
	static var usingWebAudio:Bool;

	/**
	 * Expose the AudioContext when using Web Audio.
	 */
	static var ctx:js.html.audio.AudioContext;

	/**
	 * Check for codec support of specific extension.
	 * @param  {String} ext Audio file extention.
	 * @return {Boolean}
	 */
	static function codecs(ext:String):Bool;

	/**
	 * Get/set the global volume for all sounds.
	 * @param  {Float} vol Volume from 0.0 to 1.0.
	 * @return {Howler/Float} Returns self or current volume.
	 */
	static function volume(vol:Float):EitherType<Howler, Float>;

	/**
	 * Handle muting and unmuting globally.
	 * @param {Boolean} muted Is muted or not.
	 */
	static function mute(muted:Bool):Howler;

	/**
     * Unload and destroy all currently loaded Howl objects.
     * @return {Howler}
     */
	static function unload():Howler;
}
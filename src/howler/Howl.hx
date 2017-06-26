package howler;

import haxe.extern.EitherType;
@:native("Howl")
extern class Howl {

	/**
	 * Create an audio group controller.
	 * @param {HowlOptions} o Passed in properties for this group.
	*/
	function new(options:HowlOptions):Void;

	/**
     * Initialize a new Howl group object.
     * @param  {Object} o Passed in properties for this group.
     * @return {Howl}
     */
	function init(o:Dynamic):Howl;

	/**
	 * Load the audio file.
	 * @return {Howl}
	 */
	function load():Howl;

	/**
	 * Play a sound or resume previous playback.
	 * @param {String/Int} sprite Sprite name for sprite playback or sound id to continue previous.
	 * @return {Int} Sound ID.
	 */
	function play(?sprite:EitherType<String, Int>):Int;

	/**
	 * Pause playback and save current position.
	 * @param {Int} id The sound ID (empty to pause all in group).
	 * @return {Howl}
	 */
	function pause(?id:Int):Howl;

	/**
	 * Stop playback and reset to start.
	 * @param {Int} id The sound ID (empty to stop all in group).
	 * @return {Howl}
	 */
	function stop(?id:Int):Howl;

	/**
	 * Mute/unmute a single sound or all sounds in this Howl group.
	 * @param {Bool} muted Set to true to mute and false to unmute.
	 * @param {Int} id The sound ID to update (omit to mute/unmute all).
	 * @return {Howl}
	 */
	function mute(?muted:Bool = true, ?id:Int):Howl;

	/**
	 * Get/set the volume of this sound or of the Howl group. This method can optionally take 0, 1 or 2 arguments.
	 * volume() -> Returns the group's volume value.
	 * volume(id) -> Returns the sound id's current volume.
	 * volume(vol) -> Sets the volume of all sounds in this Howl group.
	 * volume(vol, id) -> Sets the volume of passed sound id.
	 * @return {Howl/Float} Returns self or current volume.
	 */
	@:overload(function(vol:Float, id:Int):Dynamic {})
	@:overload(function(vol:Float):Dynamic {})
	@:overload(function(id:Int):Float {})
	function volume():Float;

	/**
	 * Fade a currently playing sound between two volumes (if no id is passsed, all sounds will fade).
	 * @param  {Float} from The value to fade from (0.0 to 1.0).
	 * @param  {Float} to The volume to fade to (0.0 to 1.0).
	 * @param  {Float} len Time in milliseconds to fade.
	 * @param  {Int} id The sound id (omit to fade all sounds).
	 * @return {Howl}
	 */
	function fade(from:Float, to:Float, len:Int, ?id:Int):Howl;

	/**
	 * Get/set the loop parameter on a sound. This method can optionally take 0, 1 or 2 arguments.
	 * loop() -> Returns the group's loop value.
	 * loop(id) -> Returns the sound id's loop value.
	 * loop(loop) -> Sets the loop value for all sounds in this Howl group.
	 * loop(loop, id) -> Sets the loop value of passed sound id.
	 * @return {Howl/Bool} Returns self or current loop value.
	 */
	@:overload(function(loop:Bool, id:Int):Howl {})
	@:overload(function(loop:Bool):Howl {})
	@:overload(function(id:Int):Bool {})
	function loop():Bool;

	/**
     * Get/set the playback rate of a sound. This method can optionally take 0, 1 or 2 arguments.
     *   rate() -> Returns the first sound node's current playback rate.
     *   rate(id) -> Returns the sound id's current playback rate.
     *   rate(rate) -> Sets the playback rate of all sounds in this Howl group.
     *   rate(rate, id) -> Sets the playback rate of passed sound id.
     * @return {Howl/Float} Returns self or the current playback rate.
     */
	@:overload(function(rate:Float, id:Int):EitherType<Howl, Float> {})
	@:overload(function(rate:Float):EitherType<Howl, Float> {})
	@:overload(function(id:Int):EitherType<Howl, Float> {})
	function rate():EitherType<Howl, Float>;

	/**
	 * Get/set the seek position of a sound. This method can optionally take 0, 1 or 2 arguments.
	 * seek() -> Returns the first sound node's current seek position.
	 * seek(id) -> Returns the sound id's current seek position.
	 * seek(seek) -> Sets the seek position of the first sound node.
	 * seek(seek, id) -> Sets the seek position of passed sound id.
	 * @return {Howl/Float} Returns self or the current seek position.
	 */
	@:overload(function(seek:Float, id:Int):EitherType<Howl, Float> {})
	@:overload(function(seek:Float):EitherType<Howl, Float> {})
	@:overload(function(id:Int):EitherType<Howl, Float> {})
	function seek():EitherType<Howl, Float>;

	/**
	 * Check if a specific sound is currently playing or not.
	 * @param {Number} id The sound id to check. If none is passed, first sound is used.
	 * @return {Bool} True if playing and false if not.
	 */
	function playing(?id:Int):Bool;

	/**
	 * Get the duration of this sound.
	 * @return {Float} Audio duration.
	 */
	function duration():Float;

	/**
     * Returns the current loaded state of this Howl.
     * @return {String} 'unloaded', 'loading', 'loaded'
     */
	function state():String;

	/**
	 * Unload and destroy the current Howl object.
	 * This will immediately stop all sound instances attached to this group.
	 */
	function unload():Void;

	/**
	 * Listen to a custom event.
	 * @param {String} event Event name.
	 * @param {Function} fn Listener to call.
	 * @param {Int} id (optional) Only listen to events for this sound.
	 * @return {Howl}
	 */
	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function on(event:String, fn:Void -> Void, ?id:Int):Howl;

	/**
	 * Remove a custom event.
	 * @param {String} event Event name.
	 * @param {Function} fn (optional) Listener to remove. Leave empty to remove all.
	 * @param {Number} id (optional) Only remove events for this sound.
	 * @return {Howl}
	 */
	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function off(event:String, ?fn:Void -> Void, ?id:Int):Howl;

	/**
	 * Listen to a custom event and remove it once fired.
	 * @param {String} event Event name.
	 * @param {Function} fn Listener to call.
	 * @param {Int} id (optional) Only listen to events for this sound.
	 * @return {Howl}
	 */
	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function once(event:String, fn:Void -> Void, ?id:Int):Howl;
}

typedef HowlOptions = {
	/**
	 * Set to true to automatically start playback when sound is loaded.
	 */
	@:optional var autoplay:Bool;
	/**
	 * howler.js automatically detects your file format from the extension, but you may also
	 * specify a format in situations where extraction won't work (such as with a SoundCloud stream).
	 */
	@:optional var format:Array<String>;
	/**
	 * Set to true to force HTML5 Audio. This should be used for large audio files
	 * so that you don't have to wait for the full file to be downloaded and decoded before playing.
	 */
	@:optional var html5:Bool;
	/**
	 * Set to true to load the audio muted.
	 */
	@:optional var mute:Bool;
	/**
	 * Set to true to automatically loop the sound forever.
	 */
	@:optional var loop:Bool;
	/**
	 * The size of the inactive sounds pool. Once sounds are stopped or finish playing, they are
	 * marked as ended and ready for cleanup. We keep a pool of these to recycle for improved
	 * performance. Generally this doesn't need to be changed. It is important to keep in mind
	 * that when a sound is paused, it won't be removed from the pool and will still be considered
	 * active so that it can be resumed later.
	 */
	@:optional var pool:Int;
	/**
	 * Automatically begin downloading the audio file when the Howl is defined.
	 */
	@:optional var preload:Bool;
	/**
	 * The rate of playback. 0.5 to 4.0, with 1.0 being normal speed.
	 */
	@:optional var rate:Float;
	/**
	 * Define a sound sprite for the sound. The offset and duration are defined in milliseconds.
	 * A third (optional) parameter is available to set a sprite as looping.
	 *	{
	 *	  key: [offset, duration, (loop)]
	 *	}
	 */
	@:optional var sprite:Dynamic;
	/**
	 * The sources to the track(s) to be loaded for the sound (URLs or base64 data URIs).
	 * These should be in order of preference, howler.js will automatically load the first
	 * one that is compatible with the current browser. If your files have no extensions,
	 * you will need to explicitly specify the extension using the ext property.
	 */
	@:optional var src:Array<String>;
	/**
	 * The volume of the specific track, from 0.0 to 1.0.
	 */
	@:optional var volume:Float;
	/**
	 * Fires when the sound is loaded.
	 */
	@:optional var onload:Void -> Void;
	/**
	 * Fires when the sound is unable to load.
	 */
	@:optional var onloaderror:Void -> Void;
	/**
	 * Fires when the sound finishes playing (if it is looping, it'll fire at the end of each loop).
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onend:Int -> Void;
	/**
	 * Fires when the sound has been paused.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onpause:Int -> Void;
	/**
	 * Fires when the sound begins playing.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onplay:Int -> Void;
	/**
	 * Fires when the current sound finishes fading in/out.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onfade:Int -> Void;
	/**
	 * Fires when the sound has been stopped.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onstop:Int -> Void;
	/**
	 * Fires when the sound has been muted/unmuted.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onmute:Int -> Void;
	/**
	 * Fires when the sound's volume has changed.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onvolume:Int -> Void;
	/**
	 * Fires when the sound's playback rate has changed.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onrate:Int -> Void;
	/**
	 * Fires when the sound has been seeked.
	 * The first parameter is the ID of the sound.
	 */
	@:optional var onseek:Int -> Void;

}
package howler;

/**
 * Changelog.
 * 04/17/15: -updated to work with Howler.js 2.0 beta by jonnym1p
 * 			 -added doc comments
 */
@:native("window.Howl")
extern class Howl {
	/**
	 * Construct a new Howl. A Howl is now defined as a group of sounds instead of one.
	 * @param	options		Initial sound settings.
	 */
	function new(options:HowlOptions):Void;
	
	/**
	 * Begins playback of a sound. Returns the sound id to be used with other methods. Only method that can't be chained.
	 * @param	id		[String/Number] Takes one parameter that can either be a sprite or sound ID. 
	 * 					If a sprite is passed, a new sound will play based on the sprite's definition. 
	 * 					If a sound ID is passed, the previously played sound will be played (for example, after 
	 * 					pausing it). However, if an ID of a sound that has been drained from the pool is passed, 
	 * 					nothing will play.
	 * @return	sound id to be used with other methods.
	 */
	@:overload(function(?id:String):Int {})
	function play(?id:Int):Int;
	
	/**
	 * Pauses playback of sound or group, saving the seek of playback.
	 * @param	id	The sound ID. If none is passed, all sounds in group are paused.
	 * @return
	 */
	function pause(?id:Int):Howl;
	
	/**
	 * Stops playback of sound, resetting seek to 0.
	 * @param	id	The sound ID. If none is passed, all sounds in group are stopped.
	 * @return
	 */
	function stop(?id:Int):Howl;
	
	/**
	 * Mutes the sound, but doesn't pause the playback.
	 * @param	muted	True to mute and false to unmute.
	 * @param	id		The sound ID. If none is passed, all sounds in group are stopped.
	 * @return
	 */
	function mute(?muted:Bool, ?id:Int):Howl;
	
	/**
	 * Get/set volume of this sound or the group. This method optionally takes 0, 1 or 2 arguments.
	 * @param	volume	Volume from 0.0 to 1.0.
	 * @param	id		The sound ID. If none is passed, all sounds in group have volume altered relative to their own volume.
	 * @return
	 */
	function volume(?volume:Float, ?id:Int):Howl;
	
	/**
	 * Fade a currently playing sound between two volumes. Fires the faded event when complete.
	 * @param	from		Volume to fade from (0.0 to 1.0).
	 * @param	to			Volume to fade to (0.0 to 1.0).
	 * @param	duration	Time in milliseconds to fade.
	 * @param	id			The sound ID. If none is passed, all sounds ing roup will fade.
	 * @return
	 */
	function fade(from:Float, to:Float, duration:Int, ?id:Int):Howl;
	
	/**
	 * Get/set the position of playback for a sound. This method optionally takes 0, 1 or 2 arguments.
	 * @param	seek	The position to move current playback to (in seconds).
	 * @param	id		The sound ID. If none is passed, the first sound will seek.
	 * @return
	 */
	function seek(?seek:Float, ?id:Int):Howl;
	
	/**
	 * Get/set whether to loop the sound or group. This method can optionally take 0, 1 or 2 arguments.
	 * @param	loop	To loop or not to loop, that is the question.
	 * @param	id		The sound ID. If none is passed, all sounds in group will have their loop property updated.
	 * @return
	 */
	function loop(?loop:Bool, ?id:Int):Howl;
	
	/**
	 * Check if a sound is currently playing or not, returns a Boolean.
	 * @param	id	The sound ID to check. If none is passed, the first sound in group will be used.
	 * @return
	 */
	function playing(?id:Int):Bool;
	
	/**
	 * Get the duration of the audio source. Will return 0 until after the load event fires.
	 */
	function duration():Float;
	
	/**
	 * Listen for events. Multiple events can be added by calling this multiple times.
	 * @param	event	Name of event to fire/set (load, loaderror, play, end, pause, faded).
	 * @param	func	Define function to fire on event.
	 * @param	id		Only listen to events for this sound id.
	 * @return
	 */
	function on(event:String, func:Dynamic, ?id:Int):Howl;
	
	/**
	 * Same as on, but it removes itself after the callback is fired.
	 * @param	event	Name of event to fire/set (load, loaderror, play, end, pause, faded).
	 * @param	func	Define function to fire on event.
	 * @param	id		Only listen to events for this sound id.
	 * @return
	 */
	function once(event:String, func:Dynamic, ?id:Int):Howl;
	
	/**
	 * Remove event listener that you've set.
	 * @param	event	String Name of event (load, loaderror, play, end, pause, faded).
	 * @param	func	The listener to remove. Omit this to remove all events of type.
	 * @param	id		Only remove events for this sound id.
	 * @return
	 */
	function off(event:String, ?func:Dynamic, ?id:Int):Howl;
	
	/**
	 * This is called by default, but if you set preload to false, you must call load before you can play any sounds.
	 */
	function load():Void;
	
	/**
	 * Unload and destroy a Howl object. This will immediately stop all sounds attached to this sound and remove it from the cache.
	 */
	function unload():Void;
	
	/** removed during howler 1.1.25 -> 2.0 transition */
	//function urls(urls:Array<String>):Howl;
	//function sprite(sprite:SpriteParams):Howl;
	//function pos(pos:Float, ?id:String):Howl;
	//function pos3d(x:Float, y:Float, z:Float, ?id:String):Howl;
	// Web Audio only
	//function decodeAudioData(arraybuffer:js.html.ArrayBuffer, obj:Howl, url:String):String;
	//function loadBuffer(obj:Howl, url:String):String;
	//function loadSound(obj:Howl, buffer:js.html.audio.AudioBuffer):String;
	//function refreshBuffer(obj:Howl, loop:Array<RefreshBufferLoopParams>, ?id:String):Void;
}

typedef HowlOptions = {
	/** The sources to the track(s) to be loaded for the sound (URLs or base64 data URIs). 
	 * These should be in order of preference, howler.js will automatically load the first
	 * one that is compatible with the current browser. If your files have no extensions, 
	 * you will need to explicitly specify the extension using the ext property. */
	@:optional var src:Array<String>;
	/** The volume of the specific track, from 0.0 to 1.0. */
	@:optional var volume:Float;
	/** Set to true to force HTML5 Audio. This should be used for large audio files 
	 * so that you don't have to wait for the full file to be downloaded and decoded before playing. */
	@:optional var html5:Bool;
	/** Set to true to automatically loop the sound forever. */
	@:optional var loop:Bool;
	/** Automatically begin downloading the audio file when the Howl is defined. */
	@:optional var preload:Bool;
	/** Set to true to automatically start playback when sound is loaded. */
	@:optional var autoplay:Bool;
	/** Set to true to load the audio muted. */
	@:optional var mute:Bool;
	/** Define a sound sprite for the sound. The offset and duration are defined in milliseconds. 
	 * A third (optional) parameter is available to set a sprite as looping.
	 *	{
	 *	  key: [offset, duration, (loop)]
	 *	} */
	@:optional var sprite:Dynamic;
	/** The rate of playback. 0.5 to 4.0, with 1.0 being normal speed. */
	@:optional var rate:Float;
	/** The size of the inactive sounds pool. Once sounds are stopped or finish playing, they are 
	 * marked as ended and ready for cleanup. We keep a pool of these to recycle for improved 
	 * performance. Generally this doesn't need to be changed. It is important to keep in mind 
	 * that when a sound is paused, it won't be removed from the pool and will still be considered 
	 * active so that it can be resumed later. */
	@:optional var pool:Int;
	/** howler.js automatically detects your file format from the extension, but you may also 
	 * specify a format in situations where extraction won't work (such as with a SoundCloud stream). */
	@:optional var ext:Array<String>;
	/** Fires when the sound is loaded. */
	@:optional var onload:Void->Void;
	/** Fires when the sound is unable to load. */
	@:optional var onloaderror:Void->Void;
	/** Fires when the sound begins playing.
	 * The first parameter is the ID of the sound. */
	@:optional var onplay:Int->Void;
	/** Fires when the sound finishes playing (if it is looping, it'll fire at the end of each loop). 
	 * The first parameter is the ID of the sound. */
	@:optional var onend:Int->Void;
	/** Fires when the sound has been paused. 
	 * The first parameter is the ID of the sound. */
	@:optional var onpause:Int->Void;
	/** Fires when the current sound finishes fading in/out. 
	 * The first parameter is the ID of the sound. */
	@:optional var onfaded:Int->Void;
	
	/** removed during howler 1.1.25 -> 2.0 update */
	//@:optional var buffer:Bool;
	//@:optional var duration:Float;
	//@:optional var format:String;
	//@:optional var pos3d:Array<Float>;
	//@:optional var urls:Array<String>;
	//@:optional var model:String;
}

/** removed during howler 1.1.25 -> 2.0 update */
/*typedef RefreshBufferLoopParams = {
	var loop:Bool;
	var pos:Float;
	var duration:Float;
}*/

/*typedef SpriteParams = {
	var offset:Int;
	var duration:Int;
	@:optional var loop:Bool;
}*/
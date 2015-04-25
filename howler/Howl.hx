package howler;

@:native("Howl")
extern class Howl {

	/**
	 * Create an audio group controller.
	 * @param {Object} o Passed in properties for this group.
	*/
	function new(options:HowlOptions):Void;

	/**
     * Load the audio file.
     * @return {Howler}
     */
	function load():Howl;

	/**
     * Play a sound or resume previous playback.
     * @param {String/Number} sprite Sprite name for sprite playback or sound id to continue previous.
     * @return {Int} Sound ID.
     */
	@:overload(function(sprite:Int):Int {})
	function play(?sprite:String):Int;

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
	function mute(muted:Bool, ?id:Int):Howl;

	/**
     * Get/set the volume of this sound or of the Howl group. This method can optionally take 0, 1 or 2 arguments.
     * volume() -> Returns the group's volume value.
     * volume(id) -> Returns the sound id's current volume.
     * volume(vol) -> Sets the volume of all sounds in this Howl group.
     * volume(vol, id) -> Sets the volume of passed sound id.
     * @return {Howl/Float} Returns self or current volume.
     */
	@:overload(function(id:Int):Float {})
	@:overload(function(vol:Float):Howl {})
	@:overload(function(?vol:Float, ?id:String):Howl {})
	function volume(?vol:Float, ?id:String):Float;

	/**
     * Get/set the loop parameter on a sound. This method can optionally take 0, 1 or 2 arguments.
     * loop() -> Returns the group's loop value.
     * loop(id) -> Returns the sound id's loop value.
     * loop(loop) -> Sets the loop value for all sounds in this Howl group.
     * loop(loop, id) -> Sets the loop value of passed sound id.
     * @return {Howl/Boolean} Returns self or current loop value.
     */
	@:overload(function(?loop:Bool, ?id:Int):Howl {})
	function loop(?loop:Bool, ?id:Int):Bool;

	/**
     * Get/set the seek position of a sound. This method can optionally take 0, 1 or 2 arguments.
     * seek() -> Returns the first sound node's current seek position.
     * seek(id) -> Returns the sound id's current seek position.
     * seek(seek) -> Sets the seek position of the first sound node.
     * seek(seek, id) -> Sets the seek position of passed sound id.
     * @return {Howl/Number} Returns self or the current seek position.
     */
	@:overload(function(?seek:Bool, ?id:Int):Howl {})
	function seek(?seek:Float, ?id:Int):Float;

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
     * Unload and destroy the current Howl object.
     * This will immediately stop all sound instances attached to this group.
     */
	function unload():Void;

	/**
     * Fade a currently playing sound between two volumes (if no id is passsed, all sounds will fade).
     * @param  {Float} from The value to fade from (0.0 to 1.0).
     * @param  {Float} to The volume to fade to (0.0 to 1.0).
     * @param  {Float} len Time in milliseconds to fade.
     * @param  {Int} id The sound id (omit to fade all sounds).
     * @return {Howl}
     */
	function fade(f:Float, t:Float, len:Float, ?id:Int):Howl;

	/**
     * Listen to a custom event.
     * @param {String} event Event name.
     * @param {Function} fn Listener to call.
     * @param {Int} id (optional) Only listen to events for this sound.
     * @return {Howl}
     */
	function on(event:String, fn:Void -> Void, ?id:Int):Howl;

	/**
     * Remove a custom event.
     * @param {String} event Event name.
     * @param {Function} fn Listener to remove. Leave empty to remove all.
     * @param {Number} id (optional) Only remove events for this sound.
     * @return {Howl}
     */
	function off(event:String, fn:Void -> Void, ?id:Int):Howl;

	/**
     * Listen to a custom event and remove it once fired.
     * @param {String} event Event name.
     * @param {Function} fn Listener to call.
     * @param {Int} id (optional) Only listen to events for this sound.
     * @return {Howl}
     */
	function once(event:String, fn:Void -> Void, ?id:Int):Howl;
}

typedef HowlOptions = {
	@:optional var autoplay:Bool;
	@:optional var ext:String;
	@:optional var html5:Bool;
	@:optional var mute:Bool;
	@:optional var loop:Bool;
	@:optional var pool:Int;
	@:optional var preload:Bool;
	@:optional var rate:Float;
	@:optional var sprite:Dynamic;
	@:optional var src:Dynamic;
	@:optional var volume:Float;
	@:optional var onload:Void -> Void;
	@:optional var onloaderror:Void -> Void;
	@:optional var onend:Void -> Void;
	@:optional var onpause:Void -> Void;
	@:optional var onplay:Void -> Void;
	@:optional var onfaded:Void -> Void;
}
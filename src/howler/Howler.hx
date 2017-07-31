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

    /**
     * Helper method to update the stereo panning position of all current Howls.
     * Future Howls will not use this value unless explicitly set.
     * @param  {Number} pan A value of -1.0 is all the way left and 1.0 is all the way right.
     * @return {Howler}
     */
    static function stereo(pan:Float):Howler;

    /**
     * Get/set the position of the listener in 3D cartesian space. Sounds using
     * 3D position will be relative to the listener's position.
     * @param  {Number} x The x-position of the listener.
     * @param  {Number} y The y-position of the listener.
     * @param  {Number} z The z-position of the listener.
     * @return {Howler/Array}   Self or current listener position.
     */
    static function pos(x:Float, y:Float, z:Float):EitherType<Howler, Array<Float>>;

    /**
    * Get/set the direction the listener is pointing in the 3D cartesian space.
    * A front and up vector must be provided. The front is the direction the
    * face of the listener is pointing, and up is the direction the top of the
    * listener is pointing. Thus, these values are expected to be at right angles
    * from each other.
    * @param  {Number} x   The x-orientation of the listener.
    * @param  {Number} y   The y-orientation of the listener.
    * @param  {Number} z   The z-orientation of the listener.
    * @param  {Number} xUp The x-orientation of the top of the listener.
    * @param  {Number} yUp The y-orientation of the top of the listener.
    * @param  {Number} zUp The z-orientation of the top of the listener.
    * @return {Howler/Array}     Returns self or the current orientation vectors.
    */
    static function orientation(x:Float, y:Float, z:Float, xUp:Float, yUp:Float, zUp:Float):EitherType<Howler, Array<Float>>;
}
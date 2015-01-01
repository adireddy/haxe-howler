package pixi;

import pixi.geom.Rectangle;
import pixi.text.Text;
import pixi.primitives.Graphics;
import msignal.Signal.Signal1;
import pixi.display.DisplayObjectContainer;

class Button extends DisplayObjectContainer {

	public static inline var OVER_COLOUR:Int = 0xDF7401;
	public static inline var OUT_COLOUR:Int = 0x2E64FE;
	public static inline var TEXT_COLOUR:String = "#FFFFFF";
	public static inline var FONT_SIZE:Int = 12;

	var _data:Dynamic;

	var _label:Text;
	var _rect:Rectangle;
	var _background:Graphics;

	var _enabled:Bool;

	public var action:Signal1<Dynamic>;

	public function new(label:String, width:Float, height:Float, ?data:Dynamic, ?fontSize:Int) {
		super();
		action = new Signal1(Dynamic);
		_data = data;
		_setupBackground(width, height);
		_setupLabel(width, height, fontSize);
		setText(label);
	}

	function _setupBackground(width:Float, height:Float) {
		_rect = new Rectangle(0, 0, width, height);
		_background = new Graphics();
		_background.hitArea = _rect;
		_redraw(Button.OUT_COLOUR);
		addChild(_background);

		_background.interactive = true;
		_background.mouseover = _onMouseOver;
		_background.mouseout = _onMouseOut;
		_background.mousedown = _onMouseDown;
		_background.mouseup = _onMouseUp;
		_background.mouseupoutside = _onMouseUpOutside;
		_background.touchstart = _onTouchStart;
		_background.touchend = _onTouchEnd;
		_background.touchendoutside = _onTouchEndOutside;
	}

	function _setupLabel(width:Float, height:Float, fontSize:Int) {
		var size:Int = (fontSize != null) ? fontSize : Button.FONT_SIZE;
		var style:TextStyle = {};
		style.font = (size) + "px Arial";
		style.fill = Button.TEXT_COLOUR;
		_label = new Text("", style);
		_label.anchor.set(0.5, 0.5);
		_label.x = width / 2;
		_label.y = height / 2;
		addChild(_label);
	}

	function _redraw(colour:Int) {
		var border:Float = 1;
		_background.clear();
		_background.beginFill(0x003366);
		_background.drawRect(_rect.x, _rect.y, _rect.width, _rect.height);
		_background.endFill();
		_background.beginFill(colour);
		_background.drawRect(_rect.x + border / 2, _rect.y + border / 2, _rect.width - border, _rect.height - border);
		_background.endFill();
	}

	public function setText(label:String) {
		_label.setText(label);
	}

	function _onMouseDown(data:InteractionData) {
		if (_enabled) _redraw(Button.OVER_COLOUR);
	}

	function _onMouseUp(data:InteractionData) {
		if (_enabled) {
			action.dispatch(_data);
			_redraw(Button.OUT_COLOUR);
		}
	}

	function _onMouseUpOutside(data:InteractionData) {
		if (_enabled) _redraw(Button.OUT_COLOUR);
	}

	function _onMouseOver(data:InteractionData) {
		if (_enabled) _redraw(Button.OVER_COLOUR);
	}

	function _onMouseOut(data:InteractionData) {
		if (_enabled) _redraw(Button.OUT_COLOUR);
	}

	function _onTouchEndOutside(data:InteractionData) {
		if (_enabled) _redraw(Button.OUT_COLOUR);
	}

	function _onTouchEnd(data:InteractionData) {
		if (_enabled) {
			_redraw(Button.OUT_COLOUR);
			action.dispatch(_data);
		}
	}

	function _onTouchStart(data:InteractionData) {
		if (_enabled) _redraw(Button.OVER_COLOUR);
	}

	public function enable() {
		_enabled = true;
	}

	public function disable() {
		_redraw(Button.OUT_COLOUR);
		_enabled = false;
	}
}
(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
};
var msignal = {};
msignal.Signal = function(valueClasses) {
	if(valueClasses == null) valueClasses = [];
	this.valueClasses = valueClasses;
	this.slots = msignal.SlotList.NIL;
	this.priorityBased = false;
};
msignal.Signal.__name__ = true;
msignal.Signal.prototype = {
	add: function(listener) {
		return this.registerListener(listener);
	}
	,remove: function(listener) {
		var slot = this.slots.find(listener);
		if(slot == null) return null;
		this.slots = this.slots.filterNot(listener);
		return slot;
	}
	,registerListener: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		if(this.registrationPossible(listener,once)) {
			var newSlot = this.createSlot(listener,once,priority);
			if(!this.priorityBased && priority != 0) this.priorityBased = true;
			if(!this.priorityBased && priority == 0) this.slots = this.slots.prepend(newSlot); else this.slots = this.slots.insertWithPriority(newSlot);
			return newSlot;
		}
		return this.slots.find(listener);
	}
	,registrationPossible: function(listener,once) {
		if(!this.slots.nonEmpty) return true;
		var existingSlot = this.slots.find(listener);
		if(existingSlot == null) return true;
		if(existingSlot.once != once) throw "You cannot addOnce() then add() the same listener without removing the relationship first.";
		return false;
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return null;
	}
};
msignal.Signal1 = function(type) {
	msignal.Signal.call(this,[type]);
};
msignal.Signal1.__name__ = true;
msignal.Signal1.__super__ = msignal.Signal;
msignal.Signal1.prototype = $extend(msignal.Signal.prototype,{
	dispatch: function(value) {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(value);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal.Slot1(this,listener,once,priority);
	}
});
msignal.Slot = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	this.signal = signal;
	this.set_listener(listener);
	this.once = once;
	this.priority = priority;
	this.enabled = true;
};
msignal.Slot.__name__ = true;
msignal.Slot.prototype = {
	remove: function() {
		this.signal.remove(this.listener);
	}
	,set_listener: function(value) {
		if(value == null) throw "listener cannot be null";
		return this.listener = value;
	}
};
msignal.Slot1 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal.Slot.call(this,signal,listener,once,priority);
};
msignal.Slot1.__name__ = true;
msignal.Slot1.__super__ = msignal.Slot;
msignal.Slot1.prototype = $extend(msignal.Slot.prototype,{
	execute: function(value1) {
		if(!this.enabled) return;
		if(this.once) this.remove();
		if(this.param != null) value1 = this.param;
		this.listener(value1);
	}
});
msignal.SlotList = function(head,tail) {
	this.nonEmpty = false;
	if(head == null && tail == null) {
		if(msignal.SlotList.NIL != null) throw "Parameters head and tail are null. Use the NIL element instead.";
		this.nonEmpty = false;
	} else if(head == null) throw "Parameter head cannot be null."; else {
		this.head = head;
		if(tail == null) this.tail = msignal.SlotList.NIL; else this.tail = tail;
		this.nonEmpty = true;
	}
};
msignal.SlotList.__name__ = true;
msignal.SlotList.prototype = {
	prepend: function(slot) {
		return new msignal.SlotList(slot,this);
	}
	,insertWithPriority: function(slot) {
		if(!this.nonEmpty) return new msignal.SlotList(slot);
		var priority = slot.priority;
		if(priority >= this.head.priority) return this.prepend(slot);
		var wholeClone = new msignal.SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(priority > current.head.priority) {
				subClone.tail = current.prepend(slot);
				return wholeClone;
			}
			subClone = subClone.tail = new msignal.SlotList(current.head);
			current = current.tail;
		}
		subClone.tail = new msignal.SlotList(slot);
		return wholeClone;
	}
	,filterNot: function(listener) {
		if(!this.nonEmpty || listener == null) return this;
		if(Reflect.compareMethods(this.head.listener,listener)) return this.tail;
		var wholeClone = new msignal.SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(Reflect.compareMethods(current.head.listener,listener)) {
				subClone.tail = current.tail;
				return wholeClone;
			}
			subClone = subClone.tail = new msignal.SlotList(current.head);
			current = current.tail;
		}
		return this;
	}
	,find: function(listener) {
		if(!this.nonEmpty) return null;
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) return p.head;
			p = p.tail;
		}
		return null;
	}
};
var pixi = {};
pixi.Button = function(label,width,height,data,fontSize) {
	PIXI.DisplayObjectContainer.call(this);
	this.action = new msignal.Signal1(Dynamic);
	this._data = data;
	this._setupBackground(width,height);
	this._setupLabel(width,height,fontSize);
	this.setText(label);
};
pixi.Button.__name__ = true;
pixi.Button.__super__ = PIXI.DisplayObjectContainer;
pixi.Button.prototype = $extend(PIXI.DisplayObjectContainer.prototype,{
	_setupBackground: function(width,height) {
		this._rect = new PIXI.Rectangle(0,0,width,height);
		this._background = new PIXI.Graphics();
		this._background.hitArea = this._rect;
		this._redraw(3040510);
		this.addChild(this._background);
		this._background.interactive = true;
		this._background.mouseover = $bind(this,this._onMouseOver);
		this._background.mouseout = $bind(this,this._onMouseOut);
		this._background.mousedown = $bind(this,this._onMouseDown);
		this._background.mouseup = $bind(this,this._onMouseUp);
		this._background.mouseupoutside = $bind(this,this._onMouseUpOutside);
		this._background.touchstart = $bind(this,this._onTouchStart);
		this._background.touchend = $bind(this,this._onTouchEnd);
		this._background.touchendoutside = $bind(this,this._onTouchEndOutside);
	}
	,_setupLabel: function(width,height,fontSize) {
		var size;
		if(fontSize != null) size = fontSize; else size = 12;
		var style = { };
		style.font = size + "px Arial";
		style.fill = "#FFFFFF";
		this._label = new PIXI.Text("",style);
		this._label.anchor.set(0.5,0.5);
		this._label.x = width / 2;
		this._label.y = height / 2;
		this.addChild(this._label);
	}
	,_redraw: function(colour) {
		var border = 1;
		this._background.clear();
		this._background.beginFill(13158);
		this._background.drawRect(this._rect.x,this._rect.y,this._rect.width,this._rect.height);
		this._background.endFill();
		this._background.beginFill(colour);
		this._background.drawRect(this._rect.x + border / 2,this._rect.y + border / 2,this._rect.width - border,this._rect.height - border);
		this._background.endFill();
	}
	,setText: function(label) {
		this._label.setText(label);
	}
	,_onMouseDown: function(data) {
		if(this._enabled) this._redraw(14644225);
	}
	,_onMouseUp: function(data) {
		if(this._enabled) {
			this.action.dispatch(this._data);
			this._redraw(3040510);
		}
	}
	,_onMouseUpOutside: function(data) {
		if(this._enabled) this._redraw(3040510);
	}
	,_onMouseOver: function(data) {
		if(this._enabled) this._redraw(14644225);
	}
	,_onMouseOut: function(data) {
		if(this._enabled) this._redraw(3040510);
	}
	,_onTouchEndOutside: function(data) {
		if(this._enabled) this._redraw(3040510);
	}
	,_onTouchEnd: function(data) {
		if(this._enabled) {
			this._redraw(3040510);
			this.action.dispatch(this._data);
		}
	}
	,_onTouchStart: function(data) {
		if(this._enabled) this._redraw(14644225);
	}
	,enable: function() {
		this._enabled = true;
	}
});
pixi.PixiApplication = function() {
	this._skipFrame = false;
	this.backgroundColor = 16777215;
	this.skipFrame = false;
	this._lastTime = new Date();
	this._setupPixi();
};
pixi.PixiApplication.__name__ = true;
pixi.PixiApplication.prototype = {
	_setupPixi: function() {
		var _this = window.document;
		this._canvas = _this.createElement("canvas");
		this._canvas.style.width = "800px";
		this._canvas.style.height = "600px";
		window.document.body.appendChild(this._canvas);
		this.stage = new PIXI.Stage(this.backgroundColor);
		this.container = new PIXI.DisplayObjectContainer();
		this.stage.addChild(this.container);
		var renderingOptions = { };
		renderingOptions.view = this._canvas;
		renderingOptions.resolution = 2;
		this._renderer = PIXI.autoDetectRenderer(800,600,renderingOptions);
		window.document.body.appendChild(this._renderer.view);
		window.onresize = $bind(this,this.__onResize);
		window.requestAnimationFrame($bind(this,this.__onUpdate));
		this._lastTime = new Date();
	}
	,set_backgroundColor: function(clr) {
		this.stage.setBackgroundColor(clr);
		return this.backgroundColor = clr;
	}
	,__onResize: function(event) {
		if(this.resize != null) this.resize();
	}
	,__onUpdate: function() {
		if(this.skipFrame && this._skipFrame) this._skipFrame = false; else {
			this._skipFrame = true;
			this._calculateElapsedTime();
			if(this.update != null) this.update(this._elapsedTime);
			this._renderer.render(this.stage);
		}
		window.requestAnimationFrame($bind(this,this.__onUpdate));
	}
	,_calculateElapsedTime: function() {
		this._currentTime = new Date();
		this._elapsedTime = this._currentTime.getTime() - this._lastTime.getTime();
		this._lastTime = this._currentTime;
	}
};
pixi.renderers = {};
pixi.renderers.IRenderer = function() { };
pixi.renderers.IRenderer.__name__ = true;
var samples = {};
samples.Main = function() {
	pixi.PixiApplication.call(this);
	this.set_backgroundColor(6227124);
	this._btnContainer = new PIXI.DisplayObjectContainer();
	this.container.addChild(this._btnContainer);
	this._bgSound = this._setupSound("assets/loop.mp3");
	this._bgSound.loop(true);
	this._sound1 = this._setupSound("assets/sound1.wav");
	this._sound2 = this._setupSound("assets/sound2.wav");
	this._addButton("LOOP SOUND",0,0,100,30,$bind(this,this._playBGSound));
	this._addButton("SOUND 1",100,0,100,30,$bind(this,this._playSound1));
	this._addButton("SOUND 2",200,0,100,30,$bind(this,this._playSound2));
	this._addButton("STOP ALL",300,0,100,30,$bind(this,this._stopAll));
	this._btnContainer.x = 200;
	this._btnContainer.y = 285;
};
samples.Main.__name__ = true;
samples.Main.main = function() {
	new samples.Main();
};
samples.Main.__super__ = pixi.PixiApplication;
samples.Main.prototype = $extend(pixi.PixiApplication.prototype,{
	_setupSound: function(url) {
		var options = { };
		options.urls = [url];
		options.autoplay = false;
		var snd = new window.Howl(options);
		return snd;
	}
	,_playBGSound: function() {
		this._bgSound.play();
	}
	,_playSound1: function() {
		this._sound1.play();
	}
	,_playSound2: function() {
		this._sound2.play();
	}
	,_stopAll: function() {
		this._bgSound.stop();
		this._sound1.stop();
		this._sound2.stop();
	}
	,_addButton: function(label,x,y,width,height,callback) {
		var button = new pixi.Button(label,width,height);
		button.x = x;
		button.y = y;
		button.action.add(callback);
		button.enable();
		this._btnContainer.addChild(button);
	}
});
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
var Dynamic = { __name__ : ["Dynamic"]};
msignal.SlotList.NIL = new msignal.SlotList(null,null);
samples.Main.main();
})();

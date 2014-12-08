package pixi;

import js.html.Event;
import js.html.CanvasElement;
import js.Browser;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;
import pixi.display.DisplayObjectContainer;
import pixi.display.Stage;

class PixiApplication {

    public var skipFrame(null, default):Bool = false;
    public var backgroundColor(null, set):UInt = 0xFFFFFF;
    public var stage(default, null):Stage;
    public var container(default, null):DisplayObjectContainer;

    public var update:Float -> Void;
    public var resize:Void -> Void;

    var _canvas:CanvasElement;
    var _renderer:WebGLRenderer;

    var _lastTime:Date;
    var _currentTime:Date;
    var _elapsedTime:Float;
    var _skipFrame:Bool = false;

    public function new() {
        _lastTime = Date.now();
        _setupPixi();
    }

    function _setupPixi() {
        _canvas = Browser.document.createCanvasElement();
        _canvas.style.width = "800px";
        _canvas.style.height = "600px";
        Browser.document.body.appendChild(_canvas);

        stage = new Stage(backgroundColor);
        container = new DisplayObjectContainer();
        stage.addChild(container);

        var renderingOptions:RenderingOptions = {};
        renderingOptions.view = _canvas;
        renderingOptions.resolution = 2;

        _renderer = Detector.autoDetectRenderer(800, 600, renderingOptions);
        Browser.document.body.appendChild(_renderer.view);
        Browser.window.onresize = __onResize;
        Browser.window.requestAnimationFrame(cast __onUpdate);
        _lastTime = Date.now();
    }

    function set_backgroundColor(clr:UInt):UInt {
        stage.setBackgroundColor(clr);
        return backgroundColor = clr;
    }

    function __onResize(event:Event) {
        if (resize != null) resize();
    }

    function __onUpdate() {
        if (skipFrame && _skipFrame) _skipFrame = false;
        else {
            _skipFrame = true;
            _calculateElapsedTime();
            if (update != null) update(_elapsedTime);
            _renderer.render(stage);
        }
        Browser.window.requestAnimationFrame(cast __onUpdate);
    }

    function _calculateElapsedTime() {
        _currentTime = Date.now();
        _elapsedTime = _currentTime.getTime() - _lastTime.getTime();
        _lastTime = _currentTime;
    }
}
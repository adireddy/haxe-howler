package samples;

import pixi.display.DisplayObjectContainer;
import pixi.Button;
import pixi.PixiApplication;

import howler.Howl;

class Main extends PixiApplication {

    var _btnContainer:DisplayObjectContainer;
    var _bgSound:Howl;
    var _sound1:Howl;
    var _sound2:Howl;

    public function new() {
        super();
        backgroundColor = 0x5F04B4;

        _btnContainer = new DisplayObjectContainer();
        container.addChild(_btnContainer);

        _bgSound = _setupSound("assets/loop.mp3");
        _bgSound.loop(true);
        _sound1 = _setupSound("assets/sound1.wav");
        _sound2 = _setupSound("assets/sound2.wav");

        _addButton("LOOP SOUND", 0, 0, 100, 30, _playBGSound);
        _addButton("SOUND 1", 100, 0, 100, 30, _playSound1);
        _addButton("SOUND 2", 200, 0, 100, 30, _playSound2);
        _addButton("STOP ALL", 300, 0, 100, 30, _stopAll);

        _btnContainer.x = 200;
        _btnContainer.y = 285;
    }

    function _setupSound(url:String) {
        var options:HowlOptions = {};
        options.urls = [url];
        options.autoplay = false;
        var snd = new Howl(options);
        return snd;
    }

    function _playBGSound() {
        _bgSound.play();
    }

    function _playSound1() {
        _sound1.play();
    }

    function _playSound2() {
        _sound2.play();
    }

    function _stopAll() {
        _bgSound.stop();
        _sound1.stop();
        _sound2.stop();
    }

    function _addButton(label:String, x:Float, y:Float, width:Float, height:Float, callback:Dynamic) {
        var button = new Button(label, width, height);
        button.x = x;
        button.y = y;
        button.action.add(callback);
        button.enable();
        _btnContainer.addChild(button);
    }

    static function main() {
        new Main();
    }
}
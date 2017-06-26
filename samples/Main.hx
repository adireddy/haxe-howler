package samples;

import howler.Howler;
import js.Browser;
import pixi.core.display.Container;
import pixi.plugins.app.Application;
import pixi.Button;

import howler.Howl;

class Main extends Application {

	var _btnContainer:Container;
	var _bgSound:Howl;
	var _sound1:Howl;
	var _sound2:Howl;

	public function new() {
		super();

		pixelRatio = Math.floor(Browser.window.devicePixelRatio);
		backgroundColor = 0x5F04B4;
		super.start();

		_btnContainer = new Container();
		stage.addChild(_btnContainer);

		Howler.ctx = null;
		_bgSound = _setupSound("assets/loop.mp3", true);
		_sound1 = _setupSound("assets/funk100.mp3");
		_sound2 = _setupSound("assets/sound2.wav");

		_bgSound.play();

		_addButton("SOUND 1", 0, 0, 100, 30, _playSound1);
		_addButton("SOUND 2", 100, 0, 100, 30, _playSound2);
		_addButton("STOP ALL", 220, 0, 100, 30, _stopAll);

		_btnContainer.position.set((Browser.window.innerWidth - 320) / 2, (Browser.window.innerHeight - 30) / 2);
	}

	function _setupSound(url:String, ?loop:Bool = false) {
		var snd:Howl = null;
		var options:HowlOptions = {html5: true};
		options.src = [url];
		options.autoplay = false;
		options.loop = loop;
		options.onend = function(id:Int) {
			snd.volume(0.5);

			if(snd.volume(id) <= 0) snd.stop(id);
		};
		snd = new Howl(options);
		return snd;
	}

	inline function _playSound1() {
		_sound1.play();
	}

	inline function _playSound2() {
		_sound2.play();
	}

	function _stopAll() {
		_bgSound.stop();
		_sound1.stop();
		_sound2.stop();
	}

	function _addButton(label:String, x:Float, y:Float, width:Float, height:Float, callback:Dynamic) {
		var button = new Button(label, width, height);
		button.position.set(x, y);
		button.action.add(callback);
		button.enable();
		_btnContainer.addChild(button);
	}

	static function main() {
		new Main();
	}
}
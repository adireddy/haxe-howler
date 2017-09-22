[![Haxelib Version](https://img.shields.io/github/tag/adireddy/haxe-howler.svg?style=flat&label=haxelib)](http://lib.haxe.org/p/howlerjs) [![Support these externs on Patreon](http://www.waudjs.com/images/patreon_btn.png)](https://www.patreon.com/adireddy)
=========

![haxe howler logo](https://raw.githubusercontent.com/adireddy/haxe-howler/master/logo.png)

Externs of howler.js for Haxe - Modern Web Audio Javascript Library.

### Installation ###

```haxe
haxelib install howlerjs
```

### Demo ###

* [Haxe Howler Demo](http://adireddy.github.io/demos/haxe-howler/)

Look at the `samples` folder for the source code of above example.

### Usage ###

```haxe
import howler.Howl;

class Main {

    public function new() {
		var options:HowlOptions = {};
		options.src = ["sound.mp3", "sound.ogg"];
		options.autoplay = false;
		options.loop = true;
		var snd:Howl = new Howl(options);
		snd.play();
    }

    static function main() {
		new Main();
    }
}

```
### Licensing Information ###

<a rel="license" href="http://opensource.org/licenses/MIT">
<img alt="MIT license" height="40" src="http://upload.wikimedia.org/wikipedia/commons/c/c3/License_icon-mit.svg" /></a>

This content is released under the [MIT](http://opensource.org/licenses/MIT) License.

[howler.js](https://github.com/goldfire/howler.js) is written by [James Simpson](http://goldfirestudios.com/blog/104/howler.js-Modern-Web-Audio-Javascript-Library) and licensed under the [MIT](http://opensource.org/licenses/MIT) License.

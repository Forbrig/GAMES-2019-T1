import flixel.*;

class Tiro extends FlxSprite {
    public function new() {
        super();
        makeGraphic(10, 10, 0xffff0000);
        kill();
    }

    override public function update(elapsed:Float):Void {
        if (!isOnScreen()) {
            kill();
        }
        super.update(elapsed);
    }
}
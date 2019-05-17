package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.input.keyboard.*;

class Player extends FlxSprite {
    public var _id:Int;
	var flickering:Bool = false;
    var _speed:Float = 150;
    var _facing = '';
    var _keys = [];
    
    public function new(x:Int, y:Int, id:Int, keys:Array<FlxKey>) {
        super(x, y);
        _id = id;
        _keys = keys;
        health = 3;
        drag.x = drag.y = 2000;
        maxVelocity.set(_speed, _speed);

		loadGraphic(AssetPaths.characters__png, true, 16, 16);
		// loadGraphic(AssetPaths.kritatest__png, true, 32, 32);
        // animation.add("iddle_down", [0, 1, 2], 4, false);

        scale.set(2, 2);
        updateHitbox();

        // Animations
        animation.add("iddle_up", [37], 6, false);
        animation.add("iddle_down", [1], 6, false);
        animation.add("iddle_left", [13], 6, false);
        animation.add("iddle_right", [25], 6, false);

        animation.add("walking_up", [36, 37, 38, 37], 6, false);
        animation.add("walking_down", [0, 1, 2, 1], 6, false);
        animation.add("walking_left", [12, 13, 14, 13], 6, false);
        animation.add("walking_right", [24, 25, 26, 25], 6, false);
    }

    function movement() {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;

        if (FlxG.keys.anyPressed([_keys[0]])) {
            _up = true;
            _facing = 'up';
        }

        if (FlxG.keys.anyPressed([_keys[1]])) {
            _down = true;
            _facing = 'down';
        }

        if (FlxG.keys.anyPressed([_keys[2]])) {
            _left = true;
            _facing = 'left';
        }

        if (FlxG.keys.anyPressed([_keys[3]])) {
            _right = true;
            _facing = 'right';
        }

        // if (_up && _down) {
        //     _up = _down = false;
        // }

        // if (_left && _right) {
        //     _left = _right = false;
        // }

        if (_left && _up || _left && _down || _right && _up || _right && _down || _up && _down || _left && _right) {
            _up = _down = _left = _right = false;
        }

        if (_up || _down || _left || _right) {
            if (_up) {
                moveUp();
            } else if (_down) {
                moveDown();
            }

            if (_left) {
                moveLeft();
            } else if (_right) {
                moveRight();
            }

        } else {
            // idle
            switch (_facing) {
                case 'up':
                    animation.play("iddle_up");
                case 'down':
                    animation.play("iddle_down");
                case 'left':
                    animation.play("iddle_left");
                case 'right':
                    animation.play("iddle_right");

            }
        }
    }

    function moveLeft() {
        velocity.x -= _speed;
        animation.play("walking_left");
    }

    function moveRight() {
        velocity.x += _speed;
        animation.play("walking_right");
    }

    function moveUp() {
        velocity.y -= _speed;
        animation.play("walking_up");
    }

    function moveDown() {
        velocity.y += _speed;
        animation.play("walking_down");
    }

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }

    override public function hurt(damage:Float):Void{
        if (flickering) {
			return;
		}
		
		flicker(1);

		super.hurt(damage);
	}

    function flicker(Duration:Float):Void {
		FlxSpriteUtil.flicker(this, Duration, 0.02, true, true, function(_) {
			flickering = false;
		});
		flickering = true;
	}

    override public function destroy():Void {
		super.destroy();
	}
}
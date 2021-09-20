package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if windows
import Sys;
#end

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var ronPortrait:FlxSprite;
	var madronPortrait:FlxSprite;
	var hellronPortrait:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		if (PlayState.SONG.song.toLowerCase() == 'bloodshed')
			{
				FlxG.sound.playMusic(Paths.music('bloodshed-dialogue-mus'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
			} else if (PlayState.SONG.song.toLowerCase() == 'ron' || PlayState.SONG.song.toLowerCase() == 'ayo' || PlayState.SONG.song.toLowerCase() == 'trojan-virus' || PlayState.SONG.song.toLowerCase() == 'file-manipulation' || PlayState.SONG.song.toLowerCase() == 'atelophobia' || PlayState.SONG.song.toLowerCase() == 'factory-reset')
			{
				FlxG.sound.playMusic(Paths.music('talking-in-a-cool-way'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'ron' | 'ayo' | 'bloodshed' | 'trojan-virus' | 'file-manipulation':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() == 'ron' || 
			PlayState.SONG.song.toLowerCase() == 'ayo' || 
		PlayState.SONG.song.toLowerCase() == 'bloodshed' || 
		PlayState.SONG.song.toLowerCase() == 'trojan-virus' || 
		PlayState.SONG.song.toLowerCase() == 'file-manipulation')
		{
			ronPortrait = new FlxSprite(-1500, 10);
			ronPortrait.frames = Paths.getSparrowAtlas('portraits/ronPortrait', 'shared');
			ronPortrait.animation.addByPrefix('enter', 'Ron Enter', 24, false);
			ronPortrait.setGraphicSize(Std.int(ronPortrait.width + PlayState.daPixelZoom * 0.175));
			ronPortrait.updateHitbox();
			ronPortrait.scrollFactor.set();
			add(ronPortrait);
			ronPortrait.visible = false;
			
			portraitRight = new FlxSprite(-30, 100);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/boyfriendPort');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter instance', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			madronPortrait = new FlxSprite(-1500, 10);
			madronPortrait.frames = Paths.getSparrowAtlas('portraits/madronPortrait', 'shared');
			madronPortrait.animation.addByPrefix('enter', 'Ron Enter', 24, false);
			madronPortrait.setGraphicSize(Std.int(madronPortrait.width + PlayState.daPixelZoom * 0.175));
			madronPortrait.updateHitbox();
			madronPortrait.scrollFactor.set();
			add(madronPortrait);
			madronPortrait.visible = false;

			hellronPortrait = new FlxSprite(-1500, 10);
			hellronPortrait.frames = Paths.getSparrowAtlas('portraits/hellronPortrait', 'shared');
			hellronPortrait.animation.addByPrefix('enter', 'Ron Enter', 24, false);
			hellronPortrait.setGraphicSize(Std.int(hellronPortrait.width + PlayState.daPixelZoom * 0.175));
			hellronPortrait.updateHitbox();
			hellronPortrait.scrollFactor.set();
			add(hellronPortrait);
			hellronPortrait.visible = false;



		}

		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						ronPortrait.visible = false;
						madronPortrait.visible = false;
						hellronPortrait.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				ronPortrait.visible = false;
				madronPortrait.visible = false;
				hellronPortrait.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				ronPortrait.visible = false;
				madronPortrait.visible = false;
				hellronPortrait.visible = false;
				portraitRight.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
				case 'ron':
					madronPortrait.visible = false;
					hellronPortrait.visible = false;
					portraitRight.visible = false;
					if (!ronPortrait.visible)
					{
						ronPortrait.visible = true;
						ronPortrait.animation.play('enter');
					}
					case 'madron':
						ronPortrait.visible = false;
						hellronPortrait.visible = false;
						portraitRight.visible = false;
						if (!madronPortrait.visible)
						{
							madronPortrait.visible = true;
							madronPortrait.animation.play('enter');
						}
						case 'hellron':
							madronPortrait.visible = false;
							ronPortrait.visible = false;
							portraitRight.visible = false;
							if (!madronPortrait.visible)
							{
								hellronPortrait.visible = true;
								hellronPortrait.animation.play('enter');
							}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}

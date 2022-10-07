-- Lua stuff
tankX = 400;
tankSpeed = 0;
tankAngle = 0;
finishedGameover = false;
startedPlaying = false;

function onCreate()
	-- background shit
	math.randomseed(os.time());
	tankSpeed = math.random(5, 7);
	tankAngle = math.random(-90, 45);
	makeLuaSprite('tankSky2', 'tankSky2', -400, -400);
	setLuaSpriteScrollFactor('tankSky2', 0, 0);

	makeLuaSprite('tankBuildings2', 'tankBuildings2', -200, 0);
	setLuaSpriteScrollFactor('tankBuildings2', 0.3, 0.3);
	setGraphicSize('tankBuildings2', 1.1, 1.1);

	makeLuaSprite('tankRuins2', 'tankRuins2', -200, 0);
	setLuaSpriteScrollFactor('tankRuins2', 0.35, 0.35);
	setGraphicSize('tankRuins2', 1.1, 1.1);

	makeAnimatedLuaSprite('tankWatchtower', 'tankWatchtower2', 100, 50);
	luaSpriteAddAnimationByPrefix('tankWatchtower2', 'idle', 'watchtower2', 24, false);
	setLuaSpriteScrollFactor('tankWatchtower2', 0.5, 0.5);

	makeAnimatedLuaSprite('tankRolling', 'tankRolling2', 300, 300);
	luaSpriteAddAnimationByPrefix('tankRolling2', 'idle', 'BG tank w lighting', 24, true);
	setLuaSpriteScrollFactor('tankRolling2', 0.5, 0.5);

	makeLuaSprite('tankGround2', 'tankGround2', -420, -150);
	setGraphicSize('tankGround2', 1.15, 1.15);
	
	-- those are only loaded if you have Low quality turned off, to decrease loading times and memory
	if not lowQuality then
		makeLuaSprite('tankClouds2', 'tankClouds2', math.random(-700, -100), math.random(-20, 20));
		setLuaSpriteScrollFactor('tankClouds2', 0.1, 0.1);
		setProperty('tankClouds2.velocity.x', math.random(5, 15));

		makeLuaSprite('tankMountains2', 'tankMountains2', -300, -20);
		setLuaSpriteScrollFactor('tankMountains2', 0.2, 0.2);
		setGraphicSize('tankMountains2', 1.2, 1.2);

		makeAnimatedLuaSprite('smokeLeft2', 'smokeLeft2', -200, -100);
		luaSpriteAddAnimationByPrefix('smokeLeft2', 'idle', 'SmokeBlurLeft2');
		setLuaSpriteScrollFactor('smokeLeft2', 0.4, 0.4);

		makeAnimatedLuaSprite('smokeRight2', 'smokeRight2', 1100, -100);
		luaSpriteAddAnimationByPrefix('smokeRight2', 'idle', 'SmokeRight2');
		setLuaSpriteScrollFactor('smokeRight2', 0.4, 0.4);
	end

	addLuaSprite('tankSk2y', false);
	addLuaSprite('tankClouds2', false);
	addLuaSprite('tankMountains2', false);
	addLuaSprite('tankBuildings2', false);
	addLuaSprite('tankRuins2', false);
	addLuaSprite('smokeLeft2', false);
	addLuaSprite('smokeRight2', false);
	addLuaSprite('tankWatchtower2', false);
	addLuaSprite('tankRolling2', false);
	addLuaSprite('tankGround2', false);


	-- foreground shit
	makeAnimatedLuaSprite('tank02', 'tank02', -500, 650);
	luaSpriteAddAnimationByPrefix('tank02', 'idle', 'fg', 24, false);
	setLuaSpriteScrollFactor('tank02', 1.7, 1.5);
	
	makeAnimatedLuaSprite('tank22', 'tank22', 450, 940);
	luaSpriteAddAnimationByPrefix('tank22', 'idle', 'foreground', 24, false);
	setLuaSpriteScrollFactor('tank22', 1.5, 1.5);
	
	makeAnimatedLuaSprite('tank52', 'tank52', 1620, 700);
	luaSpriteAddAnimationByPrefix('tank52', 'idle', 'fg', 24, false);
	setLuaSpriteScrollFactor('tank52', 1.5, 1.5);
	
	if not lowQuality then
		makeAnimatedLuaSprite('tank12', 'tank12', -300, 750);
		luaSpriteAddAnimationByPrefix('tank12', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank12', 2.0, 0.2);
		
		makeAnimatedLuaSprite('tank4', 'tank42', 1300, 900);
		luaSpriteAddAnimationByPrefix('tank42', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank42', 1.5, 1.5);
		
		makeAnimatedLuaSprite('tank32', 'tank32', 1300, 1200);
		luaSpriteAddAnimationByPrefix('tank32', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank32', 3.5, 2.5);
	end

	addLuaSprite('tank02', true);
	addLuaSprite('tank12', true);
	addLuaSprite('tank22', true);
	addLuaSprite('tank42', true);
	addLuaSprite('tank52', true);
	addLuaSprite('tank32', true);

	moveTank(0);
	print('finished loading stage successfully')
end

function onUpdate(elapsed)
	moveTank(elapsed);
	
	if inGameOver and not startedPlaying and not finishedGameover then
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0.2);
	end
end

function moveTank(elapsed)
	if not inCutscene then
		tankAngle = tankAngle + (elapsed * tankSpeed);
		setProperty('tankRolling2.angle', tankAngle - 90 + 15);
		setProperty('tankRolling2.x', tankX + (1500 * math.cos(math.pi / 180 * (1 * tankAngle + 180))));
		setProperty('tankRolling2.y', 1300 + (1100 * math.sin(math.pi / 180 * (1 * tankAngle + 180))));
	end
end

-- Gameplay/Song interactions
function onBeatHit()
	-- triggered 4 times per section
	luaSpritePlayAnimation('tankWatchtower', 'idle', true);
	luaSpritePlayAnimation('tank02', 'idle', true);
	luaSpritePlayAnimation('tank12', 'idle', true);
	luaSpritePlayAnimation('tank22', 'idle', true);
	luaSpritePlayAnimation('tank32', 'idle', true);
	luaSpritePlayAnimation('tank42', 'idle', true);
	luaSpritePlayAnimation('tank52', 'idle', true);
end

function onCountdownTick(counter)
	onBeatHit();
end


-- Game over voiceline
function onGameOver()
	runTimer('playJeffVoiceline', 2.7);
	return Function_Continue;
end

function onGameOverConfirm(reset)
	finishedGameover = true;
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A tween you called has been completed, value "tag" is it's tag
	if not finishedGameover and tag == 'playJeffVoiceline' then
		math.randomseed(os.time());
		soundName = string.format('jeffGameover/jeffGameover-%i', math.random(1, 25));
		playSound(soundName, 1, 'voiceJeff');
		startedPlaying = true;
	end
end

function onSoundFinished(tag)
	if tag == 'voiceJeff' and not finishedGameover then
		soundFadeIn(nil, 4, 0.2, 1);
	end
end
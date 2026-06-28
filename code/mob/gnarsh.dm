//oh god no please
ABSTRACT_TYPE(/mob/living/critter/admin) //yoink basically all this from small_animals, since that's really all we are

/mob/living/critter/admin
	name = "undefined admin creature"
	desc = "jesus christ how horrifying"
	icon = "icons/mob/gnarsh.dmi"
	//nothing special here i guess, for now
	max_health = 100 //we have the godmode command for a reason, if u don't wanna die then toggle that or serious mode on ok
	health = 100 //or like, varedit yourself to create a boss fight? whatever please just keep it fun
	density = 1
	custom_gib_handler = /proc/gibs
	hand_count = 2
	can_throw = 1
	butcherable = 1 //a server that can kill and eat its own admins? yes thanks
	name_the_meat = 1
	max_skins = 1
	use_stunned_icon = FALSE //we don't have a dizzy icon state
	lie_on_death = FALSE
	invisibility = 100 //start out invisible
	var/owner = null //whoever this is for in lowercase ckey form
	var/icon_state_sleep = null //for when you're not in
	var/zzz_overlay_sleep = TRUE //if you just wanna slap some zzzs on instead of a new iconstate, or if you don't want zzzs
		//might define a per-mob thing that happens if you attack a sleeping admin mob (i.e. visible office spawn that has not been entered)
	//if you're not here for jokes, use this to cut them off (+ different appearance)
	var/serious = 0
	var/serious_name = null
	var/serious_desc
	var/serious_icon = null
	var/serious_icon_state = null
	var/serious_icon_state_dead = null //in case your normal -dead is different than your serious
	var/serious_icon_state_sleep = null
	var/serious_sound = null
	var/unserious_sound = "sound/musical_instruments/Bikehorn_1.ogg"

	health_brute = 20
	health_brute_vuln = 1
	health_burn = 20
	health_burn_vuln = 1

	New()
		..()
		SPAWN_DBG(1 SECOND) //let's just hide the single frame blip from non-serious to serious behind temporary invisibility
			invisibility = 0
			if (!serious) //yoinked from wire's deathconfetti
				src.deathConfetti()

	death(var/gibbed)
		if (!gibbed)
			src.unequip_all()
		..()

	proc/toggle_seriousness()
		//become serious
		if (!src.serious)
			src.serious = 1
			if (src.serious_name)
				src.name = src.serious_name
			if (src.serious_desc)
				src.desc = src.serious_desc
			if (src.serious_icon)
				src.icon = src.serious_icon
			if (src.serious_icon_state)
				src.icon_state = src.serious_icon_state
			if (src.serious_icon_state_sleep)
				src.icon_state_sleep = src.serious_icon_state_sleep
			if (src.serious_icon_state_dead)
				src.icon_state_dead = src.serious_icon_state_dead
			src.health = 99999999 //nodamage causes hit_twitch and icon loss????? and -10000/-10000 burn and brute damage every cycle????? what the fuck
			src.visible_message(text("<span class='alert'><B>[src] is serious!</B></span>"))
			if (src.serious_sound)
				playsound(src.loc, src.serious_sound, 50)
			return

		//chill out
		src.serious = 0
		src.name = initial(src.name)
		src.desc = initial(src.desc)
		src.icon = initial(src.icon)
		src.icon_state = initial(src.icon_state)
		src.icon_state_sleep = initial(src.icon_state_sleep)
		src.icon_state_dead = initial(src.icon_state_dead)
		src.health = 100
		src.visible_message(text("<span class='alert'><B>[src] chills out!</B></span>"))
		if (src.unserious_sound)
			playsound(src.loc, src.unserious_sound, 50)
	gnash
		name = "gnash clone #"
		desc = "entropy babey!"
		icon_state = "gnarsh"
		zzz_overlay_sleep = TRUE
		owner ="FancySchmancyNecromancy"
		blood_id = "meat_slurry"
		ideal_blood_volume = 1500
		speechverb_say = "shreiks"
		speechverb_exclaim = "wails"
		death_text = "ooh shit, oh fuck its not getting up oh my god"
		can_bleed = 1
		lie_on_death = TRUE
		voice_type = null
		gender = FEMALE
		stepsound = "sound/misc/hastur/tentacle_walk.ogg"
		robot_talk_understand = TRUE
		event_handler_flags = USE_FLUID_ENTER | USE_CANPASS | IS_FARTABLE

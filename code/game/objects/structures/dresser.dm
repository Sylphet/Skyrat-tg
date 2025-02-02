//THIS FILE HAS BEEN EDITED BY SKYRAT EDIT

/obj/structure/dresser//SKYRAT EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "dresser"
	density = TRUE
	anchored = TRUE

/obj/structure/dresser/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, span_notice("You begin to [anchored ? "unwrench" : "wrench"] [src]."))
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, span_notice("You successfully [anchored ? "unwrench" : "wrench"] [src]."))
			set_anchored(!anchored)
	else
		return ..()

/obj/structure/dresser/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/dresser/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
			to_chat(user, span_warning("You are not capable of wearing underwear."))
			return

		var/choice = input(user, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in list("Underwear","Underwear Color","Undershirt","Undershirt Color","Socks","Socks Color") //SKYRAT EDIT ADDITION - Colorable Undershirt/Socks

		if(!Adjacent(user))
			return
		switch(choice)
			if("Underwear")
				var/new_undies = input(user, "Select your underwear", "Changing")  as null|anything in GLOB.underwear_list
				if(new_undies)
					H.underwear = new_undies

			if("Underwear Color")
				var/new_underwear_color = input(H, "Choose your underwear color", "Underwear Color","#"+H.underwear_color) as color|null
				if(new_underwear_color)
					H.underwear_color = sanitize_hexcolor(new_underwear_color)
			if("Undershirt")
				var/new_undershirt = input(user, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
				if(new_undershirt)
					H.undershirt = new_undershirt
			//SKYRAT EDIT ADDITION BEGIN - Colorable Undershirt/Socks
			if("Undershirt Color")
				var/new_undershirt_color = input(H, "Choose your undershirt color", "Undershirt Color","#"+H.undershirt_color) as color|null
				if(new_undershirt_color)
					H.undershirt_color = sanitize_hexcolor(new_undershirt_color)
			if("Socks")
				var/new_socks = input(user, "Select your socks", "Changing") as null|anything in GLOB.socks_list
				if(new_socks)
					H.socks= new_socks
			if("Socks Color")
				var/new_socks_color = input(H, "Choose your socks color", "Socks Color","#"+H.socks_color) as color|null
				if(new_socks_color)
					H.socks_color = sanitize_hexcolor(new_socks_color)
			//SKYRAT EDIT ADDITION END - Colorable Undershirt/Socks
		add_fingerprint(H)
		H.update_body()

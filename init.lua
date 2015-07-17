dofile(minetest.get_modpath("starwars").."/starwars_furnace.lua")

minetest.register_node("starwars:cobble", {
	description = "Star Wars Cobble",
	tiles = {"starwars_cobble.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:archive", {
	description = "Archive",
	tiles = {"archive_top.png", "archive_top.png", "archive.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_glass_defaults(),
})

local archive_formspec =
	"size[8,7;]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[context;books;0,0.3;8,2;]"..
	"list[current_player;main;0,2.85;8,1;]"..
	"list[current_player;main;0,4.08;8,3;8]"..
	default.get_hotbar_bg(0,2.85)

minetest.register_node("starwars:archive", {
	description = "Archive",
	tiles = {"archive_top.png", "archive_top.png", "archive.png"},
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", archive_formspec)
		local inv = meta:get_inventory()
		inv:set_size("books", 8*2)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("books")
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "books" then
			if minetest.get_item_group(stack:get_name(), "book") ~= 0
					and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "books" then
			if stack:get_name() == "default:book" and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff in archive at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff to archive at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " takes stuff from archive at "..minetest.pos_to_string(pos))
	end,
})


minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

local starwars_bookshelf_formspec =
	"size[8,7;]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[context;books;0,0.3;8,2;]"..
	"list[current_player;main;0,2.85;8,1;]"..
	"list[current_player;main;0,4.08;8,3;8]"..
	default.get_hotbar_bg(0,2.85)

minetest.register_node("starwars:bookshelf", {
	description = "Star Wars Bookshelf",
	tiles = {"starwars_bookshelf_top.png", "starwars_bookshelf_top.png", "starwars_bookshelf.png"},
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", starwars_bookshelf_formspec)
		local inv = meta:get_inventory()
		inv:set_size("books", 8*2)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("books")
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "books" then
			if minetest.get_item_group(stack:get_name(), "book") ~= 0
					and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "books" then
			if stack:get_name() == "default:book" and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff in starwars bookshelf at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff to starwars bookshelf at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " takes stuff from starwars bookshelf at "..minetest.pos_to_string(pos))
	end,
})


minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:durasteel", {
	description = "Durasteel",
	tiles = {"starwars_durasteel.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:damaged_durasteel", {
	description = "Damaged Durasteel",
	tiles = {"starwars_damaged_durasteel.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:corridor", {
	description = "Corridor",
	tiles = {"starwars_corridor.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:corridor2", {
	description = "Corridor2",
	tiles = {"starwars_corridor2.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:imperial_wall", {
	description = "Imperial Wall",
	tiles = {"starwars_imperial_wall.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:imperial_wall2", {
	description = "Imperial Wall 2",
	tiles = {"starwars_imperial_wall2.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:glowlamp", {
	description = "Glow Lamp",
	drawtype = "glasslike",
	tiles = {"glowlamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:transparisteel", {
	description = "Transparisteel",
	drawtype = "glasslike",
	tiles = {"transparisteel.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=3,oddly_breakable_by_hand=3},
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:stone", {
	description = "Star Wars Stone",
	tiles = {"starwars_stone.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:mossy_cobble", {
	description = "Star Wars Mossy Cobble",
	tiles = {"starwars_mossy_cobble.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:cobblestone", {
	description = "Star Wars Cobblestone",
	tiles = {"starwars_cobblestone.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:iron_bars", {
	description = "Star Wars Iron Bars",
	tiles = {"starwars_iron_bars.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:iron_block", {
	description = "Star Wars Iron Block",
	tiles = {"starwars_iron_block.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:iron_trapdoor", {
	description = "Star Wars Iron Trapdoor",
	tiles = {"starwars_iron_trapdoor.png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:ladder", {
	description = "Star Wars Ladder",
	drawtype = "signlike",
	tiles = {"starwars_ladder.png"},
	inventory_image = "starwars_ladder.png",
	wield_image = "starwars_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy=2,oddly_breakable_by_hand=3,flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:structural", {
	description = "Structural",
	tiles = {"starwars_structural.png"},
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:massassi_stone_brick", {
	description = "",
	tiles = {".png"},
	groups = {choppy=3,oddly_breakable_by_hand=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("starwars:torch", {
	description = "Star Wars Torch",
	drawtype = "torchlike",
	tiles = {
		{
			name = "starwars_torch.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0
			},
		},
		{
			name="starwars_torch.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0
			},
		},
		{
			name="starwars_torch.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0
			},
		},
	},
	inventory_image = "starwars_torch.png",
	wield_image = "starwars_torch.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = default.LIGHT_MAX - 1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})


minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:massassi_brick", {
	description = "Massassi Brick",
	tiles = {"starwars_massassi_brick.png"},
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

minetest.register_node("starwars:massassi_brick_mossy", {
	description = "Mossy Massassi Brick",
	tiles = {"starwars_massassi_brick_mossy.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'starwars: 4',
	recipe = {
		{'default:starwars'},
	}
})

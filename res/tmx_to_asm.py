import pytmx
import cv2
import numpy as np
import os


def get_image_from_gid(tmx_data, gid):
    tile_image = tmx_data.get_tile_image_by_gid(gid)

    if tile_image is not None:
        image_name = tile_image[0]
        img_x, img_y, img_width, img_height = tile_image[1]
        tile_image = cv2.imread(image_name)

        # convert image data to 0, 1, 2, 3
        palette_dict = {}
        for idx, val in enumerate(sorted([int(v) for v in np.unique(tile_image)])):
            palette_dict[val] = idx

        tile_image = tile_image[img_y: img_y + img_height, img_x:img_x + img_width]
        orig_image = np.copy(tile_image)

        # convert to raw binary data (lsb msb)
        binary_data = "db "
        for y in range(tile_image.shape[0]):
            lsb = []
            msb = []
            for x in range(tile_image.shape[1]):
                tile_image[y, x, 0] = palette_dict[tile_image[y, x, 0]]

            for value in tile_image[y, :, 0]:
                lsb.append(1-int(value) % 2)
                msb.append(1-int(value) // 2)

            lsb = "".join([str(val) for val in lsb])
            msb = "".join([str(val) for val in msb])
            binary_data += f'${int(lsb, 2):02x}, ${int(msb, 2):02x}, '
    binary_data = binary_data[:-2]
    return orig_image, binary_data


def tileset_to_asm(tmx_file_path, name):
    # Load the TMX file
    tmx_data = pytmx.TiledMap(tmx_file_path)

    print()
    print(f"Build Tileset ASM: {tmx_file_path}")
    print(f"    Map Size: {tmx_data.width}x{tmx_data.height} tiles")
    print(f"    Tile Size: {tmx_data.tilewidth}x{tmx_data.tileheight} pixels")

    tile_data = []
    obstructed_idxs = []
    unobstructed_idxs = []

    # Iterate through all tiles
    for layer in tmx_data.visible_layers:
        if isinstance(layer, pytmx.TiledTileLayer):
            if layer.name == "tiles":
                for x, y, gid in layer:  # Iterate over (x, y) tile positions and GIDs
                    orig_image, binary_data = get_image_from_gid(tmx_data, gid)

                    tile_data.append({"x": x, "y": y, "gid": gid, "binary": binary_data, "image": orig_image})

            if layer.name == "obstructed":
                for idx, (x, y, gid) in enumerate(layer):  # Iterate over (x, y) tile positions and GIDs

                    tile_image = tmx_data.get_tile_image_by_gid(gid)
                    if tile_image is not None:
                        obstructed_idxs.append(idx)
                    else:
                        unobstructed_idxs.append(idx)

    # Get unique tiles for both obstructed and unobstructed idxs
    obstructed_uniques = np.unique([tile_data[idx]["binary"] for idx in obstructed_idxs])
    unobstructed_uniques = np.unique([tile_data[idx]["binary"] for idx in unobstructed_idxs])
    total_uniques = np.unique([tile_data[idx]["binary"] for idx in obstructed_idxs + unobstructed_idxs])

    print(f"\n"
          f"    walkable tiles:   {len(unobstructed_uniques)}\n"
          f"    unwalkable tiles: {len(obstructed_uniques)}\n"
          f"    intersection:     {len(obstructed_uniques) + len(unobstructed_uniques) - len(total_uniques)}\n")
    print("    ", len(obstructed_uniques), len(unobstructed_uniques), "total:", len(obstructed_uniques) + len(unobstructed_uniques), "(127 possible)")

    output_str = f'SECTION "{name} Tiles", ROM0\n\n'
    output_str += f'{name}Start::\n'
    for tile in unobstructed_uniques:
        output_str += tile
        output_str += '\n'
    output_str += f"{name}Obstructed::\n"
    for tile in obstructed_uniques:
        output_str += tile
        output_str += '\n'
    output_str += f"{name}End::\n"

    with open(f"../src/tiles_{name.lower()}.asm", "w") as f:
        f.write(output_str)

    return {"tiles": list(unobstructed_uniques) + list(obstructed_uniques), "name": name, "walkable": len(unobstructed_uniques)}


def objects_to_asm(tmx_file_path, name):
    # Load the TMX file
    tmx_data = pytmx.TiledMap(tmx_file_path)

    print()
    print(f"Build Sprite ASM: {tmx_file_path}")
    print(f"    Map Size: {tmx_data.width}x{tmx_data.height} tiles")
    print(f"    Tile Size: {tmx_data.tilewidth}x{tmx_data.tileheight} pixels")

    tile_data = []
    # Iterate through all tiles
    for layer in tmx_data.visible_layers:
        if isinstance(layer, pytmx.TiledTileLayer):
            if layer.name == "tiles":
                for x, y, gid in layer:  # Iterate over (x, y) tile positions and GIDs
                    orig_image, binary_data = get_image_from_gid(tmx_data, gid)

                    tile_data.append({"x": x, "y": y, "gid": gid, "binary": binary_data, "image": orig_image})


    output_str = f'SECTION "{name} Tiles", ROMX, BANK[1]\n\n'
    output_str += f'{name}Start::\n'
    for tile in tile_data:
        output_str += tile["binary"]
        output_str += '\n'
    output_str += f"{name}End::\n"

    with open(f"../src/tiles_{name.lower()}.asm", "w") as f:
        f.write(output_str)

    return


def get_name_from_path(path):
    return os.path.basename(path).split(".")[0]


def simple_tilemap_to_asm(tmx_file_path, tileset):
    tmx_data = pytmx.TiledMap(tmx_file_path)
    name = get_name_from_path(tmx_file_path)

    print()
    print(f"Build Simple Tilemap ASM: {tmx_file_path}")

    tileset_data = np.zeros((32, 32), np.uint8)
    for layer in tmx_data.visible_layers:
        if isinstance(layer, pytmx.TiledTileLayer):
            if layer.name == "tiles":
                for x, y, gid in layer:  # Iterate over (x, y) tile positions and GIDs
                    orig_image, binary_data = get_image_from_gid(tmx_data, gid)
                    tileset_data[y, x] = tileset["tiles"].index(binary_data)

    output_str = f'INCLUDE "./include/hardware.inc"\n\n'

    output_str += f'SECTION "{name} Tilemap", ROMX, BANK[1]\n\n'
    output_str += f"{name}Start::\n"
    for row in range(32):
        output_str += "db "
        for column in range(32):
            output_str += f"${tileset_data[row, column]:02x}, "
        output_str = output_str[:-2] + "\n"
    output_str += f"{name}End::\n\n"

    output_str += (
        f'{name}Load::\n'
        f'    ld de, {tileset["name"]}Start\n'
        f'    ld hl, $9000  ; Tileblock 2\n'
        f'    ld bc, {tileset["name"]}End - {tileset["name"]}Start\n'
        f'    call Memcopy\n'
        f'\n'
        f'    ld de, {name}Start\n'
        f'    ld hl, $9800  ; Tilemap 0\n'
        f'    ld bc, {name}End - {name}Start\n'
        f'    call Memcopy\n'
        f'    ret\n\n'
    )

    with open(f"../src/tilemap_{name.lower()}.asm", "w") as f:
        f.write(output_str)


def tilemap_to_asm(tmx_file_path, tileset, exits):
    tmx_data = pytmx.TiledMap(tmx_file_path)
    name = get_name_from_path(tmx_file_path)

    print()
    print(f"Build Tilemap ASM: {tmx_file_path}")

    patientX = None
    patientY = None
    patientID = None

    for object in tmx_data.objects:
        name_split = object.name.replace(" ", "").split(",")
        if len(name_split) == 5: # patient object
            patientX = int(object.x)
            patientY = int(object.y)
            patientID = name_split[0][-1]
            patientTile = int(name_split[1])*4
            patientSpirit = name_split[2]
            patientRhythm = name_split[3]
            patientTimePerBeat = name_split[4]

    tileset_data = np.zeros((32, 32), np.uint8)
    for layer in tmx_data.visible_layers:
        if isinstance(layer, pytmx.TiledTileLayer):
            if layer.name == "tiles":
                for x, y, gid in layer:  # Iterate over (x, y) tile positions and GIDs
                    orig_image, binary_data = get_image_from_gid(tmx_data, gid)
                    tileset_data[y, x] = tileset["tiles"].index(binary_data)

    output_str = f'INCLUDE "./include/hardware.inc"\n\n'
    output_str += f'INCLUDE "./include/constants.inc"\n\n'

    output_str += f'SECTION "{name} Tilemap", ROMX, BANK[1]\n\n'
    output_str += f"{name}Start::\n"
    for row in range(32):
        output_str += "db "
        for column in range(32):
            output_str += f"${tileset_data[row, column]:02x}, "
        output_str = output_str[:-2] + "\n"
    output_str += f"{name}End::\n\n"

    output_str += (
        f'{name}Load::\n'
        f'    ld de, {tileset["name"]}Start\n'
        f'    ld hl, $9000  ; Tileblock 2\n'
        f'    ld bc, {tileset["name"]}End - {tileset["name"]}Start\n'
        f'    call Memcopy\n'
        f'\n'
        f'    ld de, {name}Start\n'
        f'    ld hl, $9800  ; Tilemap 0\n'
        f'    ld bc, {name}End - {name}Start\n'
        f'    call Memcopy\n'
        f'\n'
        f'    ld a, ${int(tileset["walkable"]):02x}\n'
        f'    ld [wUnwalkableTileIdx], a\n'
        f'\n'
        f'    ld hl, wCurrentMapCheckExits         ; Point HL to wCurrentMapCheckExits\n'
        f'    ld [hl], LOW({name}CheckExit)        ; Store the low byte\n'
        f'    inc hl                               ; Move to the high byte\n'
        f'    ld [hl], HIGH({name}CheckExit)       ; Store the high byte\n'
        f'\n'
        f'    ld a, $F8\n'
        f'    ld [wPatientY], a\n'
        f'    ld a, $F0\n'
        f'    ld [wPatientX], a\n'
    )

    if patientID is not None:
        output_str += (
            f'\n'
            f'    ld a, [wSuccessfulRitualCounter]\n'
            f'    cp a, {patientID}\n'
            f'    jp nz, .update\n'
            f'    ld a, {patientY}\n'
            f'    ld [wPatientY], a\n'
            f'    ld a, {patientX}\n'
            f'    ld [wPatientX], a\n'
            f'    ld a, {patientTile}\n'
            f'    ld [wPatientTileOffset], a\n'
            f'    ld a, {patientSpirit}\n'
            f'    ld [wRitualSpirit], a\n'
            f'    ld a, {patientTimePerBeat}\n'
            f'    ld [wTimePerBeat], a\n'
            f'    ld a, `{patientRhythm}\n'
            f'    ld [wCorrectSolution], a\n'
            f'.update\n'
        )

    output_str += (
        f'    call UpdatePatientObject\n'
        f'    call UpdatePlayerObject\n'
        f'    ret\n\n'
    )

    # collect exits regarding their X coordinate
    grouped_exits = {}
    for exit in exits:
        if exit["teleport_x"] not in grouped_exits:
            grouped_exits[exit["teleport_x"]] = []
        grouped_exits[exit["teleport_x"]].append(exit)

    output_str += f"{name}CheckExit::\n"
    output_str += (
        f"    ; Check for Room exit\n"
        f"    ; first check x coordinate\n"
        f"    ld a, [wPlayerX]\n"
    )
    for idx, exit_group in enumerate(grouped_exits.values()):
        output_str += (
            f"    cp a, {exit_group[0]['teleport_x']}\n"
            f"    jp z, .checkY{idx}\n"
        )

    output_str += f"    ret\n"
    output_str += f"\n    ; if there is a match, check y coordinate\n\n"
    for idx, exit_group in enumerate(grouped_exits.values()):
        output_str += f".checkY{idx}\n"
        for exit_idx, exit in enumerate(exit_group):
            output_str += (
                f".subcheck{idx}_{exit_idx}\n"
                f"    ld a, [wPlayerY]\n"
                f"    cp a, {exit['teleport_y']}\n"
                f"    jp nz, .subcheck{idx}_{exit_idx+1}\n"
                f"    ld a, {exit['target_x']}\n"
                f"    ld [wPlayerX], a\n"
                f"    ld a, {exit['target_y']}\n"
                f"    ld [wPlayerY], a\n"
                f'    ld a, 8\n'
                f'    ld [wVBlankCount], a\n'
                f'    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly\n'
                f"    call TurnLcdOff\n"
                f"    call {exit['destination']}Load\n"
                f"    jp .final\n"
            )
        output_str += (
            f".subcheck{idx}_{len(exit_group)}\n"
            f"    ret\n"
        )
    output_str += (
        f".final\n"
        f"    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON\n"
        f"    ld [rLCDC], a\n"
        f"    ret\n"
    )

    with open(f"../src/tilemap_{name.lower()}.asm", "w") as f:
        f.write(output_str)

def collect_level_exits(level_list):
    entries = {}
    for level in level_list:
        tmx_data = pytmx.TiledMap(level)
        level_name = get_name_from_path(level)
        entries[level_name] = {}
        for object in tmx_data.objects:
            name_split = object.name.strip(" ").split(",")
            if len(name_split) == 1:
                entries[level_name][object.name] = {
                    "x": int(object.x),
                    "y": int(object.y)
                }

    exits = {}
    for level in level_list:
        tmx_data = pytmx.TiledMap(level)
        exits[level] = []
        for object in tmx_data.objects:
            name_split = object.name.replace(" ", "").split(",")
            if len(name_split) == 3:  # level exit
                exit_idx, exit_to_level_name, entry_idx = name_split
                exits[level].append({
                    "teleport_x": int(object.x),
                    "teleport_y": int(object.y),
                    "target_x": entries[exit_to_level_name][entry_idx]["x"],
                    "target_y": entries[exit_to_level_name][entry_idx]["y"],
                    "destination": exit_to_level_name,
                })

    return exits


if __name__ == "__main__":
    tmx_file_path = "./raw/character_map.tmx"  # Replace with your TMX file path
    objects_to_asm(tmx_file_path, "CharacterMap")

    tmx_file_path = "./raw/all_inside.tmx"  # Replace with your TMX file path
    tileset_inside = tileset_to_asm(tmx_file_path, "Inside")

    tmx_file_path = "./raw/all_outside.tmx"  # Replace with your TMX file path
    tileset_outside = tileset_to_asm(tmx_file_path, "Outside")

    tmx_file_path = "./raw/all_ritual.tmx"  # Replace with your TMX file path
    tileset_ritual = tileset_to_asm(tmx_file_path, "Ritual")

    simple_tilemap_to_asm("./raw/ritual_tilemap.tmx", tileset_ritual)

    inside_levels = [
        "./raw/ShamanHutInside.tmx",
        "./raw/PoorWomanHutInside.tmx",
        #"./raw/ManHutInside.tmx",
        #"./raw/ManHutInside2.tmx",
    ]
    outside_levels = [
        "./raw/ShamanHutOutside.tmx",
        "./raw/WayToTheVillage.tmx",
        "./raw/WayToTheVillage2.tmx",
        "./raw/PoorWomanHutOutside.tmx",
        #"./raw/ManHutOutside.tmx",
    ]
    all_levels = inside_levels + outside_levels
    exits_dict = collect_level_exits(all_levels)

    for level in inside_levels:
        tilemap_to_asm(level, tileset_inside, exits_dict[level])
    for level in outside_levels:
        tilemap_to_asm(level, tileset_outside, exits_dict[level])

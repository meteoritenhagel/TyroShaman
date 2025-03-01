import pytmx
import cv2
import numpy as np

def traverse_tmx_tiles(tmx_file_path):
    # Load the TMX file
    tmx_data = pytmx.TiledMap(tmx_file_path)

    print(f"Map: {tmx_file_path}")
    print(f"Map Size: {tmx_data.width}x{tmx_data.height} tiles")
    print(f"Tile Size: {tmx_data.tilewidth}x{tmx_data.tileheight} pixels")

    tile_data = []
    obstructed_idxs = []
    unobstructed_idxs = []

    palette_dict = None

    # Iterate through all tiles
    for layer in tmx_data.visible_layers:
        if isinstance(layer, pytmx.TiledTileLayer):
            if layer.name == "tiles":
                for x, y, gid in layer:  # Iterate over (x, y) tile positions and GIDs
                    tile_image = tmx_data.get_tile_image_by_gid(gid)

                    if tile_image is not None:
                        image_name = tile_image[0]
                        img_x, img_y, img_width, img_height = tile_image[1]
                        tile_image = cv2.imread(image_name)

                        # convert image data to 0, 1, 2, 3
                        if palette_dict is None:
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
                                lsb.append(int(value) % 2)
                                msb.append(int(value) // 2)

                            lsb = "".join([str(val) for val in lsb])
                            msb = "".join([str(val) for val in msb])
                            binary_data += f'${int(lsb, 2):02x}, ${int(msb, 2):02x}, '

                    tile_data.append({"x": x, "y": y, "gid": gid, "binary": binary_data[:-2], "image": orig_image})

            if layer.name == "obstructed":
                for idx, (x, y, gid) in enumerate(layer):  # Iterate over (x, y) tile positions and GIDs

                    tile_image = tmx_data.get_tile_image_by_gid(gid)
                    if tile_image is not None:
                        obstructed_idxs.append(idx)
                    else:
                        unobstructed_idxs.append(idx)

    # Get unique tiles for both obstructed and unobstructed idxs
    obstructed_uniques, obstructed_tile_idxs, obstructed_tile_inverse = np.unique([tile_data[idx]["binary"] for idx in obstructed_idxs], return_index=True, return_inverse=True)
    unobstructed_uniques, unobstructed_tile_idxs, unobstructed_tile_inverse = np.unique([tile_data[idx]["binary"] for idx in unobstructed_idxs], return_index=True, return_inverse=True)

    obstructed_images = []
    unobstructed_images = []

    for idx, tile in enumerate(tile_data):
        if idx in obstructed_uniques:
            obstructed_images.append(tile["image"])
        else:
            unobstructed_images.append(tile["image"])


    print(len(obstructed_uniques), len(unobstructed_uniques), "total:", len(obstructed_uniques) + len(unobstructed_uniques), "(127 possible)")


if __name__ == "__main__":
    tmx_file_path = "./raw/all_inside.tmx"  # Replace with your TMX file path
    traverse_tmx_tiles(tmx_file_path)
import uuid
import sys
from shutil import copy2

from wand.color import Color
from wand.font import Font
from wand.image import Image
from PIL import Image as pil_Image


def resize_and_overwrite(filename, new_width, new_height):
    with Image(filename=filename) as img:
        # First rotate image for correct orientation.
        # This line fix image orientation based on exif data.
        img.auto_orient()

        img.sample(new_width, new_height)
        img.save(filename=filename)
    return True, filename


def sensitive_resize_and_overwrite(filename, new_width, new_height):

    with Image(filename=filename) as img:
        max_size = str(new_width) + 'x' + str(new_height)
        # First rotate image for correct orientation.
        # This line fix image orientation based on exif data.
        img.auto_orient()

        # If the image is larger than max_size, rescale with respecting ratio.
        img.transform(resize=max_size+'>')
        img.save(filename=filename)
    return True, filename


def create_thumbnail(source_forlder, filename, dest_foldername):
    copy2(source_forlder+'/'+filename, dest_foldername)
    return sensitive_resize_and_overwrite(dest_foldername+'/'+filename, 100, 100)


def horizontal_concat(image_paths):
    '''
    Helper function for concat_images. It opens the image files in image path list and,
        It merges them horizontally.
    Be careful, Image files are closed at the end of this function!
    :param image_paths: List of file paths.
    :return: One merged Image object.
    '''
    images = map(pil_Image.open, image_paths)
    widths, heights = zip(*(i.size for i in images))

    min_height = min(heights)
    max_width = max(widths)
    size = (max_width, min_height)

    for image in images:
        image.thumbnail(size, pil_Image.ANTIALIAS)

    total_width = sum(i.size[0] for i in images)

    new_image = pil_Image.new('RGBA', (total_width, min_height))

    x_offset = 0
    for image in images:
        new_image.paste(image, (x_offset, 0))
        x_offset += image.size[0]
        image.close()

    return new_image


def vertical_concat(images):
    '''
    Helper function for concat_images. It merges given images in the list vertically.
    Be careful, Image files are closed at the end of this function!
    :param images: List of Image objects.
    :return: One merged Image object.
    '''
    widths, heights = zip(*(i.size for i in images))

    max_height = max(heights)
    min_width = min(widths)
    size = (min_width, max_height)

    for image in images:
        image.thumbnail(size, pil_Image.ANTIALIAS)

    total_height = sum(i.size[1] for i in images)
    #If it is changed to RGB, it will not work with PNG files.
    new_image = pil_Image.new('RGBA', (min_width, total_height))

    y_offset = 0
    for image in images:
        new_image.paste(image, (0, y_offset))
        y_offset += image.size[1]
        image.close()

    return new_image


def concat_images(image_paths, destination_folder=None):
    '''
    This function creates merged images and saves them in destination_folder if it is given,
        or saves them the current location.
    :param list of str list image_paths: It is list of lists which has image filenames with endings as full paths.
                    Example: [['images/a.png', 'images/b.png'],['images/1.png', 'images/2.png']]
                    Every element of it will be concatenated horizontally i.e. a.png and b.png and after that
                    every horizontally concatenated list will be concatenated vertically.
    :param str destination_folder: Folder path to save output image.

    :returns Tuple of bool and str: Status of operation and file path for output image.
    '''

    horizontal_merged_images = []
    try:
        for images in image_paths:
            horizontal_merged_images.append(horizontal_concat(images))

        output_image = vertical_concat(horizontal_merged_images)
        output_name = 'concat_' + str(uuid.uuid4()) + '.png'

        if destination_folder:
            output_image.save(destination_folder+output_name)
        else:
            output_image.save(output_name)
    except:
        return False, None

    return True, output_name


def add_caption(filename, caption_text, destination_folder=None):
    with Image() as outputimage:
        with Image(filename=filename) as img:
            font_size = 12
            margin = 2
            output_height = img.height + font_size + (margin * 2)
            caption_x = margin
            caption_y = img.height + margin
            outputimage.blank(width=img.width, height=output_height, background=Color('white'))
            outputimage.composite(img, 0, 0)
            font = Font(path='fonts/Roboto/Roboto-Medium.ttf', color=Color('black'))
            outputimage.caption(text=caption_text, font=font, left=caption_x, top=caption_y, gravity='center')
            output_name = 'caption_' + str(uuid.uuid4()) + '.png'
            if destination_folder:
                outputimage.save(filename=destination_folder+output_name)
            else:
                outputimage.save(filename=output_name)
    return True, output_name

############################## UNUSED FUNCTIONS ##############################
# Below functions are for concat operations however, they use another method
#   by using WAND.
#
# def vertical_concat(imgA, imgB, destination_folder=None):
#     with Image() as outputimage:
#         helper_concat(imgA, imgB, outputimage)
#         output_name = 'ver_concat_'+str(uuid.uuid4())+'.png'
#         if destination_folder:
#             output_name = destination_folder + '/' + output_name
#         outputimage.save(filename=output_name)
#     return True, output_name
#
#
# def helper_concat(imgA, imgB, outputimage):
#     with Image(filename=imgA) as imageA:
#         with Image(filename=imgB) as imageB:
#             width_A = imageA.width
#             width_B = imageB.width
#             if width_A <= width_B:
#                 width_output = width_A
#                 imageB.transform(resize=str(width_output) + 'x')
#             else:
#                 width_output = width_B
#                 imageA.transform(resize=str(width_output) + 'x')
#             height_output = imageA.height + imageB.height
#             outputimage.blank(width_output, height_output)
#             outputimage.composite(imageA, 0, 0)
#             # outputimage.composite(imageB, w, 0)
#             outputimage.composite(imageB, 0, imageA.height)
#
#
# def concat(imgA, imgB):
#     with Image() as outputimage:
#         with Image(filename=imgA) as imageA:
#             with Image(filename=imgB) as imageB:
#                 w = imageA.width
#                 h = imageA.height
#                 outputimage.blank(w, h*2)
#                 outputimage.composite(imageA, 0, 0)
#                 #outputimage.composite(imageB, w, 0)
#                 outputimage.composite(imageB,0,h)
#                 outputimage.save(filename='output.png')
##############################################################################
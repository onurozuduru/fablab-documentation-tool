import uuid
from shutil import copy2

from wand.color import Color
from wand.drawing import Drawing
from wand.font import Font
from wand.image import Image


def resize_and_overwrite(filename, new_width, new_height):
    with Image(filename=filename) as img:
        img.sample(new_width, new_height)
        img.save(filename=filename)
    return True, filename


def sensitive_resize_and_overwrite(filename, new_width, new_height):
    with Image(filename=filename) as img:
        max_size = str(new_width) + 'x' + str(new_height)
        # If the image is larger than max_size, rescale with respecting ratio.
        img.transform(resize=max_size+'>')
        img.save(filename=filename)
    return True, filename
    # with Image(filename=filename) as img:
    #     width = img.width
    #     height = img.height
    #     if width < new_width and height < new_height:
    #         return True, filename
    #     if width > height:
    #         ratio = float(new_width)/float(width)
    #         new_height = int(height*ratio)
    #     else:
    #         ratio = float(new_height)/float(height)
    #         new_width = int(width*ratio)
    #     img.sample(new_width, new_height)
    #     img.save(filename=filename)
    # return True, filename


def create_thumbnail(source_forlder, filename, dest_foldername):
    copy2(source_forlder+'/'+filename, dest_foldername)
    return sensitive_resize_and_overwrite(dest_foldername+'/'+filename, 100, 100)


def concat(imgA, imgB):
    with Image() as outputimage:
        with Image(filename=imgA) as imageA:
            with Image(filename=imgB) as imageB:
                w = imageA.width
                h = imageA.height
                outputimage.blank(w, h*2)
                outputimage.composite(imageA, 0, 0)
                #outputimage.composite(imageB, w, 0)
                outputimage.composite(imageB,0,h)
                outputimage.save(filename='output.png')


def helper_concat(imgA, imgB, outputimage):
    with Image(filename=imgA) as imageA:
        with Image(filename=imgB) as imageB:
            width_A = imageA.width
            width_B = imageB.width
            if width_A <= width_B:
                width_output = width_A
                imageB.transform(resize=str(width_output) + 'x')
            else:
                width_output = width_B
                imageA.transform(resize=str(width_output) + 'x')
            height_output = imageA.height + imageB.height
            outputimage.blank(width_output, height_output)
            outputimage.composite(imageA, 0, 0)
            # outputimage.composite(imageB, w, 0)
            outputimage.composite(imageB, 0, imageA.height)


def vertical_concat(imgA, imgB, destination_folder=None):
    with Image() as outputimage:
        helper_concat(imgA, imgB, outputimage)
        output_name = 'ver_concat_'+str(uuid.uuid4())+'.png'
        if destination_folder:
            output_name = destination_folder + '/' + output_name
        outputimage.save(filename=output_name)
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

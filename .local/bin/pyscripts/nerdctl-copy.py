#!/usr/bin/env python

import os
import fire


def hello(image, target, discard_ns=False, local=False):
    new_image = image
    if discard_ns:
        new_image = os.path.basename(image)

    new_image = "{}/{}".format(target, new_image)

    cmd = "lima sudo nerdctl"
    print("{} ==> {}".format(image, new_image))
    os.system(cmd+" pull {} --all-platforms".format(image))
    os.system(cmd+" tag {} {}".format(image, new_image))
    if not local:
        os.system(cmd+" push {} --all-platforms".format(new_image))


if __name__ == '__main__':
    fire.Fire(hello)

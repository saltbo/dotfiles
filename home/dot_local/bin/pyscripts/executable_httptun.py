#!/usr/bin/env python

import os
import fire


def expose(local_port, sub_domain=os.path.basename(os.getcwd())):
    token = os.getenv("FRP_TOKEN")
    if not token:
        return "none token for frp"

    print("http://{}.dev.saltbo.cn  => :{}".format(sub_domain, local_port))
    cmd = "frpc http -s frps.saltbo.cn:7000 -t {} --sd {} -l {}"
    os.system(cmd.format(token, sub_domain, local_port))


if __name__ == '__main__':
    fire.Fire(expose)

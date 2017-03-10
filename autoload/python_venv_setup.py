# -*- coding: utf-8 -*-

import sys
import pkg_resources
from pkg_resources import DistributionNotFound, VersionConflict

dependencies = sys.argv[1:]

try:
    # here, if a dependency is not met, a DistributionNotFound or VersionConflict
    # exception is thrown.
    pkg_resources.require(dependencies)
except (DistributionNotFound, VersionConflict):
    import pip

    args = ['install', '-v'] + dependencies

    # Use 123 to tell neovim that a restart is needed, otherwise signal an error
    retval = pip.main(initial_args=args) or 123

    sys.exit(retval)


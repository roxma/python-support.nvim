#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import pkg_resources
from pkg_resources import DistributionNotFound, VersionConflict

dependencies = sys.argv[1:]

try:
    # here, if a dependency is not met, a DistributionNotFound or VersionConflict
    # exception is thrown. 
    pkg_resources.require(dependencies)
except DistributionNotFound:
    print("python3 module dependency missing, please execute ':PythonSupportInitPython3'")


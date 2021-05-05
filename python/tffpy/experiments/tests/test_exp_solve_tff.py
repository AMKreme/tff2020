# -*- coding: utf-8 -*-
# ######### COPYRIGHT #########
# Credits
# #######
#
# Copyright(c) 2020-2020
# ----------------------
#
# * Laboratoire d'Informatique et Systèmes <http://www.lis-lab.fr/>
# * Université d'Aix-Marseille <http://www.univ-amu.fr/>
# * Centre National de la Recherche Scientifique <http://www.cnrs.fr/>
# * Université de Toulon <http://www.univ-tln.fr/>
#
# Contributors
# ------------
#
# * `Valentin Emiya <mailto:valentin.emiya@lis-lab.fr>`_
# * `Ama Marina Krémé <mailto:ama-marina.kreme@lis-lab.fr>`_
#
# This package has been created thanks to the joint work with Florent Jaillet
# and Ronan Hamon on other packages.
#
# Description
# -----------
#
# Time frequency fading using Gabor multipliers
#
# Version
# -------
#
# * tffpy version = 0.1.3
#
# Licence
# -------
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# ######### COPYRIGHT #########
"""Test of the module :module:`tffpy.experiments.exp_solve_tff`

.. moduleauthor:: Valentin Emiya
"""
import unittest

import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.rcParams['figure.max_open_warning'] = 40

from tffpy.experiments.exp_solve_tff import \
    SolveTffExperiment, create_and_run_light_experiment
from tffpy.tests.ci_config import create_config_files


class TestSolveTffExperiment(unittest.TestCase):
    def setUp(self):
        create_config_files()

    def test_light_experiment(self):
        create_and_run_light_experiment()

        light_exp = SolveTffExperiment.get_experiment(
            setting='light', force_reset=False)
        for idt in range(light_exp.n_tasks):
            light_exp.plot_task(idt=idt, fontsize=16)
            plt.close('all')
        light_exp.plot_results()
        plt.close('all')

    def test_create_full_experiment(self):
        experiment = SolveTffExperiment.get_experiment(
            setting='full', force_reset=False)
        experiment.display_status()

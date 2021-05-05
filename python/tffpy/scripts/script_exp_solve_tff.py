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
"""
Run this script to handle the main experiment :class:`SolveTffExperiment`.

.. moduleauthor:: Valentin Emiya
"""
from yafe.utils import generate_oar_script

import matplotlib.pyplot as plt

from tffpy.experiments.exp_solve_tff import \
    SolveTffExperiment, create_and_run_light_experiment


try:
    experiment = SolveTffExperiment.get_experiment(setting='full',
                                                   force_reset=False)
except RuntimeError:
    experiment = None
except FileNotFoundError:
    experiment = None

if __name__ == '__main__':
    answer = 1
    while answer > 0:
        input_msg = '\n'.join(['1 - Create and run light experiment',
                               '2 - Display results of light experiment',
                               '3 - Full experiment: create full experiment',
                               '4 - Generate OAR script',
                               '5 - Full experiment: collect results',
                               '6 - Full experiment: download results',
                               '7 - Full experiment: display results',
                               '8 - Figures for task 12 (bird + car, TFF-1)',
                               '9 - Figures for task 13 (bird + car, TFF-P)',
                               '0 - Exit',
                               ])
        answer = int(input(input_msg))
        if answer == 0:
            break
        elif answer == 1:
            create_and_run_light_experiment()
        elif answer == 2:
            light_exp = SolveTffExperiment.get_experiment(
                setting='light', force_reset=False)
            for idt in range(light_exp.n_tasks):
                light_exp.plot_task(idt=idt, fontsize=16)
                plt.close('all')
            light_exp.plot_results()
        elif answer == 3:
            experiment = SolveTffExperiment.get_experiment(
                setting='full', force_reset=True)
            experiment.display_status()
        elif answer == 4:
            experiment.display_status()
            batch_size = int(input('Batch size (#tasks per job)?'))
            generate_oar_script(script_file_path=__file__,
                                xp_var_name='experiment',
                                batch_size=batch_size,
                                oar_walltime='01:00:00',
                                activate_env_command='source activate py36',
                                use_gpu=False)
        elif answer == 5:
            experiment.collect_results()
            experiment.display_status()
        elif answer == 6:
            to_dir = str(experiment.xp_path)
            from_dir = \
                '/data1/home/valentin.emiya/data_exp/SolveTffExperiment/'
            print('Run:')
            print(' '.join(['rsync', '-rv',
                            'valentin.emiya@frontend.lidil.univ-mrs.fr:'
                            + from_dir,
                            to_dir]))
            print('Or (less files):')
            print(' '.join(['rsync', '-rv',
                            'valentin.emiya@frontend.lidil.univ-mrs.fr:'
                            + from_dir
                            + '*.*',
                            to_dir]))
        elif answer == 7:
            experiment.plot_results()
            experiment.display_status()
        elif answer in (8, 9):
            task_params = {'data_params': {'loc_source': 'bird',
                                           'wideband_src': 'car'},
                           'problem_params': {'closing_first': True,
                                              'delta_loc_db': 40,
                                              'delta_mix_db': 0,
                                              'fig_dir': None,
                                              'n_iter_closing': 3,
                                              'n_iter_opening': 3,
                                              'or_mask': True,
                                              'wb_to_loc_ratio_db': 8,
                                              'win_choice': 'gauss 256',
                                              'crop': None},
                           'solver_params': {'proba_arrf': 0.9999,
                                             'tolerance_arrf': 0.001}}
            if answer == 8:
                task_params['solver_params']['tol_subregions'] = None
            elif answer == 9:
                task_params['solver_params']['tol_subregions'] = 1e-05
            task = experiment.get_task_data_by_params(**task_params)
            experiment.run_task_by_id(idt=task['id_task'])
            experiment.plot_task(idt=task['id_task'], fontsize=16)
        else:
            print('Unknown answer: ' + str(answer))

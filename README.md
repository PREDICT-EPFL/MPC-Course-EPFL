# Software setup for MPC course

This class uses Python for the coding exercises and the project.
Below you will find instructions for installing a working Python environment and all the libraries that we will use throughout the semester.

## Setting up the environment

All the exercises and the setup instructions can be found in this repo (https://github.com/PREDICT-EPFL/MPC-Course-EPFL). We will update it regularly to add exercises and fix issues.

The setup will use `conda` to install Python and create a dedicated environment for the course, and `pip` to install the required packages. Everything has been tested on macOS, Linux and Windows (not WSL though).

1. **Install git**: Make sure you sure you have `git` installed on your computer. If you don't, please follow the following instructions: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

2. **Clone the repo**: Open a terminal and clone the repo (any terminal will do on macOS/Linux, open Git Bash on Windows) at your desired location on your computer.
```bash
git clone https://github.com/PREDICT-EPFL/MPC-Course-EPFL.git
```

3. **Install conda**: Install a `conda` distribution. The simplest for beginners is [Anaconda](https://www.anaconda.com/download), but any other will do ([miniconda](https://www.anaconda.com/docs/getting-started/miniconda/install), [miniforge](https://github.com/conda-forge/miniforge), etc.).
Note that you do not have to create any account to download Anaconda, just skip all registration steps.
Once the installation is complete, you should be able to run the following in a new terminal on macOS/Linux or Anaconda Prompt/PowerShell Prompt on Windows:
```bash
conda info
```

4. **Create environment**: In the same terminal as before, navigate inside the cloned the repo and create the conda environment with the following commands:

```bash
conda create -y -n mpc2026 python=3.12 pip
conda activate mpc2026
pip install -r locked-requirements.txt
```

5. **Install editor**: For beginners, we recommend using Jupyter Lab to edit the notebooks for the programming exercises. It should already be installed with the previous steps, so you can start it by running in the same terminal as before with
```bash
jupyter lab
```
If you prefer using another editor like VSCode or PyCharm, please do! Simply make sure you have installed all the appropriate extensions and **make sure that these will not install dependencies in the environment we created** (in particular, do not accept notifications offering to install `jupyter` or `ipykernel` or `pandas` and call for help to avoid messing up your environment).

For VSCode, please install the [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) extensions, and follow [these instructions](https://code.visualstudio.com/docs/python/environments#_select-and-activate-an-environment) to associate an environment to the `MPC-Course-EPFL` folder. 
Make sure to:
- always open `MPC-Course-EPFL` as a folder and not a workspace
- choose the `mpc2026` conda enviroment we have just created
- if it's not done automatically, use the kernel associated to the `mpc2026` environment in every notebook

## Testing the environment is properly set up

The best way to test if your installation worked, is to open the first tutorial notebook [`tutorial.ipynb`](tutorial.ipynb) that will go through some documentation you might want to read to get up to speed with libraries we will use this semester.
1. Make a copy of the `tutorial.ipynb` notebook and rename it to `my_tutorial.ipynb`.
2. Open Jupyter Lab or VSCode as you did above.
3. Open the `my_tutorial.ipynb` notebook and select the kernel in the `mpc2026` environment if it's not done automatically.

## Updating the libraries

If we ever update the libraries versions and ask you to update your environment:

1. Open a regular terminal on macOS/Linux or Git Bash on Windows, navigate to this repository and run 
```bash
git pull
```
2. Now open a new terminal on macOS/Linux or Anaconda Prompt/PowerShell Prompt on Windows, activate the environment again and simply reinstall the dependencies:
```bash
conda activate mpc2026
pip install -r locked-requirements.txt
```

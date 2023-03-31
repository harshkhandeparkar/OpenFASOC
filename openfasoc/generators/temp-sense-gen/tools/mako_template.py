from mako.template import Template

import os
from os import path

PARAMETERS = {
    "design_name": "tempsenseInst_error",
    "ninv": 6,
    "nbout": "X",
    "header": "HEADER",
    "cell_prefix": "sky130_fd_sc_hd__",
    "cell_postfix": "_1"
}

def get_output_filepath(filename, output_folder):
    return path.join(output_folder, filename.replace(".template", ""))

def generate(filename, input_folder, output_folder):
    template = Template(filename=path.join(input_folder, filename))

    out_file = open(get_output_filepath(filename, output_folder), "w")
    out_file.write(template.render(**PARAMETERS))

def generate_temp_sense_verilog(input_folder, output_folder):
    if not path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        if ".v" in filename or ".sv" in filename:
            generate(filename, input_folder, output_folder)

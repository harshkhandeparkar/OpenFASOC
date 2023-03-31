from mako.template import Template

import os
from os import path

PARAMETERS = {
    "design_name": "tempsenseInst_error",
    "ninv": 6,
    "nand2": "sky130_fd_sc_hd__nand2_1",
    "inv": "sky130_fd_sc_hd__inv_1",
    "buf": "sky130_fd_sc_hd__buf_1",
    "nbout": "X",
    "header": "HEADER"
}

def get_output_filepath(filename, output_folder):
    return path.join(output_folder, filename.replace(".template", ""))

def generate(filename, input_folder, output_folder):
    mytemplate = Template(filename=path.join(input_folder, filename))

    out_file = open(get_output_filepath(filename, output_folder), "w")
    out_file.write(mytemplate.render(**PARAMETERS))

def generate_temp_sense_verilog(input_folder, output_folder):
    if not path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        generate(filename, input_folder, output_folder)

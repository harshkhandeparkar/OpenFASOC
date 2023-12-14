# Import the NMOS generator
from glayout.primitives.fet import nmos
# Import the Sky130 MappedPDK
from glayout.pdk.sky130_mapped import sky130_mapped_pdk

# Generate the component
component = nmos(sky130_mapped_pdk)

# Save the component in a .gds file
component.write_gds('example.gds')
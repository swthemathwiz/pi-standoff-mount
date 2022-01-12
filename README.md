# pi-standoff-mount

## Introduction

This is a 3D-printable [OpenSCAD](https://openscad.org/) wall mount with stand
offs for the [Raspberry Pi](https://www.raspberrypi.org/) Standard (85.6 mm
× 56.5 mm) form factor (models 2B/3B/3B+/4B). It is a very simple alternative
to a full case that is simple and quick to print and install.

![Image of Mount with Pi](../media/media/mount-view.jpg?raw=true "Pi Standoff Mount with Pi")

## Model

The model has four stand-offs and two wall attachments. Many dimensions can be
modified and adjusted by using the OpenSCAD customizer.

[![View Model](../media/media/pi-standoff-mount.icon.png)](../media/media/pi-standoff-mount.stl "View Model of Pi Standoff Mount")

## Source

The wall mount is built using OpenSCAD. *pi-standoff-mount.scad* is the main
file for the wall mount.

### Raspberry Pi Models

Note that Raspberry Pi Models can be used to visualize and verify the relative
positions of ports and mounts on the stand-offs. These are optional and
available from third parties. There are two models:

1.  Raspberry Pi 3 Model B Reference Design from [Mechatronics Art on GrabCAD](https://grabcad.com/library/raspberry-pi-3-reference-design-model-b-rpi-raspberrypi-raspberry-pi-1)
    in file *Raspberry\_Pi\_3\_Light\_Version.STL*.

2.  Raspberry Pi 4 Model from [Coder-Tronics on Thingiverse](https://www.thingiverse.com/thing:3732868)
    in file *RPi4.STL*.

## Printing

I use a Creality Ender 3 Pro to build from PLA with a layer height of 0.20mm.
Since there are counter-bored screw holes, you may wish to flip this model
upside down in your slicer software before printing.

## Installation

You'll need four stand-offs with two matching screws on each end (eight in
total), along with two more screws to attach the entire mount to the wall.

1.  Screw the four stand offs into the base with small screws from the
    concealled recesses on the bottom of the mounts.
2.  Two larger screws go through the base into the wall.
3.  Screw the Raspberry Pi onto the stand-offs.

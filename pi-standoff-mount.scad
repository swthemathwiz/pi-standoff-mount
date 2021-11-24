//
// Copyright (c) Stewart H. Whitman, 2020-2021.
//
// File:    pi-standoff-mount.scad
// Project: Raspberry PI Mount
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    Stand-off only Raspberry Pi Mount
//

include <smidge.scad>;
include <rounded.scad>;

/* [General] */
// Show mount, mount with Pi 3, mount with Pi 4
show_selection = "mount"; // [ "mount", "mount/pi3", "mount/pi4" ]

/* [PI] */
// Reverse the orientation of the pi
pi_reverse = false;

// Size of a Pi board (should not change)
pi_size = [ 85, 56 ];

// Indent of Pi board holes from corners/sides (should not change)
pi_holes_offset = [ 3.5, 3.5 ];

// Mounting offsets of Pi board (should not change)
pi_holes_xy = [ pi_holes_offset, pi_holes_offset + [0,49], pi_holes_offset + [ 58, 0 ], pi_holes_offset + [ 58, 49 ] ];

// Mounting offsets of Pi board (should not change)
pi_holes_y  = [ pi_holes_offset.y, pi_holes_offset.y+49 ];

// Diameter of holes under pi
pi_hole_dia = 2.7;

/* [Mount] */
// Offset of pi from sides of mount
mount_pi_offset = [3,3];

// Thickness of mount
mount_thickness = 4.5;

// Corner radius of mount (primarily decorative, 3 matches Pi)
mount_corner_radius = 3;

// Extra amount about Pi size to add onto Mount
mount_handle_size = [ 15, 0 ];

// Diameter of the two large holes for mounting the mount
mount_hole_dia = 4;

// Hole adjustment
mount_hole_adjustment = [ -2, +2 ];

// Base volume
mount_base_size = concat( 2*mount_pi_offset + pi_size + mount_handle_size, mount_thickness );

// Amount to cutout of base interior below pi
mount_cutout_inset = 6;
mount_cutout = [mount_cutout_inset+2,mount_cutout_inset+2];
mount_cutout_size = concat( pi_size-[1*mount_cutout.x,2*mount_cutout.y], mount_thickness );

// Depth of hidden recess for standoff screws in mount
mount_hidden_inset_depth = 3;

// Diameter of hidden recess for standoff screws in mount
mount_hidden_inset_dia = 6;

function pi_reverse_xy(v) = [pi_reverse ? pi_size.x-v.x : v.x, v.y ];

// Models:
module pi4() {
  translate( [53,49,-14] )
    import( file = "RPi4.STL" );
} // end pi4

module pi3() {
  translate( [-3,-2, -2] ) // offset for connectors/sdcard
    import( file = "Raspberry_Pi_3_Light_Version.STL" );
} // end pi3

module pi_rotate() {
  if( pi_reverse )
    translate( concat( +pi_size/2, 0 ) ) rotate( 180 ) translate( concat( -pi_size/2, 0 ) ) children();
  else
    children();
} // end pi_rotate

module pi(transparency=0.5) {
  height = 8;

  translate( [0,mount_handle_size.y/2, 0 ] + concat( mount_pi_offset, mount_thickness ) ) {
    color("red", transparency )
      translate( [0,0,height] )
	pi_rotate() {
	  if( show_selection == "mount/pi4" )
	    pi4();
	  else
	    pi3();
	}

    color("gold", transparency )
      for( p = pi_holes_xy )
	difference() {
	  translate( concat( pi_reverse_xy(p), 0 ) ) cylinder( d=6, h=height, $fn=6 );
	  hole( concat( pi_reverse_xy(p), height ), pi_hole_dia );
        }
  }
} // end pi

module hole(pos,dia) {
  p = len(pos) < 3 ? concat( pos, 100 ) : pos;
  translate( [p.x,p.y,-SMIDGE] ) cylinder( d=dia, h=p.z+2*SMIDGE);
} // end hole

module base() {
  difference() {
    rounded_side_cube( mount_base_size, radius=mount_corner_radius );
    translate( [0,mount_handle_size.y/2, 0 ] )
      translate( concat(mount_pi_offset + mount_cutout, -SMIDGE) )
        rounded_side_cube( mount_cutout_size + [0,0,2*SMIDGE], radius=mount_corner_radius );
  }
} // end base

module mount() {
  difference() {
    base();
    translate( [0,mount_handle_size.y/2, 0 ] ) {
      translate( concat( mount_pi_offset, 0 ) ) {
	for( p = pi_holes_xy ) {
	  hole( concat( pi_reverse_xy(p), mount_thickness ), pi_hole_dia );
	  if( mount_hidden_inset_depth > 0 )
	    hole( concat( pi_reverse_xy(p), mount_hidden_inset_depth ), mount_hidden_inset_dia );
	}
      }
      for( y = pi_holes_y )
	translate( [mount_hole_adjustment.x, y < mount_base_size.y/2 ? mount_hole_adjustment.y : -mount_hole_adjustment.y, 0] )
	  hole( concat( [mount_base_size.x-pi_holes_offset.x-mount_pi_offset.x, mount_pi_offset.y+y], mount_base_size.z ), mount_hole_dia );
    }
  }
} // end mount

$fn = 36;

if( show_selection != "mount" )
  pi();
mount();

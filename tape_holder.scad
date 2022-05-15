$fn = 300;

disc_d = 178;
disc_t = 2;

reel_d = 57;
reel_t = disc_t + 4.5;

spindle_d = 7.5 + 0.75;
spoke_d = 1.4 + 0.75;
spoke_l = 7;


// cutout
cutout_d = 139;
cutout_ang = 10; // degrees
cutout_off = 185;

// misc
hole_d = 9;
hole_pr = 17;
pinch_gap = 1+0.25;

difference() {

union(){
    // disc
    linear_extrude(disc_t){
        difference(){
            circle(d=disc_d);
            circle(d=cutout_d);
        }
        
        for(i=[0:2]) rotate(120*i,[0,0,1]){
            a = cutout_off;//+reel_d/2;
            b = cutout_off+cutout_d/2+1;
            c = tan(cutout_ang/2);
            d = [[a,a*c],[a,-a*c],[b,-b*c],[b,b*c]];
            translate([-cutout_off,0,0])
            polygon(d);
        }
    }

    // reel
    linear_extrude(reel_t)
    circle(d=reel_d);
}

translate([0,0,-1])
linear_extrude(reel_t+2)
union(){
    circle(d=spindle_d);
    
    for(i=[0:2]) rotate(120*i,[0,0,1]){
        translate([spoke_l,0,0])
        circle(d=spoke_d);
        
        translate([0,-spoke_d/2,0])
        square([spoke_l,spoke_d]);
        
        rotate(60,[0,0,1])
        translate([hole_pr,0,0])
        circle(d=hole_d);
        
        rotate(60,[0,0,1])
        translate([reel_d/2-hole_d,-pinch_gap/2])
        square([hole_d,pinch_gap]);    
    }
}

}

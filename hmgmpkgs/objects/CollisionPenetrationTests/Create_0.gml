s1 = instance_create_layer(room_width / 2, room_height / 2,"Instances",ShapeObject);
s1.shape = circle_create(s1.id,0,0,32);

s2 = instance_create_layer(0, 0,"Instances",ShapeObject);
s2.shape = circle_create(s2.id,0,0,32);

col_depth = new Vec2(0,0);
col_pt = new Vec2(0,0);

function update(dt) {
	s2.x = mouse_x;
	s2.y = mouse_y;
	
	
	if (collide_circles(s1.shape,s2.shape)) {
		col_depth = penetration_vector_circles(s1.shape,s2.shape);
		
		var a = s1.shape;
		var b = s2.shape;
		var diff = a.get_global_position().subtract(b.get_global_position());
		var dir = diff.normalized();
		var len = a.radius;
		col_pt = dir.multiply(len);
		col_pt = new Vec2(s1.x,s1.y).subtract(col_pt);
		
	} else {
		col_depth.x = 0;
		col_depth.y = 0;
	}
	
}

function draw() {
	debug_draw_circle(s1.shape);
	debug_draw_circle(s2.shape);
	
	if (collide_circles(s1.shape,s2.shape)) {
		draw_circle_color(col_pt.x,col_pt.y,4,c_red,c_red,false);
		var x2 = col_pt.x + col_depth.x;
		var y2 = col_pt.y + col_depth.y;
		draw_line_color(col_pt.x,col_pt.y,x2,y2,c_red,c_red);
	}
}
/*
* 
* Copyright (c) 2008-2010 Lu Aye Oo
* 
* @author 		Lu Aye Oo
* 
* http://code.google.com/p/flash-console/
* 
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
* 
*/
package com.junkbyte.console.utils {
	import flash.utils.getQualifiedClassName;
	import flash.display.Graphics;	
	import flash.geom.Point;	
	
	public class Utils {
		
		public static function round(n:Number, d:uint):Number{
			return Math.round(n*d)/d;
		}
		public static function angle(srcP:Point, point:Point):Number {
			var a:Number = Math.atan2(point.y - srcP.y , point.x - srcP.x)/Math.PI * 180;
			a +=90;
			if(a>180) a -= 360;
			return a;
		}
		public static function drawCircleSegment(g:Graphics,radius:Number,pos:Point, deg:Number = 180, startDeg:Number = 0):Point
		{
			var reversed:Boolean = false;
			if(deg<0){
				reversed = true;
				deg = Math.abs(deg);
			}
			var rad:Number = (deg*Math.PI)/180;
			var rad2:Number = (startDeg*Math.PI)/180;
			var p:Point = getPointOnCircle(radius, rad2);
			p.offset(pos.x,pos.y);
			g.moveTo(p.x,p.y);
			var pra:Number = 0;
			for (var i:int = 1; i<=(rad+1); i++) {
				var ra:Number = i<=rad?i:rad;
				var diffr:Number = ra-pra;
				var offr:Number = 1+(0.12*diffr*diffr);
				var ap:Point = getPointOnCircle(radius*offr, ((ra-(diffr/2))*(reversed?-1:1))+rad2);
				ap.offset(pos.x,pos.y);
				p = getPointOnCircle(radius, (ra*(reversed?-1:1))+rad2);
				p.offset(pos.x,pos.y);
				g.curveTo(ap.x,ap.y, p.x,p.y);
				pra = ra;
			}
			return p;
		}
		public static function getPointOnCircle(radius:Number, rad:Number):Point {
			return new Point(radius * Math.cos(rad),radius * Math.sin(rad));
		}
		//
		public static function averageOut(current:Number, addition:Number, over:Number):Number {
			// this does not output an absolute average - you would need a history of values for this
			// This way is more light weight but not as accurate.
			return current+((addition-current)/over);
		}
		public static function shortClassName(cls:Object):String{
			var str:String = getQualifiedClassName(cls);
			var ind:int = str.lastIndexOf("::");
			return str.substring(ind>=0?(ind+2):0);
		}
		public static function HaveItemsInObject(o:Object):Boolean{
			for (var X:Object in o) return true;
			return false;
		}
	}
}
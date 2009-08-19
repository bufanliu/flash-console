﻿package com.atticmedia.console.panels {
	import flash.system.System;	
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.events.TextEvent;

	/**
	 * @author LuAye
	 */
	public class MemoryPanel extends GraphingPanel {
		
		//
		public function MemoryPanel() {
			name = "MemoryPanel";
			super(80,40);
			updateEvery = 5;
			drawEvery = 5;
			minimumWidth = 32;
			add(this, "current", 0x5060FF, "Memory");
		}
		public function get current():Number{
			return Math.round(System.totalMemory/1048.576)/1000;
		}
		protected override function onFrame(e:Event):void{
			super.onFrame(e);
			updateKeyText();
		}
		protected override function updateKeyText():void{
			keyTxt.htmlText = getCurrentOf(0)+"mb <font color='#C04444'><a href=\"event:gc\">G</a> <a href=\"event:reset\">R</a> <a href=\"event:close\">X</a></font>";
		}
		protected override function linkHandler(e:TextEvent):void{
			if(e.text == "gc"){
				// TODO: Should notify main Console if Garbage Collection is possible or not.
				if(System["gc"] != null){
					System["gc"]();
				}
			}
			super.linkHandler(e);
		}
	}
}

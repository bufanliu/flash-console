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
package com.junkbyte.console.addons.displaymap
{
    import com.junkbyte.console.Cc;
    import com.junkbyte.console.Console;
    import com.junkbyte.console.view.ConsolePanel;

    import flash.display.DisplayObject;

    public class DisplayMapAddon
    {

        public static function start(targetDisplay:DisplayObject, console:Console = null):void
        {
            if (console == null)
            {
                console = Cc.instance;
            }
            if (console == null)
            {
                return;
            }
            var mapPanel:DisplayMapPanel = new DisplayMapPanel(console);
            mapPanel.start(targetDisplay);
            console.panels.addPanel(mapPanel);
        }

        public static function registerCommand(commandName:String = "mapdisplay", console:Console = null):void
        {
            if (console == null)
            {
                console = Cc.instance;
            }
            if (console == null || commandName == null)
            {
                return;
            }

            var callbackFunction:Function = function(... arguments:Array):void
            {
                var scope:* = console.cl.run("this");
                if (scope is DisplayObject)
                {
                    start(scope as DisplayObject, console);
                }
                else
                {
                    console.error("Current scope", scope, "is not a DisplayObject.");
                }
            }
            console.addSlashCommand(commandName, callbackFunction);
        }

        public static function addToMenu(menuName:String = "DM", console:Console = null):void
        {
            if (console == null)
            {
                console = Cc.instance;
            }
            if (console == null || menuName == null)
            {
                return;
            }

            var callbackFunction:Function = function():void
            {
                start(console.parent);
            }
            console.addMenu(menuName, callbackFunction);
        }
    }
}

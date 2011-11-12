/*
*
* Copyright (c) 2008-2011 Lu Aye Oo
*
* @author 		Lu Aye Oo
*
* http://code.google.com/p/flash-console/
* http://junkbyte.com
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
package com.junkbyte.console.logging {
	import com.junkbyte.console.interfaces.IConsoleLogProcessor;
	import com.junkbyte.console.utils.EscHTML;
	
	
	public class LogEntry{
		
		public var inputs:Array;
		
		public var channel:String;
		public var priority:int;
		//
		//
		public function LogEntry(inputs:Array, cc:String, pp:int){
			this.inputs = inputs;
			channel = cc;
			priority = pp;
		}
		
		public function outputUsingProcessor(processor:IConsoleLogProcessor):String
		{
			var output:Vector.<String> = new Vector.<String>(inputs.length);
			
			var len:uint = inputs.length;
			for (var j:uint = 0; j < len; j++)
			{
				var input:* = inputs[j];
				output[j] = postProcess(input, processor.process(input, preProcess(input)));
			}
			
			return output.join(" ");
		}
		
		protected function preProcess(input:*):String
		{
			return EscHTML(String(input));
		}
		
		protected function postProcess(input:*, currentOutput:String):String
		{
			return currentOutput;
		}
	}
}
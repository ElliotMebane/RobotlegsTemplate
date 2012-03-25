/**
 * Copyright (C) 2005-2011 by Rivello Multimedia Consulting (RMC).                    
 * code [at] RivelloMultimediaConsulting [dot] com                                                  
 *                                                                      
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the      
 * "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish,  
 * distribute, sublicense, and#or sell copies of the Software, and to   
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:                                            
 *                                                                      
 * The above copyright notice and this permission notice shall be       
 * included in all copies or substantial portions of the Software.      
 *                                                                      
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR    
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.                                      
 */
//Marks the right margin of code *******************************************************************
package com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;
	
	/**
	 * <p>Event: Connect/Disconnect from the server</p>
	 * 
	 */
	public class MultiplayerServerEvent extends Event
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//	GETTER/SETTER
		/**
		 *  
		 */		
		private var _server_str : String;
		public function get server () 					: String 	{ return _server_str; }
		public function set server (aValue : String) 	: void 		{ _server_str = aValue; }
		
		/**
		 *  
		 */		
		private var _port_uint : uint;
		public function get port () 					: uint 	{ return _port_uint; }
		public function set port (aValue : uint) 	: void 		{ _port_uint = aValue; }
		
		//	PUBLIC
		/**
		 * EventType Name
		 * 
		 */	
		public static const CONNECT : String = "connect";
		
		/**
		 * EventType Name
		 * 
		 */	
		public static const DISCONNECT : String = "disconnect";
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MultiplayerServerEvent (aType_str : String, aServer_str : String = "", aPort_uint : uint = NaN)
		{
			super (aType_str);
			_server_str = aServer_str;
			_port_uint	= aPort_uint;
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Clone the event
		 * 
		 * @return Event
		 *
		 */
		override public function clone () : Event
		{
			return new MultiplayerServerEvent (type, server, port);
		}
		
		
	}
}
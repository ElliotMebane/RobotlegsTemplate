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
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	
	import flash.events.Event;
	
	/**
	 * <p>Event: Send/Receive Messages</p>
	 * 
	 */
	public class MultiplayerMessageEvent extends Event
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//	GETTER/SETTER
		/**
		 *  
		 */		
		private var _messageVO : MessageVO;
		public function get messageVO () 					: MessageVO 	{ return _messageVO; }
		public function set messageVO (aValue : MessageVO) 	: void 		{ _messageVO = aValue; }
		
		//	PUBLIC
		/**
		 * EventType Name
		 * 
		 */	
		public static const SEND : String = "send";
		
		/**
		 * EventType Name
		 * 
		 */	
		public static const SENT : String = "sent";
		
		/**
		 * EventType Name
		 * 
		 */	
		public static const RECEIVED : String = "received";
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MultiplayerMessageEvent (aType_str : String, aMessageVO : MessageVO)
		{
			super (aType_str);
			_messageVO = aMessageVO
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
			return new MultiplayerMessageEvent (type, messageVO);
		}
		
		
	}
}
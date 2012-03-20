package com.rmc.projects.robotlegstemplate.model.events
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;
	
	/**
	 * <p>CLASS   : Event: Changes to the Message Model</p>
	 * 
	 * <p>DATE    : Apr 05, 2010</p>
	 * <p>AUTHOR  : Samuel Asher Rivello  info [at] RivelloMultimediaConsulting [dot] com</p>
	 * <p>COMPANY : Rivello Multimedia Consulting. Adobe Flash and Flex Services of  
	 *              Software Architecture, Consulting, Development, and Training</p>
	 * 
	 * @example Here is a code example.  
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
	 *
	 * <span class="hide">Any hidden comments go here.</span>
	 *
	 */
	public class MessageModelEvent extends Event
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the message being stored
		 * 
		 * @default null 
		 */		
		public function get message () 					: String 	{ 	return _message_str; 		}
		public function set message (aValue : String) 	: void 		{ 	_message_str = aValue; 		}
		private var _message_str : String;
		
		
		/**
		 * Event Name: After the MessageModel has been changed
		 * 
		 * @default null 
		 */	
		public static const MESSAGE_MODEL_CHANGED : String = 'MESSAGE_MODEL_CHANGED';
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function MessageModelEvent(aType_str : String, aMessage_str : String)
		{
			super (aType_str);
			_message_str = aMessage_str;
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Clone the event
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @return Event
		 *
		 */
		override public function clone () : Event
		{
			return new MessageModelEvent (type, _message_str);
		}
	
	}
}
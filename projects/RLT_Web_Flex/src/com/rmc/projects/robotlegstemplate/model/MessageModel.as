package com.rmc.projects.robotlegstemplate.model
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import org.robotlegs.mvcs.Actor;
	import com.rmc.projects.robotlegstemplate.model.events.MessageModelEvent;
	
	
	/**
	 * <p>CLASS   : Model managing data: Display message sample</p>
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
	public class MessageModel extends Actor
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * The message containing information.  In a real application this data would be more complex
		 * 
		 * @default null 
		 */
		public function get message () 					: String 	{ 	return _message_str; }
		public function set message (aValue : String) 	: void 		{ _message_str = aValue; dispatch (	new MessageModelEvent(MessageModelEvent.MESSAGE_MODEL_CHANGED, _message_str)	);		}
		private var _message_str : String; 
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function MessageModel()
		{
			_message_str = "";
		}

	
	}
}
package com.rmc.projects.robotlegstemplate.view.events
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;

	/**
	 * <p>CLASS   : Handles all the events of the system (high level events)</p>
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
	public class SystemEvent extends Event
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Event Name: Request Load
		 * 
		 * @default null 
		 */
		public static const LOAD_PHRASES_MODEL : String = 'LOAD_PHRASES_MODEL';
		
		/**
		 * Event Name: Request Load
		 * 
		 * @default null 
		 */
		public static const LOAD_MESSAGE_MODEL : String = 'LOAD_MESSAGE_MODEL';
		
		/**
		 * Event Name: Request Clear
		 * 
		 * @default null 
		 */
		public static const CLEAR_MESSAGE_MODEL : String = 'CLEAR_MESSAGE_MODEL';
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function SystemEvent(type:String)
		{
			super(type);
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
		override public function clone():Event
		{
			return new SystemEvent(type);
		}
	
	}
}
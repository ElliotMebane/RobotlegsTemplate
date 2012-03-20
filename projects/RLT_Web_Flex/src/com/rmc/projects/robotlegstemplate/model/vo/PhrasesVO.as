//Marks the right margin of code *******************************************************************
package com.rmc.projects.robotlegstemplate.model.vo
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : Holds the data: For UI display </p>
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
	public class PhrasesVO	
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		
		//PUBLIC
		/**
		 * Display Text: Title for application
		 * 
		 * @default null 
		 */		
		public var panelTitle_str : String;
		
		/**
		 * Display Text: Button label before interactivity.
		 * 
		 * @default null 
		 */		
		public var loadMessageButtonLabel_str : String;
		
		/**
		 * Display Text: Button tooltip  
		 * 
		 * @default null 
		 */		
		public var loadMessageButtonToolTip_str : String;
		
		/**
		 * Display Text: Button label before interactivity.
		 * 
		 * @default null 
		 */		
		public var clearMessageButtonLabel_str : String;
		
		/**
		 * Display Text: Button tooltip  
		 * 
		 * @default null 
		 */		
		public var clearMessageButtonToolTip_str : String;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function PhrasesVO ()
		{
			//SUPER
			super(); 

		}


		
	}
}

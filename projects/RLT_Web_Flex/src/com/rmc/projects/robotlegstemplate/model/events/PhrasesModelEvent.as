package com.rmc.projects.robotlegstemplate.model.events
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.vo.PhrasesVO;
	
	import flash.events.Event;
	
	/**
	 * <p>CLASS   : Event: For changes to the PhrasesModel</p>
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
	public class PhrasesModelEvent extends Event
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		/**
		 * Reference to the MessageModel
		 * 
		 * @default null 
		 */	
		public var phrasesModel : PhrasesModel;
		
		
		/**
		 * Reference to the MessageModel
		 * 
		 * @default null 
		 */	
		public static const PHRASES_MODEL_CHANGED : String = "PHRASES_MODEL_CHANGED"; //aka 'loaded' from external file or whatever...
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function PhrasesModelEvent (aType_str : String, aPhrasesModel : PhrasesModel)
		{
			super (aType_str);
			phrasesModel = aPhrasesModel;
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
			return new PhrasesModelEvent (type, phrasesModel);
		}

	
	}
}
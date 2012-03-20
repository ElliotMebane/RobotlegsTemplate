package com.rmc.projects.robotlegstemplate.model
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.events.MessageModelEvent;
	import com.rmc.projects.robotlegstemplate.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.model.vo.PhrasesVO;
	import com.rmc.projects.robotlegstemplate.view.events.SystemEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * <p>CLASS   : Manages all the data: All of the static display phrases of the application</p>
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
	public class PhrasesModel extends Actor
	{

		//--------------------------------------
		//  Properties
		//--------------------------------------	
		
		/**
		 * Language Code: English
		 * 
		 * @default null 
		 */
		public static var EN : String = "EN";
		
		/**
		 * Language Code: Spanish
		 * 
		 * @default null 
		 */
		public static var ES : String = "ES";
		
		/**
		 * The current language code to be displayed
		 * 
		 * @default null 
		 */
		public function get langCode () 					: String 	{ 	return _langCode_str; 		}
		public function set langCode (aValue : String) 		: void 		{ 	_langCode_str = aValue;     }
		private var _langCode_str : String; 
		
		/**
		 * An object packed with all the static display phrases of the application
		 * 
		 * @default null 
		 */	
		public function get phrasesVO () 					: PhrasesVO 	{ 	return _phrasesVO; 		}
		public function set phrasesVO (aValue : PhrasesVO) 	: void 			{ 	_phrasesVO = aValue; dispatch ( new PhrasesModelEvent (PhrasesModelEvent.PHRASES_MODEL_CHANGED, this) );}
		private var _phrasesVO : PhrasesVO; 
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function PhrasesModel ()
		{
			//	Do not create "_phrasesVO". The "PhrasesLoadService" will create that.
			
		}

	
	}
}
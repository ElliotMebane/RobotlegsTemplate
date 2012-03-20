package com.rmc.projects.robotlegstemplate.services
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.vo.PhrasesVO;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * <p>CLASS   : Handles the loading of all display text from XML</p>
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
	public class PhrasesLoadService extends Actor implements ILoadService
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the PhrasesModel
		 * 
		 * @default null 
		 */
		[Inject]
		public var phrasesModel:PhrasesModel;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function PhrasesLoadService()
		{
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Load data from XML
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @return void
		 *
		 */
		public function load () : void
		{
			//SETUP
			var xmlDoc:XML = new XML();
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest("./assets_runtime/xml/phrases.xml");
			
			//LISTEN
			urlLoader.addEventListener(Event.COMPLETE, 			_onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, 	onIOError);
			
			//LOAD
			urlLoader.load(urlRequest);
			
		}
		
		/**
		 * Handle Even: XML Load Success
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent
		 * 
		 * @return void
		 *
		 */	
		private function _onComplete (aEvent : Event) : void 
		{
			
			/*
			
				LOAD SERVICE: EXAMPLE OF 'EXTERNAL DATA' (XML, CALLING A SERVER, ETC...)
			
			
			*/
			var phrasesVO : PhrasesVO = new PhrasesVO ();
			
			//CONVERT FOREIGN DATA to app-specific usable data (bogus xml->string example here)
			var xmlDoc : XML = XML (aEvent.target.data);
			var node : XML;
			var value_str : String;
			
			//if the localized version doesn't exist, use the english one
			for each (node in xmlDoc.children()) {
				value_str = node.descendants(phrasesModel.langCode).toString();
				if (value_str.length < 1) {
					value_str = node.descendants(PhrasesModel.EN);
				}
				phrasesVO[node.@name] = value_str;
			}
			
			phrasesModel.phrasesVO = phrasesVO;
			
		};
		
		/**
		 * Handle Event: XML Load Failure
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent
		 * 
		 * @return void
		 *
		 */	
		public function onIOError (aEvent : IOErrorEvent) : void 
		{
			throw new IOError ("PhrasesLoadService()");
			
		};
	}
}
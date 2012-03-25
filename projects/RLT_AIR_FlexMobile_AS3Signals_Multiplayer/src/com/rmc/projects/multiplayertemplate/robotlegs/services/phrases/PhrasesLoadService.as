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
package com.rmc.projects.multiplayertemplate.robotlegs.services.phrases
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.model.phrases.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.phrases.PhrasesVO;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.ILoadService;
	
	
	/**
	 * <p>Handles the loading of all display text from XML</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello (code [at] RivelloMultimediaConsulting [dot] com)</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * <p>CREATION DATE 	: Apr 05, 2010</p>
	 * 
	 * @example Here is a code example.  
	 * 
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
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
		 */
		[Inject]
		public var phrasesModel:PhrasesModel;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function PhrasesLoadService()
		{
			
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Load data from XML
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
		 * Handles the aEvent: <code>Event.COMPLETE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
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
		 * Handles the aEvent: <code>IOErrorEvent.IO_ERROR</code>.
		 * 
		 * @param aEvent <code>IOErrorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		public function onIOError (aEvent : IOErrorEvent) : void 
		{
			throw new IOError ("PhrasesLoadService() " + aEvent);
			
		};
	}
}
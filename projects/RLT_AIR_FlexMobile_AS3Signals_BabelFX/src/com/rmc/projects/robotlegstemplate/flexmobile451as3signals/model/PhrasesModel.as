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
package com.rmc.projects.robotlegstemplate.flexmobile451as3signals.model
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.controller.LoadMessageCommand;
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.controller.signals.ChangedMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.controller.signals.ChangedPhrasesModelSignal;
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.controller.signals.LoadMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.flexmobile451as3signals.model.vo.PhrasesVO;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * <p>Manages all the data: All of the static display phrases of the application</p>
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
	public class PhrasesModel extends Actor
	{

		//--------------------------------------
		//  Properties
		//--------------------------------------	
		
		/**
		 * Language Code: English
		 * 
		 */
		public static var EN : String = "EN";
		
		/**
		 * Language Code: Spanish
		 * 
		 */
		public static var ES : String = "ES";
		
		/**
		 * The current language code to be displayed
		 * 
		 */
		public function get langCode () 					: String 	{ 	return _langCode_str; 		}
		public function set langCode (aValue : String) 		: void 		{ 	_langCode_str = aValue;     }
		private var _langCode_str : String; 
		
		/**
		 * An object packed with all the static display phrases of the application
		 * 
		 */	
		public function get phrasesVO () 					: PhrasesVO 	{ 	return _phrasesVO; 		}
		public function set phrasesVO (aValue : PhrasesVO) 	: void 			{ 	
			_phrasesVO = aValue; 
			//EXAMPLE: Dispatching a signal with an Event payload
			changedPhrasesModelSignal.dispatch (new PhrasesModelEvent (PhrasesModelEvent.PHRASES_MODEL_CHANGED, this));
		}
		private var _phrasesVO : PhrasesVO; 
		
		
		//PUBLIC
		/**
		 * Signal: Marks a change to the <code>PhrasesModel</code>
		 * 
		 */	
		public var changedPhrasesModelSignal : ChangedPhrasesModelSignal;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function PhrasesModel ()
		{
			//SIGNALS
			changedPhrasesModelSignal = new ChangedPhrasesModelSignal ();
			
			//PROPERTIES
			//	Do not create "_phrasesVO". The "PhrasesLoadService" will create that.
			
		}

	
	}
}
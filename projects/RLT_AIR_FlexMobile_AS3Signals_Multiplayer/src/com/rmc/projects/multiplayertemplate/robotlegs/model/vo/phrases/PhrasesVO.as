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
package com.rmc.projects.multiplayertemplate.robotlegs.model.vo.phrases
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
	 * <p>Holds the data: For UI display </p>
	 * 
	 */
	[Bindable]
	public class PhrasesVO	
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		
		//PUBLIC
		/**
		 * Display Text:
		 * 
		 */		
		public var applicationTitle_str : String;
		public var lobbyViewTitle_str : String;
		public var gameViewTitle_str : String;
		public var goToLobbyButtonLabel_str : String;
		public var goToGameButtonLabel_str : String;

			
		
		//
		public var scoreboardLabel_str : String;
		public var gameLabel_str : String;
		public var instructionsLabelText_str : String;
		public var instructionsBodyText_str : String;
		public var statusLabelText_str : String;
		public var connectButtonLabel_str : String;
		public var disconnectButtonLabel_str : String;
		public var exitApplicationButtonLabel_str : String;
		//
		public var serverLabelText_str : String;
		public var roomAttributesLabelText_str : String;
		public var roomLabelText_str : String;
		public var joinRoomButtonLabel_str : String;
		public var leaveRoomButtonLabel_str : String;
		//
		public var messageLabelText_str : String;
		public var messageButtonLabel_str : String;
		public var usersLabelText_str : String;
		public var outputLabelText_str : String;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function PhrasesVO ()
		{
			//SUPER
			super(); 

		}
		
	}
}

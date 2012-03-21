/**
 * Copyright (C) 2005-2012 by Rivello Multimedia Consulting (RMC).                    
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
package com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer
{

	//--------------------------------------
	//  Imports
	//--------------------------------------
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>The <code>IChatService</code> is designed to...</p>
	 * 
	 */
	public interface IMultiplayerService
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		//function get sample() 						 :  String;
		//function set sample(aValue  :  String) 		 :  void;
		
		
		//--------------------------------------
		//  Methods
		//--------------------------------------				
		function connect(aServer_str:String, aPort_int:uint):void;
		function disconnect():void;
		//function sendMessage(aArgument_chatmessage:ChatMessageVO):void;
		//function setUserName(aArgument_str:String):void;
		
	}
}

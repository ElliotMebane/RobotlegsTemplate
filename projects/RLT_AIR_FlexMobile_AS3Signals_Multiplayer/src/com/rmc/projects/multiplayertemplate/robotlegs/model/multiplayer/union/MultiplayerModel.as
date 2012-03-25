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
package com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	
	import net.user1.reactor.Reactor;
	import net.user1.reactor.Room;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * <p>Model managing data: Display message sample</p>
	 *
	 */
	public class MultiplayerModel extends Actor
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		//PUBLIC SETTER/GETTER
		/**
		 *  API: The Core API Itself
		 */		
		private var _API : Reactor;
		public function get API () 					: Reactor 	{ return _API; }
		
		
		/**
		 *  API: The Core API Itself
		 */		
		private var _currentRoom : Room;
		public function get currentRoom () 					: Room 	{ return _currentRoom; }
		public function set currentRoom (aValue : Room) 	: void 		{ _currentRoom = aValue; }
		
		/**
		 *  
		 */		
		private var _me : UserVO;
		public function get me () 					: UserVO 	{ return _me; }
		public function set me (aValue : UserVO) 	: void 		{ _me = aValue; }
		
		/**
		 *  
		 */		
		private var _users_vector_uservo : Vector.<UserVO>;
		public function get users () 							: Vector.<UserVO> 	{ return _users_vector_uservo; }
		public function set users (aValue : Vector.<UserVO>) 	: void 				{ _users_vector_uservo = aValue; }
		
		//PUBLIC
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MultiplayerModel()
		{
			//SIGNALS
			
			//PROPERTIES
			_API = new Reactor();
		}

	
	}
}
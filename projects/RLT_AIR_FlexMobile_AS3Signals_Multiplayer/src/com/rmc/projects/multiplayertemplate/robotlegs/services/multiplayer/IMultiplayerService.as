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
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageReceivedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomAttributeUpdatedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomJoinedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomLeftSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantAddedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantCountChangedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantRemovedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerConnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerDisconnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	
	import net.user1.reactor.Room;

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
		
		//	SIGNALS
		function get multiplayerModel() 							:  MultiplayerModel
		function get multiplayerConnectedSignal() 					:  MultiplayerConnectedSignal;
		function get multiplayerDisconnectedSignal() 				:  MultiplayerDisconnectedSignal;
		function get multiplayerRoomJoinedSignal() 					:  MultiplayerRoomJoinedSignal;
		function get multiplayerRoomLeftSignal() 					:  MultiplayerRoomLeftSignal;
		function get multiplayerMessageReceivedSignal() 			:  MultiplayerMessageReceivedSignal;
		function get multiplayerRoomOccupantCountChangedSignal() 	:  MultiplayerRoomOccupantCountChangedSignal;
		function get multiplayerRoomOccupantAddedSignal() 			:  MultiplayerRoomOccupantAddedSignal;
		function get multiplayerRoomOccupantRemovedSignal() 		:  MultiplayerRoomOccupantRemovedSignal;
		function get multiplayerRoomAttributeUpdatedSignal() 		:  MultiplayerRoomAttributeUpdatedSignal;

		
		//--------------------------------------
		//  Methods
		//--------------------------------------				
		function connect(aServer_str:String, aPort_int:uint):void;
		function disconnect():void;
		function sendMessage(aChatMessageVO : MessageVO):void
		function createRoomAndJoinRoom(aRoomName_str : String, aUserName_str : String): void;
		function leaveCurrentRoom():void;
				
	}
}

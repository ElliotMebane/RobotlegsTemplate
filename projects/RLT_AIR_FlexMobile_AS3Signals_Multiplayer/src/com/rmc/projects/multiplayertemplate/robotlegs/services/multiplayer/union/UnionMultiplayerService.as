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
// Marks the right margin of code *******************************************************************
package com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.union
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageReceivedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomJoinedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantCountChangedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerConnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerDisconnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerMessageEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	
	import net.user1.reactor.Client;
	import net.user1.reactor.IClient;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This <code>MultiplayerService</code> is designed to...</p>
	 * 
	 */
	public class UnionMultiplayerService extends Actor implements IMultiplayerService
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerConnectedSignal : MultiplayerConnectedSignal;
		public function get multiplayerConnectedSignal () :MultiplayerConnectedSignal { return _multiplayerConnectedSignal; }
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerDisconnectedSignal : MultiplayerDisconnectedSignal;
		public function get multiplayerDisconnectedSignal () :MultiplayerDisconnectedSignal { return _multiplayerDisconnectedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerRoomJoinedSignal : MultiplayerRoomJoinedSignal;
		public function get multiplayerRoomJoinedSignal () :MultiplayerRoomJoinedSignal { return _multiplayerRoomJoinedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerRoomOccupantCountChangedSignal : MultiplayerRoomOccupantCountChangedSignal;
		public function get multiplayerRoomOccupantCountChangedSignal () :MultiplayerRoomOccupantCountChangedSignal { return _multiplayerRoomOccupantCountChangedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerChatMessageRecievedSignal : MultiplayerMessageReceivedSignal;
		public function get multiplayerMessageReceivedSignal () :MultiplayerMessageReceivedSignal { return _multiplayerChatMessageRecievedSignal; }
		
		//PUBLIC
		/**
		 * Service: 
		 * 
		 */	
		[Inject]
		public var _multiplayerModel : MultiplayerModel;
		public function get multiplayerModel () :MultiplayerModel { return _multiplayerModel; }
		
		
		// PUBLIC CONST
		
		// PRIVATE
		/**
		 * Describe this member.
		 * 
		 */
		private var _lastRequestedUserName_str:String;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function UnionMultiplayerService()
		{
			// SUPER
			super();
			
			// VARIABLES
			
			// PROPERTIES
			_multiplayerConnectedSignal 				= new MultiplayerConnectedSignal ();
			_multiplayerDisconnectedSignal 				= new MultiplayerDisconnectedSignal ();
			_multiplayerRoomJoinedSignal				= new MultiplayerRoomJoinedSignal ();
			_multiplayerChatMessageRecievedSignal		= new MultiplayerMessageReceivedSignal ();
			_multiplayerRoomOccupantCountChangedSignal	= new MultiplayerRoomOccupantCountChangedSignal ();
			
			// EVENTS
			
			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * Robotlegs Requirement: Handles Event of Registration
		 * 
		 * @return void
		 *
		 */
		[PostConstruct]
		public function init():void
		{
			
			// VARIABLES
			
			// PROPERTIES
			
			// EVENTS
			multiplayerModel.API.addEventListener( ReactorEvent.READY, _onReady );
			multiplayerModel.API.addEventListener( ReactorEvent.CLOSE, _onClose );
			
			
			// METHODS
		}
		
		
		/**
		 * Connect to the Multiplayer server
		 * 
		 * @param aServer_str
		 * @param aPort_uint
		 * 
		 * @return void
		 * 
		 */		
		public function connect(aServer_str:String, aPort_uint:uint):void
		{
			multiplayerModel.API.connect(aServer_str, aPort_uint);
		}
		
		/**
		 * Disconnect to the Multiplayer server
		 * 
		 * @return void
		 * 
		 */	
		public function disconnect():void
		{
			//multiplayerModel.currentRoom.leave();
			multiplayerModel.API.disconnect();
		}

		
		/**
		 * 
		 * 
		 * @param aOccupants_array
		 * 
		 * @return 
		 * 
		 */
		public function _setMultiplayerModelDataForUsers(aOccupants_array : Array): void
		{ 
			//
			multiplayerModel.users = new Vector.<UserVO>();
			var user : UserVO;
			//
			for each(var client:Client in aOccupants_array)
			{
				user = new UserVO ();
				if (client.isSelf()) {
					//ONLY *SET* THE NAME FOR 'ME'
					client.setAttribute(UserVO.USER_NAME_ATTRIBUTE_NAME, _lastRequestedUserName_str);
					multiplayerModel.me = user;
				}
				
				//*GET* THE NAME FOR EACH
				user.name = client.getAttribute(UserVO.USER_NAME_ATTRIBUTE_NAME);
				user.isMe = client.isSelf();
				multiplayerModel.users.push (user);
				
			}
		}
		
		
		/**
		 * Create a room and handle eventListener setup
		 * 
		 * @param aRoomName_str : String
		 *  
		 * @return Room
		 * 
		 */
		public function createRoomAndJoinRoom(aRoomName_str : String, aLastRequestedUserName_str : String): Room
		{ 
			
			//STORE THE NAME WE WANT TO USE FOR OUR USERNAME. IT WILL BE USED INTERNALLY LATER.
			//NOTE: WE COULD ADD A SIGNAL/COMMAND/METHOD SETUP for 'setUserName' later if we want...
			_lastRequestedUserName_str = aLastRequestedUserName_str;
				
			
			//JOIN THE ROOM
			if (multiplayerModel.currentRoom == null) {
				multiplayerModel.currentRoom = multiplayerModel.API.getRoomManager().createRoom(aRoomName_str);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.JOIN, 					_onRoomJoined);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.OCCUPANT_COUNT, 		_onRoomOccupantCountChanged);
				multiplayerModel.currentRoom.addMessageListener(MessageVO.MESSAGE_TYPE, 		_onChatMessageReceived );
				multiplayerModel.currentRoom.join();
			} else {
				throw new Error ("We should not have a room yet. Did we remember to destroy the old one?");
			}
			return multiplayerModel.currentRoom;
			
		}
		
		/**
		 * Destroy a room and handle eventListener cleanup
		 * 
		 * @param aRoom : Room
		 *  
		 * @return void
		 * 
		 */
		public function leaveCurrentRoom():void
		{ 
			multiplayerModel.currentRoom.removeEventListener(RoomEvent.JOIN, _onRoomJoined);
			multiplayerModel.currentRoom.removeEventListener(MessageVO.MESSAGE_TYPE, _onChatMessageReceived );
			multiplayerModel.currentRoom.leave();	
		}
		
		
		
		
		/**
		 * Send a message of any type to the current room
		 *  
		 * @param aChatMessageVO : ChatMessageVO
		 * 
		 * @return void
		 * 
		 */
		public function sendMessage(aChatMessageVO : MessageVO):void
		{ 
			if (multiplayerModel.me) {
				aChatMessageVO.fromUsername = multiplayerModel.me.name;
			} else {
				aChatMessageVO.fromUsername = "{UnknownUser}";
			}
			multiplayerModel.currentRoom.sendMessage(MessageVO.MESSAGE_TYPE, true, null, aChatMessageVO.message);
		}
		
		
		
		// PRIVATE
		
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Event: <code>ReactorEvent.READY</code>.
		 * 
		 * @param aEvent <code>ReactorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onReady(aEvent:ReactorEvent):void
		{ 
			multiplayerConnectedSignal.dispatch();
			
		}

		
		/**
		 * Handles the Event: <code>ReactorEvent.CLOSE</code>.
		 * 
		 * @param aEvent <code>ReactorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onClose(aEvent:ReactorEvent):void
		{ 
			multiplayerDisconnectedSignal.dispatch();
			
		}
		
		/**
		 * Handles the Event: <code>RoomEvent.JOIN</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomJoin(aEvent:RoomEvent):void
		{
			multiplayerRoomJoinedSignal.dispatch();
		}
		
		
		/**
		 * Handles the Event: <code>RoomEvent.JOIN</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomJoined(aEvent : RoomEvent):void
		{ 
			//
			_setMultiplayerModelDataForUsers (multiplayerModel.currentRoom.getOccupants());
			//
			multiplayerRoomJoinedSignal.dispatch();
			
		}
		
		
		/**
		 * Handles the Event: <code>RoomEvent.OCCUPANT_COUNT</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomOccupantCountChanged(aEvent : RoomEvent):void
		{ 
			//
			_setMultiplayerModelDataForUsers (multiplayerModel.currentRoom.getOccupants());
			//
			_multiplayerRoomOccupantCountChangedSignal.dispatch();
			
		}
		
		/**
		 * Handles the Event: <code>RoomEvent.                </code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onChatMessageReceived(aFrom_iclient: IClient, aMessage_str : String):void
		{ 
			var chatMessageVO:MessageVO = new MessageVO(aMessage_str);
			chatMessageVO.fromUsername = aFrom_iclient.getAttribute(UserVO.USER_NAME_ATTRIBUTE_NAME);
			multiplayerMessageReceivedSignal.dispatch(new MultiplayerMessageEvent (MultiplayerMessageEvent.RECEIVED, chatMessageVO) );
			
		}
		
		
		
	}
}


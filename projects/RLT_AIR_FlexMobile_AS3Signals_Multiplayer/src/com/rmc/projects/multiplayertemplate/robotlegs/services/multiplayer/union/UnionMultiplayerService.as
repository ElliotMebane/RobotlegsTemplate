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
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomAttributeUpdatedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomClientAttributeUpdatedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomJoinedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomLeftSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantAddedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantCountChangedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomOccupantRemovedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerConnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerDisconnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerMessageEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	
	import net.user1.reactor.AttributeEvent;
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
		private var _multiplayerRoomLeftSignal : MultiplayerRoomLeftSignal;
		public function get multiplayerRoomLeftSignal () : MultiplayerRoomLeftSignal { return _multiplayerRoomLeftSignal; }
		
		
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
		private var _multiplayerRoomOccupantAddedSignal : MultiplayerRoomOccupantAddedSignal;
		public function get multiplayerRoomOccupantAddedSignal () :MultiplayerRoomOccupantAddedSignal { return _multiplayerRoomOccupantAddedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerRoomOccupantRemovedSignal : MultiplayerRoomOccupantRemovedSignal;
		public function get multiplayerRoomOccupantRemovedSignal () :MultiplayerRoomOccupantRemovedSignal { return _multiplayerRoomOccupantRemovedSignal; }
		
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerRoomAttributeUpdatedSignal : MultiplayerRoomAttributeUpdatedSignal;
		public function get multiplayerRoomAttributeUpdatedSignal () :MultiplayerRoomAttributeUpdatedSignal { return _multiplayerRoomAttributeUpdatedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerRoomClientAttributeUpdatedSignal : MultiplayerRoomClientAttributeUpdatedSignal;
		public function get multiplayerRoomClientAttributeUpdatedSignal () :MultiplayerRoomClientAttributeUpdatedSignal { return _multiplayerRoomClientAttributeUpdatedSignal; }
		
		
		/**
		 * Signal: 
		 * 
		 */
		private var _multiplayerMessageReceivedSignal : MultiplayerMessageReceivedSignal;
		public function get multiplayerMessageReceivedSignal () :MultiplayerMessageReceivedSignal { return _multiplayerMessageReceivedSignal; }
		
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
			_multiplayerConnectedSignal 					= new MultiplayerConnectedSignal ();
			_multiplayerDisconnectedSignal 					= new MultiplayerDisconnectedSignal ();
			_multiplayerRoomJoinedSignal					= new MultiplayerRoomJoinedSignal ();
			_multiplayerRoomLeftSignal						= new MultiplayerRoomLeftSignal ();
			_multiplayerMessageReceivedSignal				= new MultiplayerMessageReceivedSignal ();
			_multiplayerRoomOccupantCountChangedSignal		= new MultiplayerRoomOccupantCountChangedSignal ();
			_multiplayerRoomOccupantAddedSignal				= new MultiplayerRoomOccupantAddedSignal ();
			_multiplayerRoomOccupantRemovedSignal			= new MultiplayerRoomOccupantRemovedSignal ();
			_multiplayerRoomAttributeUpdatedSignal			= new MultiplayerRoomAttributeUpdatedSignal ();
			_multiplayerRoomClientAttributeUpdatedSignal 	= new MultiplayerRoomClientAttributeUpdatedSignal();
			
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
				user.userName = client.getAttribute(UserVO.USER_NAME_ATTRIBUTE_NAME);
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
		public function createRoomAndJoinRoom(aRoomName_str : String, aLastRequestedUserName_str : String): void
		{ 
			
			//STORE THE NAME WE WANT TO USE FOR OUR USERNAME. IT WILL BE USED INTERNALLY LATER.
			//NOTE: WE COULD ADD A SIGNAL/COMMAND/METHOD SETUP for 'setUserName' later if we want...
			_lastRequestedUserName_str = aLastRequestedUserName_str;
			
			
			//JOIN THE ROOM
			if (multiplayerModel.currentRoom == null) {
				multiplayerModel.currentRoom = multiplayerModel.API.getRoomManager().createRoom(aRoomName_str);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.JOIN, 						_onRoomJoined);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.LEAVE, 						_onRoomLeft);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.OCCUPANT_COUNT, 			_onRoomOccupantCountChanged);
				multiplayerModel.currentRoom.addEventListener(AttributeEvent.UPDATE, 				_onRoomAttributeUpdated);
				multiplayerModel.currentRoom.addEventListener(RoomEvent.UPDATE_CLIENT_ATTRIBUTE, 	_onRoomClientAttributeUpdated);
				//
				multiplayerModel.currentRoom.addMessageListener(MessageVO.MESSAGE_TYPE, 		_onMessageReceived );
				multiplayerModel.currentRoom.join();
			} else {
				throw new Error ("We should not have a room yet. Did we remember to destroy the old one?");
			}
			
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
			//PACK IN THE 'FROM'
			aChatMessageVO.fromUserName = multiplayerModel.me.userName;
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
			_multiplayerConnectedSignal.dispatch(aEvent);
			
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
			_multiplayerDisconnectedSignal.dispatch(aEvent);
			
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
			_multiplayerRoomJoinedSignal.dispatch(aEvent);
			
		}
		
		
		/**
		 * Handles the Event: <code>RoomEvent.LEAVE</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomLeft(aEvent : RoomEvent):void
		{ 
			var roomWeJustLeft : Room = (aEvent.target as Room);
			_multiplayerRoomLeftSignal.dispatch(aEvent);
			roomWeJustLeft.removeEventListener(RoomEvent.JOIN, 				_onRoomJoined);
			roomWeJustLeft.removeEventListener(RoomEvent.LEAVE, 			_onRoomLeft);
			//
			roomWeJustLeft.removeEventListener(RoomEvent.ADD_OCCUPANT, 		_onRoomOccupantAdded);
			roomWeJustLeft.removeEventListener(RoomEvent.REMOVE_OCCUPANT, 	_onRoomOccupantRemoved);
			roomWeJustLeft.removeEventListener(RoomEvent.OCCUPANT_COUNT, 	_onRoomOccupantCountChanged);
			//
			//
			roomWeJustLeft.removeEventListener(AttributeEvent.UPDATE, 		_onRoomAttributeUpdated);
			roomWeJustLeft.removeMessageListener(MessageVO.MESSAGE_TYPE, 	_onMessageReceived );
			//
			multiplayerModel.currentRoom = null;
			//
			multiplayerRoomLeftSignal.dispatch(aEvent);
			
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
			_multiplayerRoomOccupantCountChangedSignal.dispatch(aEvent);
			
		}
		
		/**
		 * Handles the Event: <code>RoomEvent.ADD_OCCUPANT</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomOccupantAdded(aEvent : RoomEvent):void
		{ 
			//
			_setMultiplayerModelDataForUsers (multiplayerModel.currentRoom.getOccupants());
			//
			_multiplayerRoomOccupantAddedSignal.dispatch(aEvent);
			
		}
		
		/**
		 * Handles the Event: <code>RoomEvent.REMOVE_OCCUPANT</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomOccupantRemoved(aEvent : RoomEvent):void
		{ 
			//
			_setMultiplayerModelDataForUsers (multiplayerModel.currentRoom.getOccupants());
			//
			_multiplayerRoomOccupantRemovedSignal.dispatch(aEvent);
			
		}
		
		/**
		 * Handles the Event: <code>AttributeEvent.UPDATE</code>.
		 * 
		 * @param aEvent <code>AttributeEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomAttributeUpdated(aEvent : AttributeEvent):void
		{ 
			//
			_multiplayerRoomAttributeUpdatedSignal.dispatch(aEvent);
			
		}
		
		/**
		 * Handles the Event: <code>RoomEvent.UPDATE_CLIENT_ATTRIBUTE</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onRoomClientAttributeUpdated(aEvent : RoomEvent):void
		{ 
			//
			_multiplayerRoomClientAttributeUpdatedSignal.dispatch(aEvent);
			
		}
		
		
		/**
		 * Handles the Event: <code>RoomEvent.                </code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onMessageReceived(aFrom_iclient: IClient, aMessage_str : String):void
		{ 
			var chatMessageVO:MessageVO = new MessageVO(aMessage_str);
			chatMessageVO.fromUserName = aFrom_iclient.getAttribute(UserVO.USER_NAME_ATTRIBUTE_NAME);
			_multiplayerMessageReceivedSignal.dispatch(new MultiplayerMessageEvent (MultiplayerMessageEvent.RECEIVED, chatMessageVO) );
			
		}
		
	}
}

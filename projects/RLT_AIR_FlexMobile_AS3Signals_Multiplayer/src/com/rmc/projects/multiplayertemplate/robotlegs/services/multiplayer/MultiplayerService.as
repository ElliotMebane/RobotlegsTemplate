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
package com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.MultiplayerConnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.MultiplayerDisconnectedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	
	import net.user1.reactor.IClient;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	/**
	 * Dispatched when ...
	 * 
	 * @aEventType com.rmc.templates.MultiplayerService.SAMPLE_LOADED
	 * 
	 */
	[Event( name="sampleLoaded", type="flash.events.Event" )]
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This <code>MultiplayerService</code> is designed to...</p>
	 * 
	 */
	public class MultiplayerService extends Actor implements IMultiplayerService
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		
		// PUBLIC CONST
		
		// PRIVATE
		/**
		 * Describe this member.
		 * 
		 */
		protected var _reactor:Reactor;
		
		/**
		 * Describe this member.
		 * 
		 */
		protected var _room:Room;
		
		/**
		 * Describe this member.
		 * 
		 */
		protected var _usernname_str:String;
		
		/**
		 * Signal: 
		 * 
		 */
		public var multiplayerConnectedSignal:MultiplayerConnectedSignal;
		
		/**
		 * Signal: 
		 * 
		 */
		public var multiplayerDisconnectedSignal:MultiplayerDisconnectedSignal;
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MultiplayerService()
		{
			// SUPER
			super();
			
			// VARIABLES
			
			// PROPERTIES
			_reactor = new Reactor();
			multiplayerConnectedSignal 		= new MultiplayerConnectedSignal ();
			multiplayerDisconnectedSignal 	= new MultiplayerDisconnectedSignal ();
			
			// EVENTS
			_reactor.addEventListener( ReactorEvent.READY, _onReady );
			
			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * Describe this member.
		 * 
		 * @param aSample_str Describe this parameter.
		 * 
		 * @return String Describe this return.
		 * 
		 */
		public function connect(aServer_str:String, aPort_uint:uint):void
		{
			_reactor.connect(aServer_str, aPort_uint);
		}
		
		/**
		 * Describe this member.
		 * 
		 * @param aSample_str Describe this parameter.
		 * 
		 * @return String Describe this return.
		 * 
		 */
		public function disconnect():void
		{
			_room.leave();
			//wait for _onLeave()? -- then do... multiplayerDisconnectedSignal.dispatch();
		}
		
		/**
		 * Describe this member.
		 * 
		 * @param aSample_str Describe this parameter.
		 * 
		 * @return String Describe this return.
		 * 
		 */
		public function setUserName(aUsername_str : String):void
		{
			var self:IClient;
			this._usernname_str = aUsername_str;
			self = _reactor.getClientManager().self();
			self.setAttribute("USERNAME", aUsername_str);
			//eventDispatcher.dispatchEvent(new ChatEvent(ChatEvent.CHAT_READY));
		}
		
		/**
		 * Describe this member.
		 * 
		 * @param aSample_str Describe this parameter.
		 * 
		 * @return String Describe this return.
		 * 
		 */
		//public function sendMessage(aChatMessageVO:ChatMessageVO):void
		//{
		//	_room.sendMessage( "CHAT_MESSAGE", true, null, aChatMessageVO.text );
	//	}
		
		
		// PRIVATE
		
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Event: <code>TemplateEvent.SAMPLE_LOADED</code>.
		 * 
		 * @param aEvent <code>TemplateEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onReady(event:ReactorEvent):void
		{
			multiplayerConnectedSignal.dispatch();
			
			
			//SO MOVE THIS CODE TO A COMMAND FOR 'multiplayerConnectedSignal'?
			var x : String = new Sprite ();
			_room = _reactor.getRoomManager().createRoom("robotlegs");
			_room.addEventListener( RoomEvent.JOIN_RESULT, _onJoinResult );
			_room.addEventListener( RoomEvent.ADD_CLIENT, _onAddClient );
			_room.addEventListener( RoomEvent.UPDATE_CLIENT_ATTRIBUTE, _onUpdateClientAttribute );
			_room.addMessageListener( "CHAT_MESSAGE", _onHandleChatMessage );
			_room.join();
		}
		
		/**
		 * Handles the Event: <code>TemplateEvent.SAMPLE_LOADED</code>.
		 * 
		 * @param aEvent <code>TemplateEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onJoinResult(event:RoomEvent):void
		{
			//eventDispatcher.dispatchEvent(new ChatEvent(ChatEvent.CHAT_CONNECTED));
		}
		
		/**
		 * Handles the Event: <code>TemplateEvent.SAMPLE_LOADED</code>.
		 * 
		 * @param aEvent <code>TemplateEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onHandleChatMessage(aFrom_iclient:IClient, aMessage_str:String):void
		{
			//var message:ChatMessageVO = new ChatMessageVO();
			//message.sender = aFrom_iclient.getAttribute("USERNAME");
			//message.text = aMessage_str;
			
			//eventDispatcher.dispatchEvent( new ChatEvent(ChatEvent.MESSAGE_RECEIVED, message));
		}
		
		/**
		 * Handles the Event: <code>TemplateEvent.SAMPLE_LOADED</code>.
		 * 
		 * @param aEvent <code>TemplateEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onAddClient(aEvent:RoomEvent):void
		{
			var clients:Array = _room.getClients();
		}
		
		/**
		 * Handles the Event: <code>TemplateEvent.SAMPLE_LOADED</code>.
		 * 
		 * @param aEvent <code>TemplateEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onUpdateClientAttribute(aEvent:RoomEvent):void
		{
			var users:ArrayCollection = new ArrayCollection()
			var clients:Array = _room.getClients();
			for each(var client:IClient in clients)
			{
				if(!client.getAttribute("USERNAME"))
					continue;
				//
				var user:UserVO = new UserVO()
				user.username = client.getAttribute("USERNAME");
				user.chat_id = client.getClientID();
				users.addItem(user);
			}
			
			//eventDispatcher.dispatchEvent(new ChatRoomMembersEvent(ChatRoomMembersEvent.MEMBERS_UPDATE_RECEIVED, users));
		}
		
	}
}


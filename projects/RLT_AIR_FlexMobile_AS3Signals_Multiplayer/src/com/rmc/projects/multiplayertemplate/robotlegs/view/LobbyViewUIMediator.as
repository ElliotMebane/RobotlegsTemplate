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
package com.rmc.projects.multiplayertemplate.robotlegs.view
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageReceivedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomJoinedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerServerSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.phrases.LoadPhrasesModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerMessageEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerRoomEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerServerEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.phraes.PhrasesModelEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.phrases.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.LobbyViewUI;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import net.user1.reactor.Reactor;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.supportClasses.StyleableTextField;
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>Mediator</code> managing the I/O to the UI: Lobby</p>
	 * 
	 */
	public class LobbyViewUIMediator extends Mediator
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC
		/**
		 * Reference to the UI being mediated
		 * 
		 */	
		[Inject]
		public var lobbyViewUI : LobbyViewUI;
		
		/**
		 * Signal: Marks a request to the <code>IMutliplayerService</code>
		 * 
		 */	
		[Inject]
		public var multiplayerServerSignal : MultiplayerServerSignal;
		
		
		/**
		 * Signal: Marks a request to the <code>IMutliplayerService</code>
		 * 
		 */	
		[Inject]
		public var multiplayerRoomSignal : MultiplayerRoomSignal;
		
		
		/**
		 * Signal: Marks a request to the <code>IMutliplayerService</code>
		 * 
		 */	
		[Inject]
		public var multiplayerMessageSignal:MultiplayerMessageSignal;
		
		
		/**
		 * Signal: Marks a request to load the <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var loadPhrasesModelSignal : LoadPhrasesModelSignal;
		
		/**
		 * Reference: <code>MultiplayerModel</code>
		 * 
		 */	
		[Inject]
		public var multiplayerModel : MultiplayerModel;
		
		/**
		 * Service: 
		 * 
		 */	
		[Inject (name="MultiplayerService")]
		public var iMultiplayerService : IMultiplayerService;
		
		
		/**
		 * Reference: <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var phrasesModel : PhrasesModel;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function LobbyViewUIMediator()
		{
			//NOTHING HAPPENS HERE
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Handles Event of Registration
		 * 
		 * @return void
		 *
		 */
		override public function onRegister():void
		{
			
			// 	View Listeners
			lobbyViewUI.connectMultiplayer_signal.add  		(_doMultiplayerConnect);
			lobbyViewUI.disconnectMultiplayer_signal.add  	(_doMultiplayerDisconnect);
			lobbyViewUI.sendMessage_signal.add  			(_onSendMessage);
			
			//	Context Listeners
			phrasesModel.changedPhrasesModelSignal.add 					(_onPhrasesModelChanged);
			iMultiplayerService.multiplayerConnectedSignal.add 			(_onMultiplayerConnected);
			iMultiplayerService.multiplayerDisconnectedSignal.add 		(_onMultiplayerDisconnected);
			iMultiplayerService.multiplayerRoomJoinedSignal.add 		(_onMultiplayerRoomJoined);
			iMultiplayerService.multiplayerMessageReceivedSignal.add 	(_onMultiplayerMessageReceived);
			iMultiplayerService.multiplayerRoomOccupantCountChangedSignal.add 	(_onMultiplayerRoomOccupantCountChanged);
			
			//	Presentation (Binding)
			lobbyViewUI.isConnected 	= false;
			lobbyViewUI.isJoined 		= false;
			lobbyViewUI.statusMessage 	= "Preparing";
			lobbyViewUI.serverURL_textinput.text 	= Configuration.SERVER_URL_DEFAULT;
			lobbyViewUI.serverPort_textinput.text 	= Configuration.SERVER_PORT_DEFAULT.toString();
			lobbyViewUI.roomName_textinput.text 	= Configuration.ROOM_NAME_DEFAULT;
			lobbyViewUI.userName_textinput.text 	= Configuration.USER_NAME_DEFAULT + Math.round(Math.random()*1000);
			
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			loadPhrasesModelSignal.dispatch ();
			_doMultiplayerConnect (null);
			
		}
		
		
		//VIEW
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doMultiplayerConnect (aEvent : MouseEvent):void
		{
			
			var serverURL_str : String = lobbyViewUI.serverURL_textinput.text;
			var serverPort_uint : uint = uint (lobbyViewUI.serverPort_textinput.text)
			multiplayerServerSignal.dispatch(
				new MultiplayerServerEvent (MultiplayerServerEvent.CONNECT, serverURL_str, serverPort_uint) 
			);
			
			//	Presentation
			lobbyViewUI.statusMessage 	= "Connecting...";
			
		}
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doMultiplayerDisconnect (aEvent : MouseEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 	= "Disconnecting...";
			
			//
			multiplayerServerSignal.dispatch(
				new MultiplayerServerEvent (MultiplayerServerEvent.DISCONNECT) 
			);
		}
		
		/**
		 * Send a Message
		 *  
		 * @param aMessageVO
		 * 
		 */
		private function _doSendMessage (aMessageVO : MessageVO):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 	= "Message Sent.";
			
			//
			multiplayerMessageSignal.dispatch( new MultiplayerMessageEvent (MultiplayerMessageEvent.SEND, aMessageVO) );
			
		}
		
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		
		
		private function _onSendMessage ():void
		{
			var messageVO : MessageVO = new MessageVO (lobbyViewUI.message_textinput.text);
			_doSendMessage (messageVO);
			
			//CLEAR TEXT
			lobbyViewUI.message_textinput.text = "";
			
		}
		
		//CONTEXT
		/**
		 * Handles the Signal: <code>MultiplayerConnectedSignal</code>.
		 * 
		 * @return void
		 * 
		 */
		private function _onMultiplayerConnected ():void
		{
			//	Presentation
			lobbyViewUI.isConnected 		= true;
			lobbyViewUI.statusMessage 		= "Connected.";
			
			
			//SO MOVE THIS CODE TO A COMMAND FOR 'multiplayerConnectedSignal'?
			if (multiplayerModel.currentRoom == null) {
				
				var roomName_str : String = lobbyViewUI.roomName_textinput.text;
				var userName_str : String = lobbyViewUI.userName_textinput.text;
				//
				multiplayerRoomSignal.dispatch(
					new MultiplayerRoomEvent (MultiplayerRoomEvent.JOIN, roomName_str, userName_str)
				);
				
			} else {
				multiplayerRoomSignal.dispatch(
					new MultiplayerRoomEvent (MultiplayerRoomEvent.LEAVE)
				);
			}
			
		}
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerDisconnected ():void
		{
			//	Presentation
			lobbyViewUI.isConnected 		= false;
			lobbyViewUI.statusMessage 	= "Disconnected.";	
		}
		
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomJoined ():void
		{
			//	Presentation
			lobbyViewUI.isJoined 		= true;	
			lobbyViewUI.statusMessage 	= "Room Joined.";
			
			var messageVO : MessageVO = new MessageVO ("Hello World!");
			_doSendMessage (messageVO);
			
			
		}
		
		//CONTEXT


		private function _onMultiplayerRoomOccupantCountChanged ():void
		{
			//CREATE A FRESH COPY OF THE USERS IN AN 'AC' FOR THE NON-INTERACTIVE LIST VIEW
			var dataProvider : ArrayCollection = new ArrayCollection ();
			for each (var user : UserVO in multiplayerModel.users) {
				dataProvider.addItem (user);
			}
			lobbyViewUI.users_list.dataProvider = dataProvider;
		}
		


		private function _onMultiplayerMessageReceived (aEvent : MultiplayerMessageEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 	= "Message Received.";
			
			//
			StyleableTextField(lobbyViewUI.output_textarea.textDisplay).htmlText += aEvent.messageVO.fromUsername + " : " + aEvent.messageVO.message;
			
		}
		
		/**
		 * Handles the Signal: <code>ChangedPhrasesModelSignal</code>.
		 * 
		 * @param aEvent <code>PhrasesModelEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onPhrasesModelChanged (aEvent : PhrasesModelEvent):void
		{
			lobbyViewUI.phrasesVO = aEvent.phrasesModel.phrasesVO;
			
		}
		
	}
}

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
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.events.NativeApplicationEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.flexmobile.NativeApplicationSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageReceivedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomJoinedSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerServerSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.phrases.LoadPhrasesModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerMessageEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerRoomEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerServerEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.phrases.PhrasesModelEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.phrases.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.LobbyViewUI;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import net.user1.logger.Logger;
	import net.user1.reactor.AttributeEvent;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
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
		 * Reference: <code>NativeApplicationSignal</code>
		 * 
		 */	
		[Inject]
		public var nativeApplicationSignal : NativeApplicationSignal;
		
		
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
		
		/**
		 * BEFORE CLICKING ANY BUTTONS WE SHOW THE USER: connect/join/sendmessage.
		 * 
		 */		
		private var _isAutomaticallyShowcasingFeatures_boolean:Boolean;
		
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
			lobbyViewUI.exitApplication_signal.add  		(_doExitApplication);
			//
			lobbyViewUI.joinRoom_signal.add  				(_doJoinRoom);
			lobbyViewUI.leaveRoom_signal.add  				(_doLeaveRoom);
			//
			lobbyViewUI.sendMessage_signal.add  			(_doSendMessage);
			
			//	Context Listeners
			phrasesModel.changedPhrasesModelSignal.add 							(_onPhrasesModelChanged);
			iMultiplayerService.multiplayerConnectedSignal.add 					(_onMultiplayerConnected);
			iMultiplayerService.multiplayerDisconnectedSignal.add 				(_onMultiplayerDisconnected);
			//
			iMultiplayerService.multiplayerRoomJoinedSignal.add 				(_onMultiplayerRoomJoined);
			iMultiplayerService.multiplayerRoomLeftSignal.add 					(_onMultiplayerRoomLeft);
			iMultiplayerService.multiplayerMessageReceivedSignal.add 			(_onMultiplayerMessageReceived);
			iMultiplayerService.multiplayerRoomOccupantAddedSignal.add 			(_onMultiplayerRoomOccupantAdded);
			iMultiplayerService.multiplayerRoomOccupantCountChangedSignal.add 	(_onMultiplayerRoomOccupantCountChanged);
			iMultiplayerService.multiplayerRoomOccupantRemovedSignal.add 		(_onMultiplayerRoomOccupantRemoved);
			iMultiplayerService.multiplayerRoomAttributeUpdatedSignal.add 		(_onMultiplayerRoomAttributeUpdated);
			
			//	Presentation (Binding)
			lobbyViewUI.statusMessage 	= "Preparing";
			lobbyViewUI.isConnected 	= false;
			lobbyViewUI.isJoined 		= false;
			lobbyViewUI.isAwaitingServer = false;
			_doResetUI();
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			loadPhrasesModelSignal.dispatch ();
			
			//  BEFORE CLICKING ANY BUTTONS WE SHOW THE USER A SERIES OF THINGS...: connect/join/sendmessage.
			_isAutomaticallyShowcasingFeatures_boolean = true;
			
			//	ONLY CONNECT HERE IF WE ARE NOT CONNECTED
			trace ("multiplayerModel.API.isReady() " + multiplayerModel.API.isReady());
			trace ("multiplayerModel.API.isReady() " + multiplayerModel.currentRoom);
			//if (multiplayerModel.API.isReady()
			_doMultiplayerConnect (null);
			
		}
		
		
		//VIEW
		/**
		 * Reset UI
		 * 
		 * @return void
		 * 
		 */
		private function _doResetUI ():void
		{
			lobbyViewUI.serverURL_textinput.text 	= Configuration.SERVER_URL_DEFAULT;
			lobbyViewUI.serverPort_textinput.text 	= Configuration.SERVER_PORT_DEFAULT.toString();
			lobbyViewUI.roomName_textinput.text 	= Configuration.ROOM_NAME_DEFAULT;
			lobbyViewUI.userName_textinput.text 	= Configuration.USER_NAME_DEFAULT + Math.round(Math.random()*1000);
			//
			StyleableTextField(lobbyViewUI.output_textarea.textDisplay).htmlText = "";
			lobbyViewUI.users_list.dataProvider = null;
			
			
			
		}
		
		
		
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
			
			//SET SOME CONFIGURATION
			multiplayerModel.API.getLog().setLevel(Logger.ERROR);
			lobbyViewUI.isAwaitingServer = true;
			
			//
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
			lobbyViewUI.statusMessage 		= "Disconnecting...";
			lobbyViewUI.isAwaitingServer 	= true;
			
			//
			multiplayerServerSignal.dispatch(
				new MultiplayerServerEvent (MultiplayerServerEvent.DISCONNECT) 
			);
		}
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doExitApplication (aEvent : MouseEvent):void
		{
			//
			nativeApplicationSignal.dispatch (new NativeApplicationEvent (NativeApplicationEvent.EXIT));
			
		}
		
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doJoinRoom (aEvent : MouseEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 		= "Joining Room.";
			lobbyViewUI.isAwaitingServer 	= true;
			
			//
			var roomName_str : String = lobbyViewUI.roomName_textinput.text;
			var userName_str : String = lobbyViewUI.userName_textinput.text;
			//
			multiplayerRoomSignal.dispatch(
				new MultiplayerRoomEvent (MultiplayerRoomEvent.JOIN, roomName_str, userName_str)
			);
			
		}
		
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doLeaveRoom (aEvent : MouseEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 		= "Leaving Room...";
			lobbyViewUI.isAwaitingServer 	= true;
			
			//
			multiplayerRoomSignal.dispatch(
				new MultiplayerRoomEvent (MultiplayerRoomEvent.LEAVE)
			);
			
		}
		
		/**
		 * Send a Message
		 *  
		 * @param aMessageVO
		 * 
		 * @return void
		 * 
		 */
		private function _doSendMessage (aMessageVO : MessageVO = null):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 		= "Sending Message.";
			lobbyViewUI.isAwaitingServer 	= true;
			
			//MESSAGE VO MAY OR MAY NOT BE SENT IN (DEPENDING ON SITUATION)
			var messageVO : MessageVO;
			if (aMessageVO) {
				messageVO = aMessageVO				
			} else {
				messageVO = new MessageVO (lobbyViewUI.message_textinput.text);
			}
			multiplayerMessageSignal.dispatch( new MultiplayerMessageEvent (MultiplayerMessageEvent.SEND, messageVO) );
			
			//CLEAR TEXT
			lobbyViewUI.message_textinput.text = "";
			
		}
		
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		//CONTEXT
		/**
		 * Handles the Signal: <code>MultiplayerConnectedSignal</code>.
		 * 
		 * @param aEvent <code>ReactorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerConnected (aEvent : ReactorEvent):void
		{
			//	Presentation
			lobbyViewUI.isConnected 		= true;
			lobbyViewUI.statusMessage 		= "Connected.";
			lobbyViewUI.isAwaitingServer 	= false;
			
			
			//SO MOVE THIS CODE TO A COMMAND FOR 'multiplayerConnectedSignal'?
			if (multiplayerModel.currentRoom == null) {
				
				_doJoinRoom(null);
				
			} else {
				_doLeaveRoom(null);
			}
			
		}
		
		/**
		 * Handles the Signal: <code>MultiplayerDisconnectedSignal</code>.
		 * 
		 * @param aEvent <code>ReactorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerDisconnected (aEvent : ReactorEvent):void
		{
			
			//	Presentation
			lobbyViewUI.isConnected 		= false;
			lobbyViewUI.isAwaitingServer 	= false;
			lobbyViewUI.statusMessage 		= "Disconnected.";	
			_doResetUI();
		}
		
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomJoinedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomJoined (aEvent : RoomEvent):void
		{
			//if (aEvent.getClient().isSelf()) {
			
			//	Presentation
			lobbyViewUI.statusMessage 		= "You Joined Room.";
			lobbyViewUI.isJoined 			= true;	
			lobbyViewUI.isAwaitingServer 	= false;
			
			var messageVO : MessageVO = new MessageVO ("Hello World!");
			_doSendMessage (messageVO);
			
			//} else {
			//	lobbyViewUI.statusMessage 	= "Other Joined Room.";
			//}
			
			//ROOMS CAN HAVE ATTRIBUTES THAT ALL USERS CAN ACCESS, SEND A TEST
			var isShared_boolean		: Boolean = true;	//DEFAULT
			var isPersistant_boolean	: Boolean = false;	//DEFAULT
			var isEvaluated_boolean		: Boolean = false;	//DEFAULT
			var testValue_str 			: String  = String(Math.round (Math.random()*1000))
			multiplayerModel.currentRoom.setAttribute("testAttribute", testValue_str, isShared_boolean, isPersistant_boolean, isEvaluated_boolean);
			
			
		}
		
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomJoinedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomLeft (aEvent : RoomEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 		= "You Left Room.";
			lobbyViewUI.isJoined 			= false;	
			lobbyViewUI.isAwaitingServer 	= false;
			
		}
		
		//CONTEXT
		/**
		 * Handles the Signal: <code>MultiplayerRoomOccupantCountChangedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomOccupantCountChanged (aEvent : RoomEvent):void
		{
			trace ("occupant");
			
			//
			//if ( (aEvent.target as Room).getClient( .isSelf()) {
			lobbyViewUI.statusMessage 	= "You Joined Room.";
			//} else {
			//	lobbyViewUI.statusMessage 	= "Other Joined Room.";
			//}
			
			//CREATE A FRESH COPY OF THE USERS IN AN 'AC' FOR THE NON-INTERACTIVE LIST VIEW
			var dataProvider : ArrayCollection = new ArrayCollection ();
			for each (var user : UserVO in multiplayerModel.users) {
				dataProvider.addItem (user);
			}
			lobbyViewUI.users_list.dataProvider = dataProvider;
		}
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomOccupantAddedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomOccupantAdded (aEvent : RoomEvent):void
		{
			trace ("added");
		}
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomOccupantRemovedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomOccupantRemoved (aEvent : RoomEvent):void
		{
			//
			trace ("removed");
		}
		
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomAttributeUpdatedSignal</code>.
		 * 
		 * @param aEvent <code>AttributeEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomAttributeUpdated (aEvent : AttributeEvent):void
		{
			//NOTE: The Multiplayer Framework sets many attributes we DON'T care about, so use an IF
			if (aEvent.getChangedAttr().name == "testAttribute") {
				lobbyViewUI.roomAttributes_textinput.text = multiplayerModel.currentRoom.getAttribute("testAttribute")
			}
			
		}
		
		
		/**
		 * Handles the Signal: <code>MultiplayerMessageReceivedSignal</code>.
		 * 
		 * @param aEvent <code>MultiplayerMessageEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerMessageReceived (aEvent : MultiplayerMessageEvent):void
		{
			//	Presentation
			lobbyViewUI.statusMessage 		= "Message Received.";
			lobbyViewUI.isAwaitingServer 	= false;
			
			//
			if (StyleableTextField(lobbyViewUI.output_textarea.textDisplay).htmlText.length == 0) {
				//FIRST LINE EVER
				StyleableTextField(lobbyViewUI.output_textarea.textDisplay).htmlText = aEvent.messageVO.fromUsername + " : " + aEvent.messageVO.message;
			} else {
				//OTHER LINES
				StyleableTextField(lobbyViewUI.output_textarea.textDisplay).htmlText += aEvent.messageVO.fromUsername + " : " + aEvent.messageVO.message;
			}
			
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

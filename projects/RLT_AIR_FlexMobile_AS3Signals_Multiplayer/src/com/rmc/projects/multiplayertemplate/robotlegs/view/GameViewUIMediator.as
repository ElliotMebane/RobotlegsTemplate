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
	import com.rmc.projects.multiplayertemplate.managers.AssetManager;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.events.ViewNavigatorEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.flexmobile.NativeApplicationSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.flexmobile.ViewNavigatorSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.message.MultiplayerMessageSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.room.MultiplayerRoomSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerServerSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.phrases.LoadPhrasesModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerMessageEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.phrases.PhrasesModelEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.phrases.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.MessageVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.GameViewUI;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.LobbyViewUI;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.sendToURL;
	import flash.utils.Timer;
	
	import net.user1.reactor.Attribute;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.RoomEvent;
	
	import org.osmf.events.TimeEvent;
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
	public class GameViewUIMediator extends Mediator
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
		public var gameViewUI : GameViewUI;
		
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
		 * Reference: <code>ViewNavigatorSignal</code>
		 * 
		 */	
		[Inject]
		public var viewNavigatorSignal : ViewNavigatorSignal;
		
		
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
		 * List - one dot drawn for each user
		 * 
		 */	
		private var _userSprites_vector:Vector.<UserSprite>;
		
		/**
		 * Every X seconds, broadcast the positions of the sprites
		 * 
		 */	
		private var _broadcastPositionsOfSpritesTimer:Timer;
		
		/**
		 * Determines if the current client is the host
		 * 
		 * NOTE: The host handles some extra responsibility
		 * 
		 */	
		private var _isHost_boolean:Boolean;
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function GameViewUIMediator()
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
			//	SUPER View Listeners
			gameViewUI.goToLobby_signal.add				(_onGoToLobby);
			
			// 	View Listeners
			
			//	Context Listeners
			phrasesModel.changedPhrasesModelSignal.add 							(_onPhrasesModelChanged);
			iMultiplayerService.multiplayerDisconnectedSignal.add 				(_onMultiplayerDisconnected);
			//
			iMultiplayerService.multiplayerRoomLeftSignal.add 					(_onMultiplayerRoomLeft);
			iMultiplayerService.multiplayerMessageReceivedSignal.add 			(_onMultiplayerMessageReceived);
			iMultiplayerService.multiplayerRoomOccupantAddedSignal.add 			(_onMultiplayerRoomOccupantAdded);
			iMultiplayerService.multiplayerRoomOccupantCountChangedSignal.add 	(_onMultiplayerRoomOccupantCountChanged);
			iMultiplayerService.multiplayerRoomOccupantRemovedSignal.add 		(_onMultiplayerRoomOccupantRemoved);
			iMultiplayerService.multiplayerRoomClientAttributeUpdatedSignal.add (_onMultiplayerRoomClientAttributeUpdatedSignal);
			
			//	Presentation (Binding)
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			loadPhrasesModelSignal.dispatch ();
			
			//	ONLY CONNECT HERE IF WE ARE NOT CONNECTED
			//if (!multiplayerModel.API.isReady()) {
			_isHost_boolean = false;
			_doCreateSpritesAndSetHost ();
			
			//ENTERFRAME WILL DRAW THE SPRITES
			gameViewUI.canvas.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			
			//THE TIMER (HOST ONLY) WILL SEND REAL POSITIONS TO ALL CLIENTS
			_broadcastPositionsOfSpritesTimer = new Timer (1000);
			_broadcastPositionsOfSpritesTimer.addEventListener(TimerEvent.TIMER, _onBroadcastPositionsOfSpritesTimer);
			_broadcastPositionsOfSpritesTimer.start();
			
		}
		
		
		//VIEW
		/**
		 * SHOW: Each player as sprite
		 * 
		 * @return void 
		 */
		private function _doCreateSpritesAndSetHost ():void
		{
			//CLEAR ANY KIDS
			gameViewUI.canvas.removeChildren();
			
			//CREATE A SPRITE PER PLAYER
			var userSprite : UserSprite;
			
			_userSprites_vector =  new Vector.<UserSprite>();
			var userSpriteData : UserSpriteData;
			var colorIndex_uint : uint = 0;
			var colors_array 	: Array = new Array (0x00FF00, 0x0000ff, 0xFF0000, 0xFF00FF, 0xF0F0F0);
			for each (var userVO : UserVO in multiplayerModel.users) {
				
				//SET A LOCAL VARIABLE 
				if (userVO.isMe) {
					_isHost_boolean = true;
				} else{
					_isHost_boolean = false;
				}
				
				colorIndex_uint ++;
				
				//move 'me' by enterframe, but others, no
				userSpriteData = new UserSpriteData (
					userVO.userName,
					colors_array[colorIndex_uint], 
					new Point (Math.random()*gameViewUI.canvas.width, Math.random()*gameViewUI.canvas.height),
					new Point (1,3)
				);
				//
				userSprite = new UserSprite(userVO,userSpriteData);
				
				//
				gameViewUI.canvas.addChild(userSprite);
				_userSprites_vector.push (userSprite);
			}
			
			_doDrawScoreboard ();
		}
		
		/**
		 * SHOW: Each player as sprite
		 * 
		 * @return void 
		 */
		private function _doMoveSprites ():void
		{
			//CREATE A SPRITE PER PLAYER
			for each (var userSprite : UserSprite in _userSprites_vector) {
				userSprite.doMove();
			}
			
		}
		
		/**
		 * SHOW: Each player as sprite
		 * 
		 * @return void 
		 */
		private function _doRenderSprites ():void
		{
			//CREATE A SPRITE PER PLAYER
			for each (var userSprite : UserSprite in _userSprites_vector) {
				userSprite.doRender();
			}
			
		}
		
		
		/**
		 * SHOW: Score per player in text
		 * 
		 * @return void 
		 */
		private function _doDrawScoreboard ():void
		{
			
			var scoreboard_str  : String = "";
			var scoreLine_str	: String = ""
			for each (var user : UserVO in multiplayerModel.users) {
				scoreLine_str = user.userName + "(0)    ";
				
				//ADD SPACING PER PLAYER AND SCORE
				if (scoreboard_str == "") {
					scoreboard_str = scoreLine_str;
				} else {
					scoreboard_str += scoreLine_str;
					
				}
			}
			StyleableTextField(gameViewUI.scoreboard_textarea.textDisplay).multiline = false;
			StyleableTextField(gameViewUI.scoreboard_textarea.textDisplay).htmlText = scoreboard_str;
			
		}
		
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onGoToLobby (aEvent : MouseEvent):void
		{
			//	CHANGE VIEW
			viewNavigatorSignal.dispatch(new ViewNavigatorEvent (ViewNavigatorEvent.POP_VIEW, LobbyViewUI, AssetManager.getViewTransition(ViewNavigatorEvent.PUSH_VIEW) ) );
			
		}
		
		
		/**
		 * Send a Message
		 *  
		 * @param aMessageVO
		 * 
		 * @return void
		 * 
		 */
		private function _doSendMessage (aMessageVO : MessageVO):void
		{
			multiplayerMessageSignal.dispatch( new MultiplayerMessageEvent (MultiplayerMessageEvent.SEND, aMessageVO) );
		}
		
		
		/**
		 * Send a Message
		 *  
		 * @param aMessageVO
		 * 
		 * @return void
		 * 
		 */
		private function _doSendMessageToUpdateUserSprite (aUserSprite : UserSprite):void
		{
			var messageVO:  MessageVO = new MessageVO (		aUserSprite.userSpriteData.serializeFor(aUserSprite.userVO) 	)	
			_doSendMessage (messageVO);
		}
		
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		//CONTEXT
		/**
		 * Handles the Event: <code>Event.ENTER_FRAME</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onEnterFrame (aEvent : Event):void
		{
			//ONLY HOST MOVES THEM
			if (_isHost_boolean) {
				_doMoveSprites();
			}
			_doRenderSprites();
		}
		
		/**
		 * Handles the Event: <code>TimerEvent.TIMER</code>.
		 * 
		 * @param aEvent <code>TimerEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onBroadcastPositionsOfSpritesTimer (aEvent : Event):void
		{
			//SEND MESSAGE WITH NEW POSITION
			if (_isHost_boolean) {
				//
				_doMoveSprites();
				//
				for each (var userSprite : UserSprite in _userSprites_vector) {
					_doSendMessageToUpdateUserSprite(userSprite);
				}
			}
		}
		
		/**
		 * Handles the Signal: <code>MultiplayerRoomClientAttributeUpdatedSignal</code>.
		 * 
		 * @param aEvent <code>RoomEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMultiplayerRoomClientAttributeUpdatedSignal (aEvent : RoomEvent):void
		{
			// Method invoked when any client in the room
			// changes the value of a shared attribute
			var changed_attribute:Attribute = aEvent.getChangedAttr();
			if (changed_attribute.name == UserSprite.DATA_ATTRIBUTE_NAME) {
				trace ("changed_attribute: " + changed_attribute.byClient);	
				trace ("changed_attribute: " + changed_attribute.name);	
				trace ("changed_attribute: " + changed_attribute.scope);	
				trace ("changed_attribute: " + changed_attribute.value);	
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
			throw new Error ("Game Dropped, why?");
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
			throw new Error ("Room Dropped, why?");
			
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
			_doCreateSpritesAndSetHost();
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
			_doCreateSpritesAndSetHost();
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
			_doCreateSpritesAndSetHost();
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
			//trace ("got message: " +  aEvent.messageVO.fromUserName + " : " + aEvent.messageVO.message);
			
			//DESERIALIZE
			var userSpriteData : UserSpriteData = UserSpriteData.deserialize (aEvent.messageVO.message);
			//trace ("userSpriteData");
			//trace (" " + userSpriteData.userName);
			//trace (" " + userSpriteData.color);
			//trace (" " + userSpriteData.position);
			//trace (" " + userSpriteData.velocity);
			
			//FIND CORRESPONDING SPRITE & UPDATE IT
			//CREATE A SPRITE PER PLAYER
			for each (var userSprite : UserSprite in _userSprites_vector) {
				if (userSprite.userVO.userName == userSpriteData.userName) {
					trace ("UPDATE: " + aEvent.messageVO.message);
					userSprite.userSpriteData = userSpriteData;
				}
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
			gameViewUI.phrasesVO = aEvent.phrasesModel.phrasesVO;
			
		}
		
	}
}

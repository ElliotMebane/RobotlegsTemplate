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
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.MultiplayerConnectSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.phrases.LoadPhrasesModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.multiplayer.MultiplayerConnectEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.phraes.PhrasesModelEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.services.multiplayer.IMultiplayerService;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.LobbyViewUI;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
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
		 * Signal: Marks a request to load the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var multiplayerConnectSignal : MultiplayerConnectSignal;
		
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
			lobbyViewUI.connectMultiplayer_signal.add  (_onConnectMultiplayer);
			lobbyViewUI.disconnectMultiplayer_signal.add  (_onDisconnectMultiplayer);
			
			//	Context Listeners
			phrasesModel.changedPhrasesModelSignal.add (_onPhrasesModelChanged);
			
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			loadPhrasesModelSignal.dispatch ();
			_onConnectMultiplayer (null);
			
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
		private function _onConnectMultiplayer (aEvent : MouseEvent):void
		{
			multiplayerConnectSignal.dispatch(new MultiplayerConnectEvent (MultiplayerConnectEvent.CONNECT, "tryunion.com", 80) );

		}
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onDisconnectMultiplayer (aEvent : MouseEvent):void
		{
			multiplayerConnectSignal.dispatch(new MultiplayerConnectEvent (MultiplayerConnectEvent.DISCONNECT) );
		}
		
		//CONTEXT
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
		
			//
			lobbyViewUI.phrasesVO = aEvent.phrasesModel.phrasesVO;
			
			//	DISPLAY STATIC TEXT
			//loadMessageViewUI.title						= loadMessageViewUI.phrasesVO.loadMessageViewTitle_str;
			//loadMessageViewUI.loadMessage_button.label 		= loadMessageViewUI.phrasesVO.loadMessageButtonLabel_str;
			//loadMessageViewUI.loadMessage_button.toolTip 	= loadMessageViewUI.phrasesVO.loadMessageButtonToolTip_str;
		}
		
	}
}
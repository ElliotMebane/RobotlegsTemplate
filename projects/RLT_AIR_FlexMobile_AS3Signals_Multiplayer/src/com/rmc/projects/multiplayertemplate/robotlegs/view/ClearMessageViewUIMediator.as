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
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.ClearMessageModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.multiplayer.server.MultiplayerServerSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.signals.phrases.LoadPhrasesModelSignal;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.multiplayer.union.MultiplayerModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.phrases.PhrasesModel;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.events.phraes.PhrasesModelEvent;
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.phrases.PhrasesVO;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.ClearMessageViewUI;
	import com.rmc.projects.multiplayertemplate.robotlegs.view.components.views.LobbyViewUI;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.supportClasses.StyleableTextField;
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>Mediator</code> managing the I/O to the UI: MainUI</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello (code [at] RivelloMultimediaConsulting [dot] com)</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * <p>CREATION DATE 	: Apr 05, 2010</p>
	 * 
	 * @example Here is a code example.  
	 * 
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
	 *
	 */
	public class ClearMessageViewUIMediator extends Mediator
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
		public var clearMessageViewUI : ClearMessageViewUI;
		
		/**
		 * Signal: Marks a request to clear the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var clearMessageModelSignal : ClearMessageModelSignal;
		
		/**
		 * Signal: Marks a request to load the <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var loadPhrasesModelSignal : LoadPhrasesModelSignal;
		
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
		public function ClearMessageViewUIMediator()
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
			clearMessageViewUI.clearMessageButtonClickNativeSignal.add (_onClearMessageButtonClick);
			
			//	Context Listeners
			phrasesModel.changedPhrasesModelSignal.add (_onPhrasesModelChanged);
			
			//	Clear Layout
			_onChangedMessageModelSignal (null);
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			loadPhrasesModelSignal.dispatch ();
			
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
		private function _onClearMessageButtonClick (aEvent : MouseEvent):void
		{
			clearMessageModelSignal.dispatch();
			
		}
		
		//CONTEXT
		/**
		 * Handles the Signal: <code>ChangedMessageModelSignal</code>.
		 * 
		 * @param String <code>aMessage</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onChangedMessageModelSignal (aMessage_str : String):void
		{
			
			//GRAB VALUE
			//aMessage_str = messageModel.message;
			
			//SET MESSAGE
			if (aMessage_str == null || aMessage_str == "") {
				
				//MOBILE REQUIRES SPECIAL TREATMENT TO RENDER HTML, BUT IT WORKS GREAT!
				StyleableTextField(clearMessageViewUI.textarea.textDisplay).htmlText = "";
				
				//
				clearMessageViewUI.clearMessage_button.enabled = false;
			} else {
				
				//MOBILE REQUIRES SPECIAL TREATMENT TO RENDER HTML, BUT IT WORKS GREAT!
				StyleableTextField(clearMessageViewUI.textarea.textDisplay).htmlText = aMessage_str;
				
				//
				clearMessageViewUI.clearMessage_button.enabled = true;
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
		private function _onPhrasesModelChanged (aEvent : PhrasesModelEvent):void
		{
			
			//INSTRUCTIONAL TRACE #3 OF 3
			trace ("ClearMessageViewUIMediator._onPhrasesModelChanged()");
			
			clearMessageViewUI.phrasesVO = aEvent.phrasesModel.phrasesVO;
			
			//	DISPLAY STATIC TEXT
			//clearMessageViewUI.title 						= clearMessageViewUI.phrasesVO.clearMessageViewTitle_str;
			//clearMessageViewUI.clearMessage_button.label 	= clearMessageViewUI.phrasesVO.clearMessageButtonLabel_str;
			//clearMessageViewUI.clearMessage_button.toolTip 	= clearMessageViewUI.phrasesVO.clearMessageButtonToolTip_str;
		}
		
	}
}
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
package com.rmc.projects.robotlegstemplate.view
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.controller.signals.ChangedMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.ChangedPhrasesModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.ClearMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.LoadMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.LoadPhrasesModelSignal;
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.model.vo.PhrasesVO;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	
	import flash.events.MouseEvent;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import org.robotlegs.mvcs.Mediator;

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
	public class MainUIMediator extends Mediator
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
		public var mainUI : MainUI;
		
		/**
		 * Signal: Marks a request to load the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var loadMessageModelSignal : LoadMessageModelSignal;
		
		/**
		 * Signal: Marks a request to clear the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var clearMessageModelSignal : ClearMessageModelSignal;
		
		/**
		 * Reference: <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var phrasesModel : PhrasesModel;
		
		/**
		 * Reference: <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var messageModel : MessageModel;
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MainUIMediator()
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
			mainUI.loadMessageButtonClickNativeSignal.add  (_onLoadMessageButtonClick);
			mainUI.clearMessageButtonClickNativeSignal.add (_onClearMessageButtonClick);
			
			//	Context Listeners
			messageModel.changedMessageModelSignal.add (_onChangedMessageModelSignal);
			phrasesModel.changedPhrasesModelSignal.add (_onPhrasesModelChanged);
			
			//	Clear Layout
			_onChangedMessageModelSignal (null);
			
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
		private function _onLoadMessageButtonClick (aEvent : MouseEvent):void
		{
			loadMessageModelSignal.dispatch();
		}
		
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
			//SET MESSAGE
			if (aMessage_str == null || aMessage_str == "") {
				//	FLEX 4 REQUIRES THIS FOR HTML TEXT DISPLAY
				mainUI.textarea.textFlow = TextConverter.importToFlow ("", TextConverter.TEXT_FIELD_HTML_FORMAT);
				mainUI.loadMessage_button.enabled = true;
				mainUI.clearMessage_button.enabled = false;
			} else {
				//	FLEX 4 REQUIRES THIS FOR HTML TEXT DISPLAY
				mainUI.textarea.textFlow = TextConverter.importToFlow(aMessage_str, TextConverter.TEXT_FIELD_HTML_FORMAT);
				mainUI.loadMessage_button.enabled = false;
				mainUI.clearMessage_button.enabled = true;
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
			trace ("MainUIMediator._onPhrasesModelChanged()");
			
			var phrasesVO : PhrasesVO = aEvent.phrasesModel.phrasesVO;
			
			//	DISPLAY STATIC TEXT
			mainUI.panel.title 					= phrasesVO.panelTitle_str;
			mainUI.loadMessage_button.label 		= phrasesVO.loadMessageButtonLabel_str;
			mainUI.loadMessage_button.toolTip 	= phrasesVO.loadMessageButtonToolTip_str;
			mainUI.clearMessage_button.label 	= phrasesVO.clearMessageButtonLabel_str;
			mainUI.clearMessage_button.toolTip 	= phrasesVO.clearMessageButtonToolTip_str;
		}
		
	}
}
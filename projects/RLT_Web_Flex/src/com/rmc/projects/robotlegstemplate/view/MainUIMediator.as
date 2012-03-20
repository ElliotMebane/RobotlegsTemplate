package com.rmc.projects.robotlegstemplate.view
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.events.MessageModelEvent;
	import com.rmc.projects.robotlegstemplate.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.model.vo.PhrasesVO;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	import com.rmc.projects.robotlegstemplate.view.events.SystemEvent;
	
	import flash.events.MouseEvent;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.validators.PhoneNumberValidator;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * <p>CLASS   : Mediator managing the I/O to the UI: MainUI</p>
	 * 
	 * <p>DATE    : Apr 05, 2010</p>
	 * <p>AUTHOR  : Samuel Asher Rivello  info [at] RivelloMultimediaConsulting [dot] com</p>
	 * <p>COMPANY : Rivello Multimedia Consulting. Adobe Flash and Flex Services of  
	 *              Software Architecture, Consulting, Development, and Training</p>
	 * 
	 * @example Here is a code example.  
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
	 *
	 * <span class="hide">Any hidden comments go here.</span>
	 *
	 */
	public class MainUIMediator extends Mediator
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the UI being mediated
		 * 
		 * @default null 
		 */	
		[Inject]
		public var mainUI : MainUI;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
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
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @return void
		 *
		 */
		override public function onRegister():void
		{
			
			// View Listeners
			eventMap.mapListener	(mainUI.loadMessage_button,		MouseEvent.CLICK,
				_onLoadMessageButtonClick);
			eventMap.mapListener	(mainUI.clearMessage_button, 	MouseEvent.CLICK,
				_onClearMessageButtonClick);
			
			// Context Listeners
			eventMap.mapListener	(eventDispatcher, 	
				MessageModelEvent.MESSAGE_MODEL_CHANGED, 	_onMessageModelChanged);
			eventMap.mapListener	(eventDispatcher, 	
				PhrasesModelEvent.PHRASES_MODEL_CHANGED, 	_onPhrasesModelChanged);
			
			//	CLEAR LAYOUT
			_onMessageModelChanged (null);
			
		}
		
		//VIEW
		/**
		 * Handles Event: UI Button Clicked
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent MouseEvent
		 *
		 * @return void
		 *
		 */
		private function _onLoadMessageButtonClick (aEvent : MouseEvent):void
		{
			eventDispatcher.dispatchEvent ( new SystemEvent (SystemEvent.LOAD_MESSAGE_MODEL) );

		}
		
		/**
		 * Handles Event: UI Button Clicked
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent MouseEvent
		 *
		 * @return void
		 *
		 */
		private function _onClearMessageButtonClick (aEvent : MouseEvent):void
		{
			eventDispatcher.dispatchEvent ( new SystemEvent (SystemEvent.CLEAR_MESSAGE_MODEL) );

		}

		//CONTEXT
		/**
		 * Handles Event: MessageModel Changed
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent MessageModelEvent
		 *
		 * @return void
		 *
		 */
		private function _onMessageModelChanged (aEvent : MessageModelEvent):void
		{
			//SET MESSAGE
			if (aEvent == null) {
				//	FLEX 4 REQUIRES THIS FOR HTML TEXT DISPLAY
				mainUI.textarea.textFlow = TextConverter.importToFlow ("", TextConverter.TEXT_FIELD_HTML_FORMAT);

			} else {
				//	FLEX 4 REQUIRES THIS FOR HTML TEXT DISPLAY
				mainUI.textarea.textFlow = TextConverter.importToFlow(aEvent.message, TextConverter.TEXT_FIELD_HTML_FORMAT);
			}
			
			//SET BUTTON ENABLED
			if (mainUI.textarea.text == "") {
				mainUI.loadMessage_button.enabled = true;
				mainUI.clearMessage_button.enabled = false;
			} else {
				mainUI.loadMessage_button.enabled = false;
				mainUI.clearMessage_button.enabled = true;
			}
		}
		
		/**
		 * Handles Event: PhrasesModel Changed
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @param aEvent PhrasesModelEvent
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
			mainUI.panel.title 		= phrasesVO.panelTitle_str;
			mainUI.loadMessage_button.label 	= phrasesVO.loadMessageButtonLabel_str;
			mainUI.loadMessage_button.toolTip 	= phrasesVO.loadMessageButtonToolTip_str;
			mainUI.clearMessage_button.label 	= phrasesVO.clearMessageButtonLabel_str;
			mainUI.clearMessage_button.toolTip 	= phrasesVO.clearMessageButtonToolTip_str;
		}
		
	}
}
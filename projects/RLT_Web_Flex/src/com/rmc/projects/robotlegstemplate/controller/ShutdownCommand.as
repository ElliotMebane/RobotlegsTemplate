package com.rmc.projects.robotlegstemplate.controller
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.services.ILoadService;
	import com.rmc.projects.robotlegstemplate.services.PhrasesLoadService;
	import com.rmc.projects.robotlegstemplate.view.MainUIMediator;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	
	import org.robotlegs.mvcs.Command;
	import com.rmc.projects.robotlegstemplate.view.events.SystemEvent;
	
	/**
	 * <p>CLASS   : Command: Handles the shutdown of the application. (Importance is TBD)</p>
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
	public class ShutdownCommand extends Command
	{
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Execute the command
		 * 
		 * <span class="hide">This text is hidden.</span>
		 *
		 * @return void
		 *
		 */
		override public function execute():void
		{
			/*
			
				REGULARLY CHECK THAT THIS MATCHES 
					(THE REVERSE OF WHAT IS SETUP IN) THE STARTUP COMMAND
			
			*/

			// Model
			injector.unmap (MessageModel);
			injector.unmap (PhrasesModel);

			// View
			mediatorMap.unmapView (MainUI);
			
			// Controller
			commandMap.unmapEvent(SystemEvent.LOAD_MESSAGE_MODEL, LoadMessageCommand);
			commandMap.unmapEvent(SystemEvent.LOAD_PHRASES_MODEL, LoadPhrasesCommand);
			
			// Services
			injector.unmap (ILoadService, "PhrasesLoadService");

		}
	}
}
package com.rmc.projects.robotlegstemplate.controller
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.events.MessageModelEvent;
	import com.rmc.projects.robotlegstemplate.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.services.ILoadService;
	import com.rmc.projects.robotlegstemplate.services.PhrasesLoadService;
	import com.rmc.projects.robotlegstemplate.view.MainUIMediator;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	import com.rmc.projects.robotlegstemplate.view.events.SystemEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * <p>CLASS   : Command: Starting up the application this kicks off the whole RL experience</p>
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
	public class StartupCommand extends Command
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

			//	Model
			var phrasesModel : PhrasesModel = new PhrasesModel(); 	//Instantiated manually so I can set a default value (langcode)
			phrasesModel.langCode 			= PhrasesModel.EN;
			//
			injector.mapValue		(PhrasesModel, phrasesModel);
			//
			injector.mapSingleton	(MessageModel);					//Instantiated automatically by RL			

			//	View
			mediatorMap.mapView		(MainUI, MainUIMediator);
			
			//	Controller
			commandMap.mapEvent		(SystemEvent.LOAD_MESSAGE_MODEL, 	LoadMessageCommand);
			commandMap.mapEvent		(SystemEvent.CLEAR_MESSAGE_MODEL, 	ClearMessageCommand);
			commandMap.mapEvent		(SystemEvent.LOAD_PHRASES_MODEL, 	LoadPhrasesCommand);
			
			//	Services
			injector.mapSingletonOf (ILoadService, PhrasesLoadService, "PhrasesLoadService");
			
			//	Load All Phrases (Must happen last in this method!)
			eventDispatcher.dispatchEvent	( new SystemEvent (SystemEvent.LOAD_PHRASES_MODEL) );
		}

	}
}
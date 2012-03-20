package com.rmc.projects.robotlegstemplate.controller
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.model.events.PhrasesModelEvent;
	import com.rmc.projects.robotlegstemplate.services.ILoadService;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * <p>CLASS   : Command: Loading the display text for the application</p>
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
	public class LoadPhrasesCommand extends Command
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		/**
		 * Reference to the service to load the display phrases
		 * 
		 * @default null 
		 */	
		[Inject (name="PhrasesLoadService")]
		public var phrasesLoadService : ILoadService;
		
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
			phrasesLoadService.load();
				
		}
	}
}
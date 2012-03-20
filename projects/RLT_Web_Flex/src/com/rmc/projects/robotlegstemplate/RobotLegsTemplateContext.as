package com.rmc.projects.robotlegstemplate
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.controller.LoadPhrasesCommand;
	import com.rmc.projects.robotlegstemplate.controller.ShutdownCommand;
	import com.rmc.projects.robotlegstemplate.controller.StartupCommand;
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.services.ILoadService;
	import com.rmc.projects.robotlegstemplate.services.PhrasesLoadService;
	import com.rmc.projects.robotlegstemplate.view.MainUIMediator;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	import com.rmc.projects.robotlegstemplate.view.events.SystemEvent;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 * <p>CLASS   : The Context is the 'glue' or 'brains of the application 
	 * 			    linking together the Model, View, Controller, and Services</p>
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
	public class RobotLegsTemplateContext extends Context
	{
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function RobotLegsTemplateContext()
		{
			super();
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Automatically called as the class initialization occurs
		 * 
		 * @return void
		 *
		 */
		override public function startup() : void
		{
			//INSTRUCTIONAL TRACE #2 OF 3
			trace ("RobotLegsTemplateContext.startup()");
			
			//  The StartupCommand encapsulates all the setup. 
			//  Typically this excecutes just one time in the life of the application.
			commandMap.mapEvent (ContextEvent.STARTUP,  StartupCommand);
			commandMap.mapEvent (ContextEvent.SHUTDOWN, ShutdownCommand);
			dispatchEvent( new ContextEvent( ContextEvent.STARTUP ) );
		}
		
	}
}
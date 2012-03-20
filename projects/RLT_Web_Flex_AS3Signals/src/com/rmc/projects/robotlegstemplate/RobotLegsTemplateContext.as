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
package com.rmc.projects.robotlegstemplate
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.robotlegstemplate.controller.ClearMessageCommand;
	import com.rmc.projects.robotlegstemplate.controller.LoadMessageCommand;
	import com.rmc.projects.robotlegstemplate.controller.LoadPhrasesCommand;
	import com.rmc.projects.robotlegstemplate.controller.ShutdownCommand;
	import com.rmc.projects.robotlegstemplate.controller.StartupCommand;
	import com.rmc.projects.robotlegstemplate.controller.signals.ChangedMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.ChangedPhrasesModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.ClearMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.LoadMessageModelSignal;
	import com.rmc.projects.robotlegstemplate.controller.signals.LoadPhrasesModelSignal;
	import com.rmc.projects.robotlegstemplate.model.MessageModel;
	import com.rmc.projects.robotlegstemplate.model.PhrasesModel;
	import com.rmc.projects.robotlegstemplate.services.ILoadService;
	import com.rmc.projects.robotlegstemplate.services.PhrasesLoadService;
	import com.rmc.projects.robotlegstemplate.view.MainUIMediator;
	import com.rmc.projects.robotlegstemplate.view.components.MainUI;
	
	import flash.events.Event;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.SignalContext;
	
	/**
	 * <p>The Context is the 'glue' or 'brains of the application 
	 * 			    linking together the Model, View, Controller, and Services</p>
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
	public class RobotLegsTemplateContext extends SignalContext
	{
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function RobotLegsTemplateContext ()
		{
			super();
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		
		//--------------------------------------
		//  Methods
		//--------------------------------------		
		//PUBLIC	
		/**
		 * Start the application. Map model, view, controller concerns and kickoff the first event.
		 * 
		 * @return void
		 * 
		 */
		override public function startup() : void
		{
			
			//INSTRUCTIONAL TRACE #2 OF 3
			trace ("RobotLegsTemplateContext.startup()");
			
			//Do in this order so the injections and references work well
			_startupModel();        //1
			_startupServices();     //2
			_startupController();   //3
			_startupView();         //4
			
			// And we're done
			super.startup();
			dispatchEvent(new Event (ContextEvent.STARTUP));
			
		}
		
		/**
		 * Map: Model
		 * 
		 * @return void
		 * 
		 */
		protected function _startupModel() : void
		{	
			//	Model
			var phrasesModel : PhrasesModel = new PhrasesModel(); 	//Instantiated manually so I can set a default value (langcode)
			phrasesModel.langCode 			= PhrasesModel.EN;
			injector.mapValue		(PhrasesModel, phrasesModel);
			injector.mapSingleton	(MessageModel);					//Instantiated automatically by RL	
			
			//SIGNALS SETUP WITHIN THIS CONTEXT - 1 OF 2: SIGNALS THAT ARE *NOT* MAPPED TO COMMANDS, BUT JUST OBSERVED DIRECTLY
			//b. RESPONSES
			//injector.mapSingleton(Some_signal_class); //not needed in our example
			
		}
		
		
		/**
		 * Map: View
		 * 
		 * @return void
		 * 
		 */
		protected function _startupView() : void
		{
			
			mediatorMap.mapView		(MainUI, MainUIMediator);
			
		}
		
		/**
		 * Map: Controller
		 * 
		 * @return void
		 * 
		 */
		protected function _startupController() : void
		{
			
			//SIGNALS SETUP WITHIN THIS CONTEXT - 2 OF 2: SIGNALS THAT ARE MAPPED TO COMMANDS
			//a. REQUESTS
			signalCommandMap.mapSignalClass(LoadMessageModelSignal,		LoadMessageCommand);
			signalCommandMap.mapSignalClass(ClearMessageModelSignal,     ClearMessageCommand);
			signalCommandMap.mapSignalClass(LoadPhrasesModelSignal,   	LoadPhrasesCommand);
			//
			commandMap.mapEvent 		(ContextEvent.STARTUP,  StartupCommand);
			commandMap.mapEvent 		(ContextEvent.SHUTDOWN, ShutdownCommand);
		}
		
		/**
		 * Map: Services
		 * 
		 * @return void
		 * 
		 */
		protected function _startupServices() : void
		{	
			
			injector.mapSingletonOf (ILoadService, PhrasesLoadService, "PhrasesLoadService");
			
		}
		
	}
}
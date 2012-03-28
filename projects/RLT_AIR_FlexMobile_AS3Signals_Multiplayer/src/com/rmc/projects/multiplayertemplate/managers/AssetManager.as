package com.rmc.projects.multiplayertemplate.managers
{
	import com.rmc.projects.multiplayertemplate.robotlegs.controller.events.ViewNavigatorEvent;
	
	import spark.transitions.CrossFadeViewTransition;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionBase;
	import spark.transitions.ViewTransitionDirection;
	
	public class AssetManager
	{
		public function AssetManager()
		{
		}
		
		public static function getViewTransition (aViewNavigatorEventType_str : String) : ViewTransitionBase
		{
			
			/*
			
			var flipTrans:FlipViewTransition = new FlipViewTransition();
			flipTrans.direction = ViewTransitionDirection.UP;
			flipTrans.mode = FlipViewTransitionMode.CUBE; //or CARD mode
			navigator.pushView(SampleZoom,null,null,flipTrans);
			
			var zoomTrans:ZoomViewTransition = new ZoomViewTransition();
			zoomTrans.direction = ViewTransitionDirection.RIGHT;
			zoomTrans.mode = ZoomViewTransitionMode.IN; //or OUT mode
			navigator.popToFirstView(zoomTrans);
			
			var slideTrans:SlideViewTransition = new SlideViewTransition();
			slideTrans.direction = ViewTransitionDirection.DOWN;
			slideTrans.mode = SlideViewTransitionMode.UNCOVER;  //or COVER and PUSH modes
			navigator.pushView(SampleZoom,null,null,slideTrans);
			
			var fadeTrans:CrossFadeViewTransition = new CrossFadeViewTransition();
			fadeTrans.direction = ViewTransitionDirection.LEFT;
			// no modes are available for CrossFadeViewTransition
			navigator.pushView(SampleZoom,null,null,fadeTrans);
			
			*/
			
			
			if (true) {
				
				var viewTransition:SlideViewTransition = new SlideViewTransition();
				
				//USE DIFFERENT DIRECTION FOR POP VS PUSH
				if (aViewNavigatorEventType_str == ViewNavigatorEvent.POP_VIEW) {
					viewTransition.direction 	= ViewTransitionDirection.RIGHT;
				} else {
					viewTransition.direction 	= ViewTransitionDirection.LEFT;
					
				}
				
				viewTransition.mode 			= SlideViewTransitionMode.PUSH;  //UNCOVER, or COVER and PUSH modes
				return viewTransition;
				
			} else {
				
				var viewTransition : CrossFadeViewTransition = new CrossFadeViewTransition ();
				viewTransition.duration = 200;
				viewTransition.transitionControlsWithContent = true;
				return viewTransition;
				
			}
			
		}
	}
}
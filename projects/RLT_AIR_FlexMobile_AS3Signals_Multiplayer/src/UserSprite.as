/**
 * Copyright (C) 2005-2012 by Rivello Multimedia Consulting (RMC).                    
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
// Marks the right margin of code *******************************************************************
package
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.multiplayertemplate.robotlegs.model.vo.multiplayer.UserVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This <code>UserSprite</code> is designed to...</p>
	 * 
	 */
	public class UserSprite extends Sprite
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		 *  
		 */		
		private var _userSpriteData : UserSpriteData;
		public function get userSpriteData () 					: UserSpriteData 	{ return _userSpriteData; }
		public function set userSpriteData (aValue : UserSpriteData) 	: void 		{ 
			_userSpriteData = aValue; 
			color = _userSpriteData.color;
		}
		
		/**
		 *  
		 */		
		public function get color () 					: uint 	{ return _userSpriteData.color; }
		public function set color (aValue : uint) 	: void 		{ 
			_userSpriteData.color = aValue; 
			
			//redraw
			graphics.clear();
			graphics.beginFill(_userSpriteData.color);
			graphics.drawCircle(-5, -5, 10);
			graphics.endFill();
			
		}
		

		/**
		 *  
		 */		
		private var _userVO : UserVO;
		public function get userVO () 					: UserVO 	{ return _userVO; }
		public function set userVO (aValue : UserVO) 	: void 		{ _userVO = aValue; }
		
		// PUBLIC CONST
		/**
		 * 
		 */		
		public static var DATA_ATTRIBUTE_NAME:String = "USER_SPRITE_DATA_ATTRIBUTE_NAME";
		
		// PRIVATE
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function UserSprite(aUserVO : UserVO, aUserSpriteData : UserSpriteData)
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			userVO 			= aUserVO;
			userSpriteData 	= aUserSpriteData;
			
			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * UPDATE A DESIRED POSITION, BUT DON'T 'MOVE' THERE YET
		 * 
		 */
		public function doMove () : void
		{
			userSpriteData.position.x += userSpriteData.velocity.x;
			userSpriteData.position.y += userSpriteData.velocity.y;

			if (userSpriteData.position.x > parent.width) {
				userSpriteData.position.x = 0;
			} if (userSpriteData.position.y > parent.height) {
				userSpriteData.position.y = 0;
			}
			
		}
		
		/**
		 * UPDATE VISUALS TO MATCH THE DESIRED POSITION
		 * 
		 * 
		 */
		public function doRender () : void
		{
			x = userSpriteData.position.x;
			y = userSpriteData.position.y;
			trace ("render: " + x + "," + y);
			
		}
		
		// PRIVATE
		
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------

		
	}
}
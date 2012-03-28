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
	import flash.geom.Point;
	
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This <code>UserSpriteData</code> is designed to...</p>
	 * 
	 */
	public class UserSpriteData extends Sprite
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		 *  
		 */		
		private var _userNname_str : String;
		public function get userName () 					: String 	{ return _userNname_str; }
		public function set userName (aValue : String) 		: void 		{ _userNname_str = aValue; }
		
		/**
		 *  
		 */		
		private var _nextPosition : Point;
		public function get position () 					: Point 	{ return _nextPosition; }
		public function set position (aValue : Point) 	: void 		{ _nextPosition = aValue; }
		
		/**
		 *  
		 */		
		private var _velocity : Point;
		public function get velocity () 					: Point 	{ return _velocity; }
		public function set velocity (aValue : Point) 	: void 		{ _velocity = aValue; }
		
		/**
		 *  
		 */		
		private var _color : uint;
		public function get color () 					: uint 	{ return _color; }
		public function set color (aValue : uint) 	: void 		{ 
			_color = aValue; 
		}
		
		// PUBLIC CONST
		
		// PRIVATE
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function UserSpriteData(aUserName_str : String, aColor_uint : uint, aPosition_point : Point, aVelocity_point : Point)
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			userName = aUserName_str
			color = aColor_uint;
			position = aPosition_point;
			velocity = aVelocity_point;
			
			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * Here we take the properties of a userspritedata and pack them into a small string (to send to server)
		 * 
		 * @return 
		 * 
		 */		
		public function serializeFor (userVO : UserVO) : String
		{
			//u,c,p1,p2,v1,v2     EXAMPLE     sammy123,ffffff,10,20,5,-2
			var serialized_str : String = userVO.userName + "," + color + "," + position.x + "," + position.y + "," + velocity.x + "," + velocity.y + ",";
			return serialized_str;
		}
		
		//	PUBLIC STATIC
		/**
		 * Here we take a string (from server) and convert it back into the data that describes a UserSprite
		 *  
		 * @param aSerialized_str
		 * 
		 * @return UserSpriteData
		 * 
		 */		
		public static function deserialize (aSerialized_str : String) : UserSpriteData
		{
			var properties_array : Array 		= aSerialized_str.split(",");
			//
			var name_str : String 				= (properties_array[0]);
			var color_uint : uint 				= uint (properties_array[1]);
			var postition_point : Point 		= new Point (	Number (properties_array[2]), Number(properties_array[3])	);
			var velocity_point : Point 			= new Point (	Number(properties_array[4]), Number(properties_array[5])	);
			var userSpriteData : UserSpriteData = new UserSpriteData (name_str, color_uint, postition_point, velocity_point);
			
			return userSpriteData;
		}
		
		
		// PRIVATE
		
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		
		
	}
}
package com.collectivecolors.emvc.patterns.extension
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.emvc.interfaces.IExtension;
  import com.collectivecolors.emvc.patterns.observer.ExtensibleNotifier;
  
  //----------------------------------------------------------------------------
  
  public class Extension extends ExtensibleNotifier implements IExtension
  {
    //--------------------------------------------------------------------------
    // Constants
    
    public static var NAME : String = 'extension';
		
		//--------------------------------------------------------------------------
		// Properties
		
		protected var extensionName : String;
		
		//--------------------------------------------------------------------------
		// Constructor
		
		/**
		 * Constructor
		 */
		public function Extension( extensionName : String = null ) 
		{
			super( );
			
			this.extensionName = ( extensionName != null ? extensionName : NAME ); 
		}
		
		//--------------------------------------------------------------------------
		// Extension information

		/**
		 * Get the <code>Extension</code> name
		 */
		public function getExtensionName( ) : String 
		{
			return extensionName;
		}		
		
		//--------------------------------------------------------------------------
		// Extension workflow
		
		/**
		 * Called by the <code>ExtensionManager</code> when the <code>Extension</code> is registered
		 */ 
		public function onRegister( ) : void 
		{
		  
		}

		/**
		 * Called by the <code>ExtensionManager</code> when the <code>Extension</code> is removed
		 */ 
		public function onRemove( ) : void 
		{
		  
		}		
  }
}
package com.collectivecolors.emvc.interfaces
{
  public interface IExtension
  {
    //--------------------------------------------------------------------------
    // Extension information
    
    /**
		 * Get the <code>Extension</code> name
		 * 
		 * @return the <code>Extension</code> instance name
		 */
		function getExtensionName( ) : String;
		
		//--------------------------------------------------------------------------
		// Extension workflow
		
		/**
		 * Called by the <code>ExtensionManager</code> when the <code>Extension</code> is registered
		 */ 
		function onRegister( ) : void;

		/**
		 * Called by the <code>ExtensionManager</code> when the <code>Extension</code> is removed
		 */ 
		function onRemove( ) : void;
  }
}
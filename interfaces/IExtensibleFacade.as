package com.collectivecolors.emvc.interfaces
{
  //----------------------------------------------------------------------------
  // Imports
  
  import org.puremvc.as3.interfaces.IFacade;
  
  //----------------------------------------------------------------------------
  
  public interface IExtensibleFacade extends IFacade
  {
    //--------------------------------------------------------------------------
    // Initialization methods
    
    /**
		 * Main application startup method.
		 * 
		 * @param application the application object
		 */
		function startup( application : Object ) : void;
    
    /**
		 * Main application shutdown method.
		 */
		function shutdown( ) : void;
		
    //--------------------------------------------------------------------------
    // Extension methods
    
    /**
		 * List all registered <code>IExtension</code> instances.
		 * 
		 * @return array containing all registered <code>IExtension</code> instances.
		 */
		function listExtensions( ) : Array;
    
    /**
		 * Register an <code>IExtension</code> with the <code>ExtensionManager</code> by name.
		 * 
		 * @param extension the <code>IExtension</code> to be registered with the <code>ExtensionManager</code>.
		 */
		function registerExtension( extension : IExtension ) : void;

		/**
		 * Retrieve a <code>IExtension</code> from the <code>ExtensionManager</code> by name.
		 * 
		 * @param extensionName the name of the <code>IExtension</code> instance to be retrieved.
		 * @return the <code>IExtension</code> previously regisetered by <code>extensionName</code> with the <code>ExtensionManager</code>.
		 */
		function retrieveExtension( extensionName : String ) : IExtension;
		
		/**
		 * Remove an <code>IExtension</code> instance from the <code>ExtensionManager</code> by name.
		 *
		 * @param extensionName the <code>IExtension</code> to remove from the <code>ExtensionManager</code>.
		 * @return the <code>IExtension</code> that was removed from the <code>ExtensionManager</code>
		 */
		function removeExtension( extensionName : String ) : IExtension;

		/**
		 * Check if a <code>IExtension</code> is registered
		 * 
		 * @param extensionName the <code>IExtension</code> to check for in the <code>ExtensionManager</code>.
		 * @return whether a <code>IExtension</code> is currently registered with the given <code>extensionName</code>.
		 */
		function hasExtension( extensionName : String ) : Boolean;
				
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		function executeMethod( methodName : String, ... args ) : *;
		
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		function executeContextMethod( contextName : String, 
		                               methodName : String, 
		                               ... args ) : *;
  }
}
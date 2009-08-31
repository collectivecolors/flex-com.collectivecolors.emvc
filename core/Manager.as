package com.collectivecolors.emvc.core
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.emvc.interfaces.IContext;
  import com.collectivecolors.emvc.interfaces.IExtension;
  import com.collectivecolors.emvc.interfaces.IManager;
  
  //----------------------------------------------------------------------------
  
  public class Manager implements IManager
  {
    //--------------------------------------------------------------------------
    // Constants
    
		protected const SINGLETON_MSG	: String = "Manager Singleton already constructed!";
    
    //--------------------------------------------------------------------------
		// Properties

		protected var extensionMap : Object;
    
		// Singleton instance
		protected static var instance : IManager;
						
    //--------------------------------------------------------------------------
    // Constructor
    		
		/**
		 * <code>Manager</code> Singleton Factory method.
		 * 
		 * @return the Singleton instance
		 */
		public static function getInstance( ) : IManager 
		{
			if ( instance == null ) instance = new Manager( );
			return instance;
		}
		
    /**
		 * Constructor. 
		 * 
		 * <P>
		 * This <code>IManager</code> implementation is a Singleton, 
		 * so you should not call the constructor 
		 * directly, but instead call the static Singleton 
		 * Factory method <code>Manager.getInstance()</code>
		 * 
		 * @throws Error Error if Singleton instance has already been constructed
		 * 
		 */
		public function Manager( )
		{
			if ( instance != null ) throw Error( SINGLETON_MSG );
			
			instance     = this;
			extensionMap = new Object( );	
			
			initializeManager( );	
		}
		
		//--------------------------------------------------------------------------
		// Initialization
		
		/**
		 * Initialize the Singleton <code>Manager</code> instance.
		 * 
		 * <P>
		 * Called automatically by the constructor, this
		 * is your opportunity to initialize the Singleton
		 * instance in your subclass without overriding the
		 * constructor.</P>
		 * 
		 * @return void
		 */
		protected function initializeManager(  ) : void 
		{
		  
		}
		
		//--------------------------------------------------------------------------
		// Extension methods
    
		/**
		 * List all registered <code>IExtension</code> instances.
		 * 
		 * @return array containing all registered <code>IExtension</code> instances.
		 */
		public function listExtensions( ) : Array
		{
		  var extensions : Array = new Array( );
		  
		  for ( var extensionName : String in extensionMap ) 
		  {
		    extensions.push( extensionMap[ extensionName ] );
		  }
		  
		  return extensions;
		}
		
		/**
		 * Register an <code>IExtension</code> with the <code>ExtensionManager</code> by name.
		 * 
		 * @param extension the <code>IExtension</code> to be registered with the <code>ExtensionManager</code>.
		 */
		public function registerExtension( extension : IExtension ) : void
		{
			extensionMap[ extension.getExtensionName( ) ] = extension;
			extension.onRegister( );
		}

		/**
		 * Retrieve a <code>IExtension</code> from the <code>ExtensionManager</code> by name.
		 * 
		 * @param extensionName the name of the <code>IExtension</code> instance to be retrieved.
		 * @return the <code>IExtension</code> previously regisetered by <code>extensionName</code> with the <code>ExtensionManager</code>.
		 */
		public function retrieveExtension( extensionName : String ) : IExtension
		{
			return extensionMap[ extensionName ];
		}

		/**
		 * Remove an <code>IExtension</code> instance from the <code>Manager</code> by name.
		 *
		 * @param extensionName the <code>IExtension</code> to remove from the <code>ExtensionManager</code>.
		 * @return the <code>IExtension</code> that was removed from the <code>ExtensionManager</code>
		 */
		public function removeExtension( extensionName : String ) : IExtension
		{
			// Get the existing extension instance.
			var extension : IExtension = extensionMap[ extensionName ];
			
			if ( extension ) 
			{
				delete extensionMap[ extensionName ];
				extension.onRemove();
			}
			
			return extension;
		}
		
		/**
		 * Check if a <code>IExtension</code> is registered
		 * 
		 * @param extensionName the <code>IExtension</code> to check for in the <code>ExtensionManager</code>.
		 * @return whether a <code>IExtension</code> is currently registered with the given <code>extensionName</code>.
		 */
		public function hasExtension( extensionName : String ) : Boolean
		{
			return extensionMap.hasOwnProperty( extensionName );
		}
		
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		public function executeMethod( methodName : String, args : Array = null ) : *
		{
		  return executeContextMethod( null, methodName, args );
		}
		
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		public function executeContextMethod( contextName : String, 
		                                      methodName : String, 
		                                      args : Array = null ) : *
		{
		  var context : IContext;
		  var extensions : Array;
		  
		  var values : Object = new Object( );
		  
		  // Get extensions to invoke method on.
		  if ( ! contextName ) 
		  {
		    extensions = listExtensions( );
		  }
		  else if ( extensionMap.hasOwnProperty( contextName ) 
		      && extensionMap[ contextName ] is IContext ) 
		  {		    
		    context    = extensionMap[ contextName ];		    
		    extensions = context.filterExtensions( extensionMap );
		  }
		  
		  // Invoke method on selected extensions ( if they implement the method ).
		  if ( extensions && extensions.length ) 
		  {
		    for each ( var extension : IExtension in extensions )
		    {
		      var method : Function = extension[ methodName ];
		      
		      if ( method != null )
		      {
		        values[ extension.getExtensionName( ) ] = method.apply( extension, args );
		      }
		    }
		  }
		  
		  if ( context )
		  {
		    return context.returnValues( values );
		  }
		  
		  return values;
		}
  }
}